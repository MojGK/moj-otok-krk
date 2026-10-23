# Moj Otok Krk

Osobni blog o ljepoti, životu, povijesti i događajima na otoku Krku.
Stranica: https://mojgk.github.io/moj-otok-krk/

Sustav je isti kao kod bloga [Moj Gorski Kotar](https://github.com/MojGK/moj-gorski-kotar) (Jekyll, GitHub Pages iz grane `main`, mapa `/`), samo s plavom temom i kategorijama za Krk.

## Kako botovi dodaju članke

Novi članci se dodaju kao Markdown datoteke u mapu `_posts/` u formatu:

```
YYYY-MM-DD-naslov-clanka.md
```

Nakon pusha na `main` GitHub Pages sam izgradi i objavi stranicu (obično za 1–2 minute).

### Opći članak (Zanimljivosti)

```markdown
---
layout: post
title: Naslov članka
date: 2026-10-23 16:05:00 +0200
location: Malinska
type: Zanimljivosti
categories: [Malinska, Zanimljivosti]
excerpt: Kratki opis (1–2 rečenice, prikazuje se na karticama i u pretrazi).
image: /assets/images/naziv-slike.jpg
image_alt: "Opis slike"
image_credit: "Fotografija: Autor / [Izvor](https://...), licenca"
source: "[Naziv izvora](https://...)"
---

Tekst članka...
```

### Najava događaja (izbornik DOGAĐAJI)

Najava događaja koji tek slijedi dobiva i polja s datumom događaja:

```markdown
---
layout: post
title: Koncert na rivi u Puntu
date: 2026-10-23 13:28:56 +0200
location: Punat
type: Događanja
categories: [Punat, Događanja]
event_date: 2026-10-30 20:00:00 +0100   # početak događaja (obavezno za najavu)
event_end: 2026-10-30 22:00:00 +0100    # kraj (neobavezno)
event_place: Riva, Punat                 # mjesto (neobavezno)
excerpt: ...
source: "[Naziv izvora](https://...)"
---
```

- Stranica `/dogadaji/` (izbornik **Događaji**) prikazuje samo najave koje još nisu prošle, najbliža prva. Događaj je prošao kad prođe `event_end`, a ako njega nema, 3 sata nakon `event_date`. Provjera se radi pri izradi stranice i u pregledniku (JS), pa prošli događaji nestaju i bez novog pusha. Na samoj najavi tada piše „Ovaj događaj je prošao.“
- Izvještaji s već održanih događaja **nemaju** `event_date` (samo `type: Događanja`).
- Kategorija Događanja (filteri, bočna traka, `/kategorije/`) prikazuje sve članke te vrste, i prošle i buduće.
- Pazi na zonu: `+0200` ljeti (CEST), `+0100` zimi (CET, od zadnje nedjelje u listopadu).

### Povijesni članak (izbornik POVIJEST)

```markdown
---
layout: post
title: Naslov povijesnog članka
date: 2026-10-23 16:05:00 +0200
location: Vrbnik
type: Povijest
categories: [Vrbnik, Povijest]
excerpt: ...
image: /assets/images/naziv-slike.jpg
image_alt: "Opis slike"
image_credit: "Ilustracija generirana umjetnom inteligencijom (nije povijesna fotografija)"
source: "[Naziv izvora](https://...)"
---
```

- Stranica `/povijest/` prikazuje sve članke s `type: Povijest` (ili kojima `categories` sadrži `Povijest`), najnoviji prvi.

### Datum i vrijeme

- Za svaki novi članak **uvijek upiši stvarno vrijeme objave** sa zonom: `date: YYYY-MM-DD HH:MM:SS +0200` (ljeti) ili `+0100` (zimi). Dan mora odgovarati datumu u nazivu datoteke. Ne izmišljaj vrijeme.
- Članci bez poznatog vremena imaju samo datum (`date: YYYY-MM-DD`) i `show_time: false`.
- Vrijeme ne smije biti u budućnosti – Jekyll inače preskače članak dok to vrijeme ne prođe.
- Glavni članak na naslovnici je najnoviji; za ručni odabir dodaj `featured: true` (samo jednom članku).

### Kategorije

- `location` – jedno mjesto: Krk, Malinska, Njivice, Šilo, Punat, Dobrinj, Vrbnik, Baška ili Otok Krk (za cijeli otok).
- `type` – jedna vrsta: Događanja, Povijest ili Zanimljivosti.
- `categories` – uvijek `[location, type]`, istim redom i istim nazivima (mogu se dodati i dodatne vrste/mjesta).
- Nazivi moraju točno odgovarati popisu u `_data/kategorije.yml` (s dijakriticima). Novo mjesto, vrstu ili serijal dodaj u tu datoteku (`name` + `slug` bez dijakritika) i odmah će se pojaviti u filterima, bočnoj traci i na stranici `/kategorije/`.

### Slike

- Slike idu u `assets/images/` (JPG, širina do ~1600 px).
- Uvijek navedi autora, izvor i licencu u `image_credit`. Za generirane ilustracije jasno napiši da su ilustracija.

### Komentari

Komentari (giscus) se uključuju popunjavanjem `giscus:` u `_config.yml`. Dok je prazno, ispod članka stoji kratka napomena.
