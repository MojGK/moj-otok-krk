#!/bin/bash
# Objavljuje JEDAN post iz reda: publish.sh <queue-file> [--dry]
# PRILAGODI Q (mapa reda), R (klon repoa), GIT_NAME, GIT_EMAIL.
set -u
Q="${Q:-$(cd "$(dirname "$0")" && pwd)}"
R="${R:-$Q/repo}"
LOG="${LOG:-$Q/log.txt}"
GIT_NAME="${GIT_NAME:-MojGK}"
GIT_EMAIL="${GIT_EMAIL:-mojgorskikotar@users.noreply.github.com}"
f="$(readlink -f "$1")"; [ -f "$f" ] || { echo "no file $1"; exit 1; }; DRY="${2:-}"
log(){ echo "$(date '+%F %T %z') $*" >> "$LOG"; [ -n "$DRY" ] && echo "$*"; }
slug=$(basename "$f" .md | sed 's/^[0-9]*-//')
D=$(date -d '-15 min' '+%Y-%m-%d %H:%M:00 %z'); DF=$(date -d '-15 min' '+%Y-%m-%d')
dest="_posts/$DF-$slug.md"
img=$(sed -n 's#^image: /assets/images/##p' "$f" | head -1)
title=$(sed -n 's/^title: "\(.*\)"$/\1/p' "$f" | head -1)
if [ -n "$DRY" ]; then
  T=$(mktemp -d); sed "s/^date: DATE_PLACEHOLDER$/date: $D/" "$f" > "$T/out.md"
  log "DRY: $f -> $dest | date: $D | img: $img"
  grep -c DATE_PLACEHOLDER "$T/out.md" | sed 's/^/DRY placeholders left: /'; grep '^date:' "$T/out.md"; rm -rf "$T"; exit 0
fi
cd "$R" || { log "ERR no repo"; exit 1; }
for a in 1 2 3 4 5 6; do
  git pull -q --rebase --autostash >>"$LOG" 2>&1 || { git rebase --abort >/dev/null 2>&1; log "pull fail $a"; sleep 60; continue; }
  if [ ! -f "$dest" ] && ! ls _posts/*-"$slug".md >/dev/null 2>&1; then
    sed "s/^date: DATE_PLACEHOLDER$/date: $D/" "$f" > "$dest"
    [ -s "$dest" ] && ! grep -q DATE_PLACEHOLDER "$dest" || { log "ERR empty dest"; rm -f "$dest"; exit 1; }
    [ -n "$img" ] && [ -f "$Q/img/$img" ] && [ ! -f "assets/images/$img" ] && cp "$Q/img/$img" "assets/images/$img"
    git add "$dest"; [ -n "$img" ] && [ -f "assets/images/$img" ] && git add "assets/images/$img"
    if [ -n "$img" ] && [ -f "assets/images/$img" ] && [ -f tools/make-thumbs.py ]; then
      python3 tools/make-thumbs.py "assets/images/$img" >>"$LOG" 2>&1 || true
      [ -f "assets/images/thumbs/$img" ] && git add "assets/images/thumbs/$img"
    fi
    git -c user.name="$GIT_NAME" -c user.email="$GIT_EMAIL" commit -qm "Objava: $title" >>"$LOG" 2>&1
  fi
  if git push -q >>"$LOG" 2>&1; then log "OK $(git rev-parse --short=7 HEAD) $dest"; exit 0; fi
  log "push fail $a"; sleep 60
done
log "GAVE UP $f"; exit 1
