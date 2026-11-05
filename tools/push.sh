#!/bin/bash
# usage: push.sh "msg" files...
# PRILAGODI: REPO, GIT_NAME, GIT_EMAIL za svoj portal (ne koristi MojGK).
REPO="${REPO:-$HOME/repo}"
GIT_NAME="${GIT_NAME:-MojGK}"
GIT_EMAIL="${GIT_EMAIL:-mojgorskikotar@users.noreply.github.com}"
cd "$REPO" || exit 1
m="$1"; shift
git add -A -- "$@" 2>/dev/null
git -c user.name="$GIT_NAME" -c user.email="$GIT_EMAIL" commit -qm "$m" \
  && git pull -q --rebase \
  && git push -q \
  && git log --oneline -1
