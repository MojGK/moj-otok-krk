---
layout: default
title: Početna
sidebar: true
---

{% include zimska-traka.html %}

{%- comment -%} Zaposlenje je zasebna rubrika: ne ide u hero, Izdvojeno ni u mrežu bez filtera (ima svoj blok ispod) {%- endcomment -%}
{%- assign vijesti = site.posts | where_exp: "p", "p.type != 'Zaposlenje'" -%}
{%- assign featured = vijesti | where: "featured", true | first -%}
{%- if featured -%}{%- assign lead = featured -%}{%- else -%}{%- assign lead = vijesti.first -%}{%- endif -%}
{%- assign lead_loc = site.data.kategorije.lokacije | where: "name", lead.location | first -%}
{%- assign lead_type = site.data.kategorije.vrste | where: "name", lead.type | first -%}

<section class="lead hero" id="lead" data-location="{{ lead_loc.slug }}" data-type="{{ lead_type.slug }}" data-cats="{% include kat-slugovi.html post=lead %}">
  <a href="{{ lead.url | relative_url }}" class="lead-link{% unless lead.image %} no-img{% endunless %}">
    {% if lead.image %}<img src="{{ lead.image | relative_url }}"{% if lead.image_position %} style="object-position: {{ lead.image_position }}"{% endif %} alt="{{ lead.image_alt | default: lead.title | escape }}" fetchpriority="high">{% endif %}
    <div class="lead-overlay">
      <span class="lead-badges">{% include prijelomna-oznaka.html post=lead %}<span class="lead-kicker">{% if featured %}Glavna vijest{% else %}Najnovije{% endif %}</span>{% if lead_type %}<span class="card-badge t-{{ lead_type.slug }}">{{ lead_type.name }}</span>{% endif %}</span>
      <h1>{{ lead.title }}</h1>
      {%- assign lead_ex = lead.excerpt | strip_html | strip -%}
      {% if lead_ex != "" %}<p class="lead-excerpt">{{ lead_ex | truncate: 230 }}</p>{% endif %}
      <span class="lead-cta">Pročitaj članak <span aria-hidden="true">→</span></span>
    </div>
  </a>
  <div class="lead-body">
    <div class="lead-meta">{% include oznake.html post=lead %}<span class="meta">{% include datum.html date=lead.date show_time=lead.show_time %}</span></div>
    {% if lead.image_credit %}<p class="lead-credit">{{ lead.image_credit | markdownify | remove: '<p>' | remove: '</p>' | strip }}</p>{% endif %}
  </div>
</section>

{%- comment -%} Mobilno (< 900 px): Najnovije, banner, Izdvojeno, kategorijski blokovi, Zaposlenje, filteri; mreža članaka tek uz filter ili "Svi članci". Na desktopu m-only blokovi su skriveni. {%- endcomment %}
{% include m-najnovije.html lead=lead %}

{% include izdvojeno.html lead=lead %}

{% include m-blokovi.html lead=lead %}

{% include dogadjanja-blok.html %}

{% include zaposlenje-blok.html %}

<div class="filters" id="filteri">
  <button type="button" class="filter-btn active" data-reset>Sve</button>
  <span class="filter-group">
    <span class="filter-label">Mjesto</span>
    {%- for k in site.data.kategorije.lokacije %}
    {%- include kat-broj.html name=k.name bez_vrste="Zaposlenje" %}{% assign n = kat_n %}
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

<p class="m-svi m-only" id="m-svi"><button type="button" class="m-svi-btn" id="m-svi-btn" aria-controls="clanci" aria-expanded="false">Prikaži sve članke ↓</button></p>
<h2 class="section-title" id="naslov-clanaka">Najnoviji članci</h2>
<div class="posts-grid" id="clanci">
  {%- comment -%} Naslovnica: samo 30 najnovijih (brzina); starije su na /arhiva/ i stranicama kategorija. {%- endcomment -%}
  {% for post in site.posts limit: 30 %}
  {%- assign c_loc = site.data.kategorije.lokacije | where: "name", post.location | first -%}
  {%- assign c_type = site.data.kategorije.vrste | where: "name", post.type | first -%}
  {%- assign c_key = "|" | append: post.url | append: "|" -%}
  <article class="post-card{% if post.url == lead.url %} is-lead{% endif %}{% if izd_urls contains c_key %} is-izd{% endif %}{% if post.type == "Zaposlenje" %} is-job{% endif %}" data-location="{{ c_loc.slug }}" data-type="{{ c_type.slug }}" data-cats="{% include kat-slugovi.html post=post %}">
    {%- assign c_ser = nil -%}
    {%- for c_s in site.data.kategorije.serijali -%}{%- if post.categories contains c_s.name -%}{%- assign c_ser = c_s -%}{%- endif -%}{%- endfor %}
    <a href="{{ post.url | relative_url }}" class="card-thumb{% unless post.image %} no-img{% endunless %}" tabindex="-1" aria-hidden="true">
      {% if post.image %}<img {% include thumb.html img=post.image %}{% if post.image_position %} style="object-position: {{ post.image_position }}"{% endif %} alt="" loading="lazy">{% else %}<span class="card-ph">🌊</span>{% endif %}
      <span class="card-badges">{% include prijelomna-oznaka.html post=post %}{% if c_type %}<span class="card-badge t-{{ c_type.slug }}">{{ c_type.name }}</span>{% endif %}{% if c_ser %}<span class="card-badge series">{{ c_ser.name }}</span>{% endif %}</span>
    </a>
    <div class="content">
      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <div class="card-meta">
        {%- if c_loc %}<a class="card-loc" href="{{ '/kategorije/' | relative_url }}#{{ c_loc.slug }}">📍 {{ c_loc.name }}</a>{% endif -%}
        <span class="card-date">{% include datum.html date=post.date show_time=post.show_time %}</span>
      </div>
      <p>{{ post.excerpt | strip_html | strip | truncate: 120 }}</p>
    </div>
  </article>
  {% endfor %}
