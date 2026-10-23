---
layout: default
title: Početna
sidebar: true
---

{%- assign featured = site.posts | where: "featured", true | first -%}
{%- if featured -%}{%- assign lead = featured -%}{%- else -%}{%- assign lead = site.posts.first -%}{%- endif -%}
{%- assign lead_loc = site.data.kategorije.lokacije | where: "name", lead.location | first -%}
{%- assign lead_type = site.data.kategorije.vrste | where: "name", lead.type | first -%}

<section class="lead" id="lead" data-location="{{ lead_loc.slug }}" data-type="{{ lead_type.slug }}" data-cats="{% include kat-slugovi.html post=lead %}">
  <a href="{{ lead.url | relative_url }}" class="lead-link{% unless lead.image %} no-image{% endunless %}">
    {% if lead.image %}<img src="{{ lead.image | relative_url }}" alt="{{ lead.image_alt | default: lead.title | escape }}">{% endif %}
    <div class="lead-overlay">
      <span class="lead-kicker">{% if featured %}Izdvojeno{% else %}Najnovije{% endif %}</span>
      <h1>{{ lead.title }}</h1>
    </div>
  </a>
  <div class="lead-body">
    <div class="lead-meta">{% include oznake.html post=lead %}<span class="meta">{% include datum.html date=lead.date show_time=lead.show_time %}</span></div>
    <p>{{ lead.excerpt | strip_html | strip }}</p>
    {% if lead.image_credit %}<p class="lead-credit">{{ lead.image_credit | markdownify | remove: '<p>' | remove: '</p>' | strip }}</p>{% endif %}
  </div>
</section>

<div class="filters" id="filteri">
  <button type="button" class="filter-btn active" data-reset>Sve</button>
  <span class="filter-group">
    <span class="filter-label">Mjesto</span>
    {%- for k in site.data.kategorije.lokacije %}
    {%- include kat-broj.html name=k.name %}{% assign n = kat_n %}
    <button type="button" class="filter-btn{% if n == 0 %} empty{% endif %}" data-group="location" data-filter="{{ k.slug }}">{{ k.name }} <span class="count">{{ n }}</span></button>
    {%- endfor %}
  </span>
  <span class="filter-group">
    <span class="filter-label">Vrsta</span>
    {%- for k in site.data.kategorije.vrste %}
    {%- include kat-broj.html name=k.name %}{% assign n = kat_n %}
    <button type="button" class="filter-btn{% if n == 0 %} empty{% endif %}" data-group="type" data-filter="{{ k.slug }}">{{ k.name }} <span class="count">{{ n }}</span></button>
    {%- endfor %}
  </span>
  {%- if site.data.kategorije.serijali %}
  <span class="filter-group">
    <span class="filter-label">Serijal</span>
    {%- for k in site.data.kategorije.serijali %}
    {%- include kat-broj.html name=k.name %}{% assign n = kat_n %}
    <button type="button" class="filter-btn series{% if n == 0 %} empty{% endif %}" data-group="series" data-filter="{{ k.slug }}">{{ k.name }} <span class="count">{{ n }}</span></button>
    {%- endfor %}
  </span>
  {%- endif %}
</div>

<h2 class="section-title" id="naslov-clanaka">Najnoviji članci</h2>
<div class="posts-grid" id="clanci">
  {% for post in site.posts %}
  {%- assign c_loc = site.data.kategorije.lokacije | where: "name", post.location | first -%}
  {%- assign c_type = site.data.kategorije.vrste | where: "name", post.type | first -%}
  <article class="post-card{% if post.url == lead.url %} is-lead{% endif %}" data-location="{{ c_loc.slug }}" data-type="{{ c_type.slug }}" data-cats="{% include kat-slugovi.html post=post %}">
    {% if post.image %}
      <a href="{{ post.url | relative_url }}" class="card-thumb"><img src="{{ post.image | relative_url }}" alt="{{ post.image_alt | default: post.title | escape }}" loading="lazy"></a>
    {% endif %}
    <div class="content">
      {% include oznake.html post=post %}
      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <div class="meta">{% include datum.html date=post.date show_time=post.show_time %}</div>
      <p>{{ post.excerpt | strip_html | truncate: 95 }}</p>
    </div>
  </article>
  {% endfor %}
</div>
<p class="no-results" id="nema-clanaka" hidden>Još nema članaka za odabrani filter. <button type="button" class="link-btn" data-reset>Prikaži sve</button></p>

<script>
(function () {
  var state = { location: null, type: null, series: null };
  var buttons = document.querySelectorAll('.filter-btn[data-filter]');
  var resets = document.querySelectorAll('[data-reset]');
  var cards = document.querySelectorAll('#clanci .post-card');
  var empty = document.getElementById('nema-clanaka');
  var lead = document.getElementById('lead');
  var title = document.getElementById('naslov-clanaka');
  var names = {};
  var groupOf = {};
  buttons.forEach(function (b) {
    groupOf[b.dataset.filter] = b.dataset.group;
    names[b.dataset.filter] = b.firstChild.textContent.trim();
  });

  function apply(updateUrl) {
    var filtering = !!(state.location || state.type || state.series);
    function has(c, slug) { return (' ' + (c.dataset.cats || '') + ' ').indexOf(' ' + slug + ' ') !== -1; }
    var shown = 0;
    cards.forEach(function (c) {
      var ok = (!state.location || has(c, state.location)) &&
               (!state.type || has(c, state.type)) &&
               (!state.series || has(c, state.series));
      // bez filtera vodeći članak je već gore, pa ga ne ponavljamo u mreži
      if (!filtering && c.classList.contains('is-lead')) ok = false;
      c.hidden = !ok;
      if (ok) shown++;
    });
    lead.hidden = filtering;
    document.body.classList.toggle('filtering', filtering);
    title.textContent = filtering
      ? [state.location, state.type, state.series].filter(Boolean).map(function (s) { return names[s]; }).join(' · ')
      : 'Najnoviji članci';
    buttons.forEach(function (b) {
      b.classList.toggle('active', state[b.dataset.group] === b.dataset.filter);
    });
    resets.forEach(function (r) { if (r.classList.contains('filter-btn')) r.classList.toggle('active', !filtering); });
    empty.hidden = shown > 0;
    if (updateUrl && window.history && history.replaceState) {
      var p = [];
      if (state.location) p.push(state.location);
      if (state.type) p.push(state.type);
      if (state.series) p.push(state.series);
      history.replaceState(null, '', location.pathname + (p.length ? '?kategorija=' + p.join(',') : ''));
    }
  }

  buttons.forEach(function (b) {
    b.addEventListener('click', function () {
      var g = b.dataset.group, f = b.dataset.filter;
      state[g] = state[g] === f ? null : f;
      apply(true);
    });
  });
  resets.forEach(function (r) {
    r.addEventListener('click', function () { state.location = null; state.type = null; state.series = null; apply(true); });
  });

  function fromUrl(e) {
    var q = new URLSearchParams(location.search).get('kategorija') || '';
    var h = decodeURIComponent(location.hash.replace(/^#/, ''));
    var vals = (q ? q.split(',') : []).concat(h ? [h] : []);
    if (e && h && groupOf[h]) { state.location = null; state.type = null; state.series = null; }
    var found = false;
    vals.forEach(function (v) {
      v = v.trim().toLowerCase();
      if (groupOf[v]) { state[groupOf[v]] = v; found = true; }
    });
    apply(false);
    if (found) document.getElementById('filteri').scrollIntoView();
  }
  window.addEventListener('hashchange', fromUrl);
  fromUrl();
})();
</script>
