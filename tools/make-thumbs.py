#!/usr/bin/env python3
# usage: python3 make-thumbs.py [src files...]  -> <repo>/assets/images/thumbs/<name> (480 px, q75)
import sys, glob, os
from PIL import Image, ImageOps

here = os.path.dirname(os.path.abspath(__file__))
repo = os.path.dirname(here) if os.path.basename(here) == "tools" else os.getcwd()
out = os.path.join(repo, "assets", "images", "thumbs")
os.makedirs(out, exist_ok=True)
files = sys.argv[1:] or glob.glob(os.path.join(repo, "assets", "images", "*.*"))
for f in files:
    ext = f.lower().rsplit(".", 1)[-1]
    if ext not in ("jpg", "jpeg", "png", "webp"):
        continue
    if "/thumbs/" in f.replace("\\", "/"):
        continue
    d = os.path.join(out, os.path.basename(f))
    if os.path.exists(d) and os.path.getmtime(d) >= os.path.getmtime(f):
        continue
    im = ImageOps.exif_transpose(Image.open(f))
    if im.width > 480:
        im = im.resize((480, round(im.height * 480 / im.width)), Image.LANCZOS)
    if ext in ("jpg", "jpeg"):
        im.convert("RGB").save(d, "JPEG", quality=75, optimize=True, progressive=True)
    else:
        im.save(d, optimize=True)
    print("thumb:", d)
