---
# PREDLOŽAK za tjedni pregled DOGAĐANJA (blok "📅 Događanja" na naslovnici + /kalendar/).
# Kopiraj u _posts/GGGG-MM-DD-dogadanja-otok-krk-tjedan-DD-MM-DD-MM.md, popuni i obriši komentare.
# Na naslovnici se prikazuju do 3 nadolazeća događaja iz `dogadjaji` NAJNOVIJEG članka vrste Događanja koji ima taj popis.
# Kartice se automatski dodaju i u /kalendar/ (osim onih čiji `link` vodi na naš članak s event_date – taj je već u kalendaru).
# Ne postavljaj featured / istaknuto.
layout: post
title: "Događanja u otoku Krku – tjedan [DD. MM.] – [DD. MM. GGGG.]"
date: 2026-11-06 08:00:00 +0100   # barem 15 min u prošlosti u trenutku objave
location: Otok Krk
type: Događanja
categories: [Otok Krk, Događanja]
excerpt: "[Jedna rečenica: 3–4 najzanimljivija događaja tjedna.]"
image: /assets/images/[slika].jpg   # Commons/Unsplash/Pexels ili postojeća, s potpisom
image_alt: "[opis slike]"
image_credit: "[Autor / izvor, licenca]"
# Popis događaja, poredan po datumu. Podatke uzmi iz naših najava ili izvorne objave organizatora.
dogadjaji:
  - naziv: "[Naziv događaja]"                # obavezno
    datum: 2026-11-07                       # obavezno, GGGG-MM-DD
    datum_do: 2026-11-08                    # neobavezno – za višednevne
    vrijeme: "17:00"                        # neobavezno – "17:00" ili "16:00 – 22:00"; izostavi ako nije objavljeno
    mjesto: "[Prostor, adresa, mjesto]"     # obavezno
    organizator: "[Organizator]"            # neobavezno
    opis: "[Jedna kratka rečenica.]"        # neobavezno
    link: /[slug-nase-najave]/              # neobavezno – naš članak (/slug/) ili vanjski URL (https://...)
    slika: /assets/images/[slika].jpg       # neobavezno – slika na vrhu kartice
---
[Uvod u 1–2 rečenice.]

## Ovaj tjedan

{% include dogadjaji-lista.html %}

## Kasnije

- **[DD. MM.]** – [[Naziv]]({{ '/[slug]/' | relative_url }}), [mjesto]

**Izvori:** [poveznice na izvorne objave organizatora]
