---
layout: default
title: Pretraga
permalink: /pretraga/
---

<div class="search-page">
  <h1>Pretraga</h1>
  <form class="search search-big" action="{{ '/pretraga/' | relative_url }}" method="get" role="search" autocomplete="off">
    <label for="search-page-input" class="visually-hidden">Pojam za pretragu</label>
    <input id="search-page-input" type="search" name="q" placeholder="Upiši pojam, npr. Baška, Vrbnik, glagoljica…">
    <button type="submit">Traži</button>
  </form>
  <p id="search-summary" class="search-summary"></p>
  <ol id="search-page-results" class="search-page-results"></ol>
  <noscript><p>Za pretragu je potreban JavaScript. Možete pregledati <a href="{{ '/kategorije/' | relative_url }}">sve kategorije</a>.</p></noscript>
</div>
