---
layout: default
title: Kategorije
permalink: /kategorije/
---

<div class="categories-page">
  <h1>Kategorije</h1>
  <p class="intro">Članci su razvrstani po mjestu i po vrsti. Klikni na kategoriju za brzi skok ili
  <a href="{{ '/' | relative_url }}">filtriraj članke na naslovnici</a>.</p>

  <nav class="cat-jump">
    <strong>Mjesta:</strong>
    {% for k in site.data.kategorije.lokacije %}<a href="#{{ k.slug }}">{{ k.name }}</a>{% endfor %}
    <br>
    <strong>Vrste:</strong>
    {% for k in site.data.kategorije.vrste %}<a href="#{{ k.slug }}">{{ k.name }}</a>{% endfor %}
    {% if site.data.kategorije.serijali %}<br>
    <strong>Serijali:</strong>
    {% for k in site.data.kategorije.serijali %}<a href="#{{ k.slug }}">{{ k.name }}</a>{% endfor %}{% endif %}
  </nav>

  {% assign grupe = "lokacije,vrste,serijali" | split: "," %}
  {% for g in grupe %}
    {% if g == "lokacije" %}<h2>Po mjestima</h2>{% elsif g == "vrste" %}<h2>Po vrsti</h2>{% else %}{% unless site.data.kategorije.serijali %}{% continue %}{% endunless %}<h2>Serijali</h2>{% endif %}
    {% for k in site.data.kategorije[g] %}
      {% include kat-broj.html name=k.name %}
      <section class="cat-section" id="{{ k.slug }}">
        <h3>{{ k.name }} <span class="count">{{ kat_n }}</span>
          {% if kat_n > 0 %}<a class="cat-filter-link" href="{{ '/' | relative_url }}?kategorija={{ k.slug }}">filtriraj na naslovnici →</a>{% endif %}</h3>
        {% if k.opis %}<p class="cat-desc">{{ k.opis }}</p>{% endif %}
        {% if kat_n > 0 %}
        <ul>
          {% for post in site.posts %}
          {% unless post.location == k.name or post.type == k.name or post.categories contains k.name %}{% continue %}{% endunless %}
          <li><span class="meta">{{ post.date | date: "%d. %m. %Y." }}</span>
            <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
            {% include oznake.html post=post %}</li>
          {% endfor %}
        </ul>
        {% else %}
        <p class="empty-cat">Još nema članaka.</p>
        {% endif %}
      </section>
    {% endfor %}
  {% endfor %}
</div>
