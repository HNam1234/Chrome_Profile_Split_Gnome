#!/usr/bin/env bash
set -u

if ! pgrep -x copyq >/dev/null 2>&1; then
  copyq >/dev/null 2>&1 &
  for _ in 1 2 3 4 5 6 7 8 9 10; do
    pgrep -x copyq >/dev/null 2>&1 && break
    sleep 0.2
  done
fi

copyq config item_popup_interval 0 >/dev/null 2>&1 || true
exec copyq toggle
