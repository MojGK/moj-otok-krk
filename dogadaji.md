---
layout: default
title: Događaji
permalink: /dogadaji/
sidebar: true
description: Nadolazeći događaji u otoku Krku na jednom mjestu – datum, vrijeme, mjesto i poveznica na najavu.
---
{%- comment -%}
Živi popis događaja iz _data/dogadjanja.yml (upute: _data/README-zaposlenje-dogadjanja.md), najbliži prvi.
Prošli se ne prikazuju (pri izradi stranice, a u pregledniku i JS-om). Članci i stari tjedni pregledi ostaju u kategoriji Događanja.
{%- endcomment -%}
{%- assign dg_data = site.data.dogadjanja -%}
<div class="events-page">
  <h1>Nadolazeći događaji</h1>
  <p class="intro">Najave događaja u otoku Krku, najbliži prvi. Izvještaji s prošlih događaja su u kategoriji
  <a href="{{ '/kategorije/dogadanja/' | relative_url }}">Događanja</a>.</p>
  {% if dg_data.azurirano %}<p class="zivi-azurirano">Ažurirano: <time datetime="{{ dg_data.azurirano | date: '%Y-%m-%d' }}">{{ dg_data.azurirano | date: "%-d. %-m. %Y." }}</time></p>{% endif %}
  <div class="post-content zivi-wrap">{% include dogadjaji-lista.html dogadjaji=dg_data.dogadjaji zivo=true prazno="Trenutno nema najavljenih događaja." %}</div>
  <p class="events-past-link"><a href="{{ '/kategorije/dogadanja/' | relative_url }}">Prošli događaji →</a> · <a href="{{ '/kalendar/' | relative_url }}">Kalendar događanja →</a></p>
</div>
{% include zivi-filter-js.html %}
