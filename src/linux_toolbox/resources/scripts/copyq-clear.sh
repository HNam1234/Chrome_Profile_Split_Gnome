#!/usr/bin/env bash
set -u

if ! pgrep -x copyq >/dev/null 2>&1; then
  exit 0
fi

copyq eval -- '
  var n = count();
  if (n > 0) {
    var rows = [];
    for (var i = 0; i < n; ++i) rows.push(i);
    remove.apply(this, rows);
  }
  copy("");
  copySelection("");
' >/dev/null 2>&1 || true
