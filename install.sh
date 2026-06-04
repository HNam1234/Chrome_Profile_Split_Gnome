#!/usr/bin/env bash
set -euo pipefail

app_dir="$HOME/.local/share/chrome-dock-profiles"
desktop_file="$HOME/.local/share/applications/chrome-dock-profiles.desktop"

mkdir -p "$app_dir" "$HOME/.local/share/applications"
cp "$(dirname "$0")/chrome_dock_profiles.py" "$app_dir/chrome_dock_profiles.py"
chmod +x "$app_dir/chrome_dock_profiles.py"

cat > "$desktop_file" <<EOF
[Desktop Entry]
Version=1.0
Name=Chrome Dock Profiles
Comment=Install separate Ubuntu Dock icons for Chrome profiles
Exec=$app_dir/chrome_dock_profiles.py
Terminal=false
Type=Application
Categories=Utility;
Icon=google-chrome
EOF

update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
echo "Installed. Open 'Chrome Dock Profiles' from Applications, or run:"
echo "$app_dir/chrome_dock_profiles.py"
