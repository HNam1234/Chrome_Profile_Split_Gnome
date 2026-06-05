#!/usr/bin/env bash
set -euo pipefail

app_dir="$HOME/.local/share/chrome-dock-profiles"
bin_dir="$HOME/.local/bin"
desktop_file="$HOME/.local/share/applications/chrome-dock-profiles.desktop"
new_desktop_file="$HOME/.local/share/applications/linux-toolbox.desktop"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$app_dir" "$bin_dir" "$HOME/.local/share/applications"
cp "$script_dir/chrome_dock_profiles.py" "$app_dir/chrome_dock_profiles.py"
rm -rf "$app_dir/src"
cp -a "$script_dir/src" "$app_dir/src"
chmod +x "$app_dir/chrome_dock_profiles.py"

write_launcher() {
  local target="$1"
  cat > "$target" <<EOF
#!/usr/bin/env bash
set -e

if command -v python3.10 >/dev/null 2>&1; then
  exec python3.10 "$app_dir/chrome_dock_profiles.py" "\$@"
fi

exec python3 "$app_dir/chrome_dock_profiles.py" "\$@"
EOF
  chmod +x "$target"
}

write_launcher "$bin_dir/chrome-dock-profiles"
write_launcher "$bin_dir/linux-toolbox"

cat > "$new_desktop_file" <<EOF
[Desktop Entry]
Version=1.0
Name=Linux Toolbox
Comment=Set-and-forget Ubuntu tools for Chrome profiles, dock, clipboard, and mouse movement
Exec=$bin_dir/linux-toolbox
Terminal=false
Type=Application
Categories=Utility;
Icon=applications-utilities
EOF
rm -f "$desktop_file"

update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
echo "Installed. Open 'Linux Toolbox' from Applications, or run:"
echo "$bin_dir/linux-toolbox"
echo "Compatibility command kept: $bin_dir/chrome-dock-profiles"
