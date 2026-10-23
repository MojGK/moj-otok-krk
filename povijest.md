---
layout: default
title: Povijest
permalink: /povijest/
sidebar: true
---
{%- assign pov_n = 0 -%}
{%- for p in site.posts -%}{%- if p.type == "Povijest" or p.categories contains "Povijest" -%}{%- assign pov_n = pov_n | plus: 1 -%}{%- endif -%}{%- endfor -%}
<div class="history-page">
  <h1>Povijest</h1>
  <p class="intro">Priče iz prošlosti otoka Krka – mjesta, ljudi i događaji. Najnoviji članci prvi.</p>
  {% if pov_n > 0 %}
  <div class="posts-grid">
    {%- for post in site.posts %}
    {%- unless post.type == "Povijest" or post.categories contains "Povijest" %}{% continue %}{% endunless %}
    <article class="post-card">
      {% if post.image %}<a href="{{ post.url | relative_url }}" class="card-thumb"><img src="{{ post.image | relative_url }}" alt="{{ post.image_alt | default: post.title | escape }}" loading="lazy"></a>{% endif %}
      <div class="content">
        {% include oznake.html post=post %}
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <div class="meta">{% include datum.html date=post.date show_time=post.show_time %}</div>
        <p>{{ post.excerpt | strip_html | truncate: 95 }}</p>
      </div>
    </article>
    {%- endfor %}
  </div>
  {% else %}
  <p class="no-results">Još nema povijesnih članaka.</p>
  {% endif %}
</div>
