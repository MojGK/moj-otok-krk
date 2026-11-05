---
layout: default
title: Povijest
permalink: /povijest/
sidebar: true
---
{%- assign pov_posts = "" | split: "" -%}
{%- for p in site.posts -%}{%- if p.type == "Povijest" or p.categories contains "POVIJEST KRK" -%}{%- assign pov_posts = pov_posts | push: p -%}{%- endif -%}{%- endfor -%}
<div class="history-page kat-page">
  <h1>Povijest</h1>
  <p class="kat-broj"><strong>{{ pov_posts.size }}</strong> {% include broj-clanaka.html n=pov_posts.size %} · najnoviji prvi</p>
  <p class="intro">Priče iz prošlosti otoka Krka – mjesta, ljudi i događaji.
  Svi nastavci serijala <a href="{{ '/kategorije/povijest-krk/' | relative_url }}">POVIJEST KRK</a>.</p>
  {% if pov_posts.size > 0 %}
{% include clanci-lista.html posts=pov_posts id="kl" %}
  {% else %}
  <p class="no-results">Još nema povijesnih članaka.</p>
  {% endif %}
</div>
