#!/bin/bash
# Red objava: za svaki sljedeći post (od 02- nadalje) čeka nasumično 20–35 min pa objavi.
# Prvi (01-…) objavi ručno; ovaj skript kreće od drugog.
# usage: Q=/putanja/do/reda run-queue.sh [--dry]
# PAŽNJA: proces umire ako se box suspendira. Datoteke: 01-slug.md … s date: DATE_PLACEHOLDER
Q="${Q:-$(cd "$(dirname "$0")" && pwd)}"
DRY="${1:-}"
for f in $(ls "$Q"/[0-9][0-9]-*.md 2>/dev/null | sort | tail -n +2); do
  s=$(shuf -i 1200-2100 -n 1)
  echo "$(date '+%F %T %z') WAIT ${s}s -> $(basename "$f")" >> "$Q/log.txt"
  [ -z "$DRY" ] && sleep "$s"
  "$Q/publish.sh" "$f" $DRY
done
echo "$(date '+%F %T %z') QUEUE DONE" >> "$Q/log.txt"