</div>
<p class="starije-vijesti"><a id="starije-link" href="{{ '/arhiva/' | relative_url }}" data-baza="{{ '/' | relative_url }}">Starije vijesti <span aria-hidden="true">→</span></a></p>
<p class="no-results" id="nema-clanaka" hidden>Još nema članaka za odabrani filter. <button type="button" class="link-btn" data-reset>Prikaži sve</button></p>

<script>
(function () {
  var state = { location: null, type: null, series: null };
  var buttons = document.querySelectorAll('.filter-btn[data-filter]');
  var resets = document.querySelectorAll('[data-reset]');
  var cards = document.querySelectorAll('#clanci .post-card');
  var empty = document.getElementById('nema-clanaka');
  var lead = document.getElementById('lead');
  var izd = document.getElementById('izdvojeno');
  var zapBlok = document.getElementById('zaposlenje-blok');
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
      if (!filtering && (c.classList.contains('is-lead') || c.classList.contains('is-izd'))) ok = false;
      // oglasi za posao (Zaposlenje) prikazuju se u mreži samo uz filter Zaposlenje
      if (c.classList.contains('is-job') && state.type !== 'zaposlenje') ok = false;
      c.hidden = !ok;
      if (ok) shown++;
    });
    lead.hidden = filtering;
    if (izd) izd.hidden = filtering;
    if (zapBlok) zapBlok.hidden = filtering;
    document.querySelectorAll('[data-hide-filter]').forEach(function (el) { el.hidden = filtering; });
    document.body.classList.toggle('filtering', filtering);
    title.textContent = filtering
      ? [state.location, state.type, state.series].filter(Boolean).map(function (s) { return names[s]; }).join(' · ')
      : 'Najnoviji članci';
    buttons.forEach(function (b) {
      b.classList.toggle('active', state[b.dataset.group] === b.dataset.filter);
    });
    resets.forEach(function (r) { if (r.classList.contains('filter-btn')) r.classList.toggle('active', !filtering); });
    empty.hidden = shown > 0;
    // naslovnica ima samo 30 najnovijih: uz filter „Starije” vodi na stranicu kategorije
    var st = document.getElementById('starije-link');
    if (st) {
      var b0 = st.getAttribute('data-baza'), f0 = state.type || state.location || state.series;
      st.href = !f0 ? b0 + 'arhiva/' : (f0 === 'zaposlenje' ? b0 + 'zaposlenje/' : b0 + 'kategorije/' + f0 + '/');
      st.firstChild.textContent = f0 ? 'Starije: ' + names[f0] + ' ' : 'Starije vijesti ';
    }
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
    var blok = /^blok-|^m-najnovije$/.test(h);
    if (e && h && groupOf[h]) { state.location = null; state.type = null; state.series = null; }
    if (blok) {
      // poveznica na mobilni kategorijski blok: bez filtera, pa skok na blok
      state.location = null; state.type = null; state.series = null; vals = [];
      if (q && window.history && history.replaceState) history.replaceState(null, '', location.pathname + location.hash);
    }
    var found = false;
    vals.forEach(function (v) {
      v = v.trim().toLowerCase();
      if (groupOf[v]) { state[groupOf[v]] = v; found = true; }
    });
    apply(false);
    if (found) document.getElementById('filteri').scrollIntoView();
    else if (blok && document.getElementById(h)) document.getElementById(h).scrollIntoView();
  }
  var sviBtn = document.getElementById('m-svi-btn');
  if (sviBtn) sviBtn.addEventListener('click', function () {
    var on = !document.body.classList.contains('m-show-all');
    document.body.classList.toggle('m-show-all', on);
    sviBtn.setAttribute('aria-expanded', on ? 'true' : 'false');
    sviBtn.textContent = on ? 'Sakrij popis članaka ↑' : 'Prikaži sve članke ↓';
    if (on) document.getElementById('naslov-clanaka').scrollIntoView();
  });
  window.addEventListener('hashchange', fromUrl);
  fromUrl();
})();
</script>
