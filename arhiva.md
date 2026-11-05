---
layout: default
title: Arhiva vijesti
permalink: /arhiva/
sidebar: true
description: "Sve vijesti portala Moj Otok Krk, najnovije prve."
---
{%- comment -%} Arhiva: svi članci (osim tjednih pregleda oglasa – oni su na /zaposlenje/), najnoviji prvi, po 30 uz gumb VIŠE. Naslovnica prikazuje samo 30 najnovijih i vodi ovamo. {%- endcomment -%}
{%- assign ar_posts = site.posts | where_exp: "p", "p.type != 'Zaposlenje'" -%}
<div class="history-page kat-page">
<h1>Arhiva vijesti</h1>
<p class="intro">Sve objavljene vijesti, najnovije prve. Po mjestu i vrsti pregledajte ih na <a href="{{ '/kategorije/' | relative_url }}">stranici kategorija</a>, a oglase za posao na stranici <a href="{{ '/zaposlenje/' | relative_url }}">Zaposlenje</a>.</p>
<p class="kat-broj"><strong>{{ ar_posts.size }}</strong> {% include broj-clanaka.html n=ar_posts.size %} · najnoviji prvi</p>
{% include clanci-lista.html posts=ar_posts id="kl" po=30 %}
</div>
