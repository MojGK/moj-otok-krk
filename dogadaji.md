---
layout: default
title: Događaji
permalink: /dogadaji/
sidebar: true
---
{%- comment -%}
Samo najave događaja koji još nisu prošli (članci s event_date), najbliži prvi.
Prošli se izbacuju pri izradi stranice, a u pregledniku i JS-om (GitHub Pages gradi stranicu samo pri pushu).
Svi članci vrste Događanja (i prošli) i dalje su u kategoriji Događanja.
{%- endcomment -%}
{%- assign d_now = site.time | date: "%s" | plus: 0 -%}
{%- assign najave = site.posts | where_exp: "p", "p.event_date" | sort: "event_date" -%}
<div class="events-page">
  <h1>Nadolazeći događaji</h1>
  <p class="intro">Najave događaja na otoku Krku, najbliži prvi. Izvještaji s prošlih događaja su u kategoriji
  <a href="{{ '/kategorije/' | relative_url }}#dogadanja">Događanja</a>.</p>

  <div class="event-list" data-event-list>
  {%- assign d_count = 0 -%}
  {%- for post in najave -%}
    {%- assign p_start = post.event_date | date: "%s" | plus: 0 -%}
    {%- if post.event_end -%}{%- assign p_end = post.event_end | date: "%s" | plus: 0 -%}{%- else -%}{%- assign p_end = p_start | plus: 10800 -%}{%- endif -%}
    {%- if p_end < d_now -%}{%- continue -%}{%- endif -%}
    {%- assign d_count = d_count | plus: 1 %}
    <article class="post-card event-card" data-event-end="{{ p_end }}" data-hide-when-past>
      {% if post.image %}<a href="{{ post.url | relative_url }}" class="card-thumb"><img src="{{ post.image | relative_url }}" alt="{{ post.image_alt | default: post.title | escape }}" loading="lazy"></a>{% endif %}
      <div class="content">
        {% include dogadaj-info.html post=post %}
        {% include oznake.html post=post %}
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p>{{ post.excerpt | strip_html | truncate: 160 }}</p>
      </div>
    </article>
  {%- endfor %}
  </div>
  <p class="no-results" data-event-empty{% if d_count > 0 %} hidden{% endif %}>Trenutno nema najavljenih događaja.
    Prošle događaje pogledaj u kategoriji <a href="{{ '/kategorije/' | relative_url }}#dogadanja">Događanja</a>.</p>
  <p class="events-past-link"><a href="{{ '/kategorije/' | relative_url }}#dogadanja">Prošli događaji →</a></p>
</div>
