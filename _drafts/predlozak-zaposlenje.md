---
# PREDLOŽAK za objavu u rubrici ZAPOSLENJE (/zaposlenje/ i blok "💼 Zaposlenje" na naslovnici).
# Kopiraj u _posts/GGGG-MM-DD-zaposlenje-otok-krk-DD-MM.md, popuni i obriši ove komentare.
# Članci vrste Zaposlenje NE ulaze u opći tok vijesti (hero, Izdvojeno, mreža, Najnovije):
# na naslovnici se prikazuje samo blok ZAPOSLENJE s 1–2 oglasa iz `istaknuti_oglasi` najnovijeg takvog članka.
layout: post
# Naslov: "ZAPOSLENJE: <poslodavac> traži <istaknuto radno mjesto> u <mjesto> i još N oglasa u otoku Krku"
title: "ZAPOSLENJE: [Poslodavac] traži [radno mjesto] u [mjestu] i još [N] oglasa u otoku Krku"
date: 2026-11-03 08:00:00 +0100
location: Otok Krk
type: Zaposlenje
categories: [Otok Krk, Zaposlenje]
broj_oglasa: 0            # ukupan broj oglasa u popisu `oglasi` (mora odgovarati broju u naslovu + 1)
# 1–2 izdvojena oglasa (prikazuju se na naslovnici, na /zaposlenje/ i na vrhu članka).
# Svaki provjeri na izvoru (HZZ, stranica poslodavca) – rok ne smije biti istekao. Bez osobnih podataka.
istaknuti_oglasi:
  - pozicija: "[Radno mjesto (broj izvršitelja, vrsta ugovora)]"
    poslodavac: "[Poslodavac]"
    mjesto: "[Krk]"
    rok: 2026-11-10       # GGGG-MM-DD; ili tekst u navodnicima, npr. "do popune"
    link: https://burzarada.hzz.hr/RadnoMjesto_Ispis.aspx?WebSifra=000000000
    opis: "[Jedna kratka rečenica: uvjeti, radno vrijeme, što se nudi.]"
  - pozicija: "[Radno mjesto]"
    poslodavac: "[Poslodavac]"
    mjesto: "[Vrbovsko]"
    rok: 2026-11-15
    link: https://primjer.hr/oglas
# SVI oglasi (kartice u članku, include oglasi-lista.html). Redoslijed = redoslijed prikaza (npr. po roku).
# Obavezno: poslodavac, pozicija, mjesto, rok, izvori (barem jedan; prvi je gumb „Više / prijava”).
# Neobavezno: broj (broj radnika), vrsta (ugovor/uvjeti), oznaka (fusnota uz rok, npr. "*"), opis.
oglasi:
  - poslodavac: "[Poslodavac]"
    pozicija: "[Naziv radnog mjesta]"
    broj: 1
    vrsta: "[neodređeno, puno radno vrijeme]"
    mjesto: "[Krk]"
    rok: 2026-11-10       # GGGG-MM-DD; ili tekst u navodnicima, npr. "do popune"
    izvori:
      - naziv: HZZ
        url: https://burzarada.hzz.hr/RadnoMjesto_Ispis.aspx?WebSifra=000000000
  - poslodavac: "[Poslodavac]"
    pozicija: "[Naziv radnog mjesta]"
    mjesto: "[Vrbovsko]"
    rok: "8 dana od objave u NN"
    oznaka: "*"
    izvori:
      - naziv: "[Grad Vrbovsko]"
        url: https://primjer.hr/oglas
      - naziv: HZZ
        url: https://burzarada.hzz.hr/
excerpt: "[Istaknuti oglas] i još [N] aktualnih oglasa za posao u otoku Krku: [2–3 vrste poslova]. Rokovi prijave i poveznice na izvorne oglase."
image: /assets/images/zaposlenje-naslovna.jpg
image_alt: "Radni stol uz prozor s pogledom na šumovita brda i goransko mjesto: torba, zaštitna kaciga, laptop, novine s oglasima i radne rukavice"
image_credit: "Ilustracija: generirano umjetnom inteligencijom (AI)"
---

Aktualni oglasi za posao u otoku Krku, provjereni **[DD. MM. GGGG.]** Izdvojeni oglasi su na vrhu; prije prijave uvijek pročitajte izvorni oglas.

## Aktualni oglasi

{% include oglasi-lista.html %}

Broj traženih radnika naveden je samo ako ga oglas navodi.

\* [Fusnota uz oglas s oznakom "*", npr. kako se računa rok.]

## Izvori

- [HZZ – Burza rada](https://burzarada.hzz.hr/) (pretraga po mjestu rada)
- Službene stranice gradova i općina (natječaji za zapošljavanje)
- [Narodne novine – oglasni dio](https://narodne-novine.nn.hr/) (javne službe)
- [Oglasi poslodavaca – navesti stranicu]

*Istekli oglasi uklanjaju se iz pregleda. Imate oglas za posao u otoku Krku? Javite nam se.*
