---
layout: default
title: Zaposlenje
permalink: /zaposlenje/
sidebar: true
description: Aktualni oglasi za posao u otoku Krku na jednom mjestu – s rokovima prijave i poveznicama na izvorni oglas.
---
{%- comment -%}
Živi popis oglasa iz _data/poslovi.yml (upute: _data/README-zaposlenje-dogadjanja.md).
Istekli oglasi se ne prikazuju (pri izradi stranice, a u pregledniku i JS-om). Stari tjedni pregledi (članci vrste Zaposlenje) ostaju kao arhiva.
{%- endcomment -%}
{%- assign zp_data = site.data.poslovi -%}
{%- assign zap_posts = "" | split: "" -%}
{%- for p in site.posts -%}{%- if p.type == "Zaposlenje" or p.categories contains "Zaposlenje" -%}{%- assign zap_posts = zap_posts | push: p -%}{%- endif -%}{%- endfor -%}
<div class="history-page zaposlenje-page">
  <h1><span aria-hidden="true">💼</span> Zaposlenje</h1>
  <p class="intro">Aktualni oglasi za posao u otoku Krku, poredani po roku prijave. Svaka kartica vodi na izvorni oglas. Istekli oglasi automatski nestaju s popisa.</p>
  {% if zp_data.azurirano %}<p class="zivi-azurirano">Ažurirano: <time datetime="{{ zp_data.azurirano | date: '%Y-%m-%d' }}">{{ zp_data.azurirano | date: "%-d. %-m. %Y." }}</time></p>{% endif %}
  <div class="post-content zivi-wrap">{% include oglasi-lista.html oglasi=zp_data.oglasi zivo=true prazno="Trenutno nema aktualnih oglasa. Novi oglasi stižu svakog tjedna." %}</div>
  <p class="zivi-napomena">Imate oglas za posao u otoku Krku? Javite nam se.</p>
  {% if zap_posts.size > 0 %}
  <h2 class="section-title">Arhiva tjednih pregleda</h2>
  <ul class="zap-older">
    {%- for post in zap_posts %}
    <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="meta">{% include datum.html date=post.date show_time=false %}</span></li>
    {%- endfor %}
  </ul>
  {% endif %}
</div>
{% include zivi-filter-js.html %}
