---
layout: default
title: Vijesti
permalink: /vijesti/
sidebar: true
description: "Opće vijesti iz otoka Krka: aktualno, promet, priroda i ostalo."
---
{%- comment -%} Popis za blok VIJESTI na mobilnoj naslovnici: sve vrste koje nisu u drugim blokovima (naslovnica_blokovi s `vrste`) i nisu Zaposlenje. {%- endcomment -%}
{%- assign vj_pokrivene = "," -%}
{%- for b in site.data.kategorije.naslovnica_blokovi -%}{%- for v in b.vrste -%}{%- assign vj_pokrivene = vj_pokrivene | append: v | append: "," -%}{%- endfor -%}{%- endfor -%}
<div class="history-page kat-page">
<h1>Vijesti</h1>
<p class="intro">Opće vijesti iz otoka Krka – aktualno, promet, priroda i ostalo. Općinske vijesti, zanimljivosti, događanja, sport, crna kronika, kultura, društvo i povijest imaju svoje rubrike na <a href="{{ '/kategorije/' | relative_url }}">stranici kategorija</a>.</p>
{%- assign vj_posts = "" | split: "" -%}
{%- for post in site.posts -%}
  {%- if post.type == "Zaposlenje" -%}{%- continue -%}{%- endif -%}
  {%- assign vj_k = "," | append: post.type | append: "," -%}
  {%- if vj_pokrivene contains vj_k -%}{%- continue -%}{%- endif -%}
  {%- assign vj_posts = vj_posts | push: post -%}
{%- endfor %}
<p class="kat-broj"><strong>{{ vj_posts.size }}</strong> {% include broj-clanaka.html n=vj_posts.size %} · najnoviji prvi</p>
<div id="vijesti-popis">
{% include clanci-lista.html posts=vj_posts id="kl" %}
</div>
</div>
