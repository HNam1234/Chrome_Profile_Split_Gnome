#!/usr/bin/env bash
set -u

copyq config item_popup_interval 0 >/dev/null 2>&1 || true
copyq config native_notifications false >/dev/null 2>&1 || true

if pgrep -x copyq >/dev/null 2>&1; then
  exit 0
fi

exec copyq
