# Predložak portala (iz Moj Otok Krk)

Ovo je kostur Jekyll portala bez članaka i bez slika. **Prije prve objave** pročitaj `/workspace/handoff-krk/PORTAL-VODIC.md` i zamijeni sve GK-specifične stringove (popis u vodiču).

Koraci ukratko:
1. Novi public GitHub repo + Pages (branch `main`, root).
2. Prilagodi `_config.yml` (`title`, `baseurl`, `url`, `logo`, `goatcounter`, ankete ključevi).
3. Prilagodi `_data/kategorije.yml` + stubove u `kategorije/`.
4. Ukloni ili zamijeni TikTok karticu (`_includes/tiktok-podrska.html`) – pitaj Andreja.
5. Postavi git identity u `tools/push.sh` / env `GIT_NAME`/`GIT_EMAIL`.
6. Prvi članak u `_posts/`, slika u `assets/images/`, `python3 tools/make-thumbs.py`, `git pull --rebase`, commit, push; ~75 s kasnije `curl` live URL.
