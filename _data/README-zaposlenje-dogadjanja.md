# Zaposlenje i Događanja – živi popisi (upute za Novinara)

Stranice **/zaposlenje/** i **/dogadaji/**, blokovi na naslovnici i **/kalendar/** pune se iz dviju datoteka:

- `_data/poslovi.yml` – oglasi za posao
- `_data/dogadjanja.yml` – najave događaja

Za novi oglas ili događaj **ne pišeš članak**: dodaš stavku u datoteku, promijeniš `azurirano:` na današnji datum i objaviš (commit + push).
Stranica se uz to sama ponovno izgradi svaki dan u 05:00 (GitHub Actions „Dnevna izrada stranice”), pa istekli oglasi i prošli događaji nestanu i bez objave.

## Pravila za oba popisa

- Datumi uvijek kao `GGGG-MM-DD` (npr. `2026-11-15`).
- Tekst s dvotočkom, navodnicima ili `#` stavi u navodnike: `vrijeme: "17:00"`.
- Uvlačenje razmacima (2 razmaka), nikad tabulatorom. Svaka stavka počinje s `- `.
- Redoslijed u datoteci nije bitan – stranica sama slaže po roku/datumu.
- Istekle stavke **ne moraš** brisati odmah (same se skrivaju), ali jednom tjedno počisti sve starije od tjedan dana da datoteka ostane pregledna.
- Promo pravila vrijede i ovdje: bez cijena i privatnih kontakata u opisu; izvor uvijek kao poveznica.

## Oglas za posao (`_data/poslovi.yml`, pod `oglasi:`)

```yaml
- poslodavac: "Lokve d.o.o."               # obavezno
  pozicija: "Radnik / radnica u pilani"     # obavezno
  mjesto: "Lokve"                           # obavezno – kako piše u oglasu
  grad: "Lokve"                             # neobavezno – općina/grad za filter, ako `mjesto` ima dodatke
                                            #   (npr. mjesto "Plešce (Čabar)" → grad "Čabar")
  rok: 2026-11-15                           # GGGG-MM-DD ili tekst u navodnicima ("do popune")
  broj: 1                                   # neobavezno – broj radnika
  vrsta: "određeno, puno radno vrijeme"     # neobavezno – ugovor / uvjeti
  opis: "Kratka rečenica."                  # neobavezno
  izdvojeno: true                           # neobavezno – ide u blok na naslovnici (najviše 2 se vide)
  izvori:                                   # barem jedan; prvi je gumb „Više / prijava”
    - naziv: "HZZ"
      url: "https://burzarada.hzz.hr/..."
```

- Oglas nestaje dan nakon roka. Oglas s rokom "do popune" ostaje dok ga ne obrišeš – provjeri ga svaki tjedan.

## Događaj (`_data/dogadjanja.yml`, pod `dogadjaji:`)

```yaml
- naziv: "Noć špilja u Lokvama"             # obavezno
  datum: 2026-11-07                         # obavezno – prvi dan
  datum_do: 2026-11-08                      # neobavezno – zadnji dan višednevnog događaja
  vrijeme: "17:00"                          # neobavezno – "17:00", "16–22 h"; prazno = „nije objavljeno”
  mjesto: "DKC „Žaba”, Lokve"               # obavezno
  grad: "Lokve"                             # neobavezno – za filter, ako `mjesto` ima adresu ili dodatke
  organizator: "Općina Lokve"               # neobavezno
  opis: "Kratka rečenica."                  # neobavezno
  link: /noc-spilja-lokve-2026/             # neobavezno – naš članak (/slug/) ili vanjski URL (https://...)
```

- Događaj nestaje s /dogadaji/ i naslovnice dan nakon `datum_do` (ili `datum`). U kalendaru ostaje pod „Prikaži prošla događanja” dok ga ne obrišeš.
- Kad za veći događaj pišeš i **članak** (s `event_date`), dodaj ga i ovdje s `link: /slug-clanka/` – kalendar neće prikazati duplikat.

## Tjedni pregled (neobavezno)

Kratki tjedni članak (npr. ponedjeljkom) s 3–5 izdvojenih stavki i poveznicom na /zaposlenje/ ili /dogadaji/ i dalje je dobrodošao za Facebook, RSS i arhivu. Stari tjedni pregledi ostaju na istim adresama kao arhiva.
