---
layout: default
title: Kalendar događanja
permalink: /kalendar/
sidebar: true
---
{%- comment -%}
Kalendar: članci s event_date i događaji iz _data/dogadjanja.yml, po datumu, grupirani po mjesecima.
Prošli događaji (event_end, inače +3 h, a za 00:00 kraj dana) skrivaju se JS-om u pregledniku,
jer GitHub Pages gradi stranicu samo pri pushu. Gumb „Prošla događanja“ ih prikazuje.
{%- endcomment -%}
{%- assign k_mj = "siječanj,veljača,ožujak,travanj,svibanj,lipanj,srpanj,kolovoz,rujan,listopad,studeni,prosinac" | split: "," -%}
{%- assign k_dani = "ned,pon,uto,sri,čet,pet,sub" | split: "," -%}
{%- assign k_posts = site.posts | where_exp: "p", "p.event_date" | sort: "event_date" -%}
{%- comment -%} Uz članke s event_date, kalendar uključuje i događaje iz _data/dogadjanja.yml (bez duplikata: preskače stavku čiji link vodi na članak s event_date). {%- endcomment -%}
{%- assign k_data = site.data.dogadjanja.dogadjaji -%}
{%- assign k_urls = "|" -%}{%- for p in k_posts -%}{%- assign k_urls = k_urls | append: p.url | append: "|" -%}{%- endfor -%}
{%- assign k_keys = "" | split: "" -%}
{%- for p in k_posts -%}{%- assign k_k = p.event_date | date: "%Y-%m-%d %H:%M" | append: "#p#" | append: forloop.index0 -%}{%- assign k_keys = k_keys | push: k_k -%}{%- endfor -%}
{%- for d in k_data -%}
  {%- assign k_l = d.link | append: "" -%}{%- assign k_lq = "|" | append: k_l | append: "|" -%}
  {%- if k_l != "" and k_urls contains k_lq -%}{%- continue -%}{%- endif -%}
  {%- assign k_t = d.vrijeme | append: "" | slice: 0, 5 -%}{%- unless k_t.size == 5 and k_t contains ":" -%}{%- assign k_t = "00:00" -%}{%- endunless -%}
  {%- assign k_k = d.datum | date: "%Y-%m-%d" | append: " " | append: k_t | append: "#d#" | append: forloop.index0 -%}
  {%- assign k_keys = k_keys | push: k_k -%}
{%- endfor -%}
{%- assign k_keys = k_keys | sort -%}
<div class="events-page kalendar-page">
  <h1>Kalendar događanja</h1>
  <p class="intro">Svi najavljeni događaji u otoku Krku po datumu. Popis s karticama i filterom po mjestu je na stranici
  <a href="{{ '/dogadaji/' | relative_url }}">Događaji</a>.</p>
  <p><button type="button" class="filter-btn" id="kal-prosli" aria-pressed="false">Prikaži prošla događanja</button></p>
  <div class="kalendar" id="kalendar">
  {%- assign k_cur = "" -%}
  {%- for k_key0 in k_keys -%}
    {%- assign k_parts = k_key0 | split: "#" -%}
    {%- assign k_dt = k_parts[0] -%}
    {%- assign k_key = k_dt | slice: 0, 7 -%}
    {%- assign k_hm = k_dt | slice: 11, 5 -%}
    {%- if k_parts[1] == "p" -%}
      {%- assign k_i = k_parts[2] | plus: 0 -%}{%- assign post = k_posts[k_i] -%}
      {%- assign k_start = post.event_date | date: "%s" | plus: 0 -%}
      {%- if post.event_end -%}{%- assign k_end = post.event_end | date: "%s" | plus: 0 -%}{%- elsif k_hm == "00:00" -%}{%- assign k_end = k_start | plus: 86400 -%}{%- else -%}{%- assign k_end = k_start | plus: 10800 -%}{%- endif -%}
      {%- assign k_naslov = post.title -%}{%- assign k_url = post.url | relative_url -%}{%- assign k_vr = k_hm -%}{%- assign k_mjesto = post.event_place -%}{%- assign k_lok = post.location -%}{%- assign k_datum = post.event_date -%}
    {%- else -%}
      {%- assign k_j = k_parts[2] | plus: 0 -%}{%- assign k_d = k_data[k_j] -%}
      {%- assign k_end = k_d.datum_do | default: k_d.datum | date: "%s" | plus: 86400 -%}
      {%- assign k_naslov = k_d.naziv -%}{%- assign k_l = k_d.link | default: "/dogadaji/" -%}
      {%- if k_l contains "://" -%}{%- assign k_url = k_l -%}{%- else -%}{%- assign k_url = k_l | relative_url -%}{%- endif -%}
      {%- assign k_vr = k_d.vrijeme | default: "00:00" -%}{%- assign k_mjesto = k_d.mjesto -%}{%- assign k_lok = nil -%}{%- assign k_datum = k_d.datum -%}
    {%- endif -%}
    {%- if k_key != k_cur -%}
      {%- unless k_cur == "" %}</ul></section>{% endunless %}
      {%- assign k_mi = k_datum | date: "%-m" | minus: 1 %}
    <section class="kal-mjesec" data-kal-mjesec>
      <h2>{{ k_mj[k_mi] | capitalize }} {{ k_datum | date: "%Y." }}</h2>
      <ul class="kal-lista">
      {%- assign k_cur = k_key -%}
    {%- endif -%}
    {%- assign k_wi = k_datum | date: "%w" | plus: 0 %}
        <li class="kal-stavka" data-kal-end="{{ k_end }}">
          <div class="kal-datum"><span class="kal-dan">{{ k_dani[k_wi] }}</span><span class="kal-broj">{{ k_datum | date: "%-d." }}</span></div>
          <div class="kal-opis">
            <a href="{{ k_url }}">{{ k_naslov }}</a>
            <span class="meta">🕔 {% if k_vr == "00:00" %}vrijeme nije objavljeno{% else %}{{ k_vr }}{% endif %}{% if k_mjesto %} · 📍 {{ k_mjesto }}{% endif %}{% if k_lok %} · {{ k_lok }}{% endif %}</span>
          </div>
        </li>
  {%- endfor -%}
  {%- unless k_cur == "" %}</ul></section>{% endunless %}
  </div>
  <p class="no-results" id="kal-prazno" hidden>Trenutno nema najavljenih događaja.</p>
</div>
<script>
(function () {
  var now = Date.now() / 1000, btn = document.getElementById('kal-prosli'), show = false;
  function apply() {
    var any = 0;
    document.querySelectorAll('[data-kal-mjesec]').forEach(function (sec) {
      var vis = 0;
      sec.querySelectorAll('[data-kal-end]').forEach(function (li) {
        var past = Number(li.getAttribute('data-kal-end')) < now;
        li.classList.toggle('is-past', past);
        li.hidden = past && !show;
        if (!li.hidden) vis++;
      });
      sec.hidden = vis === 0; any += vis;
    });
    document.getElementById('kal-prazno').hidden = any > 0;
    btn.textContent = show ? 'Sakrij prošla događanja' : 'Prikaži prošla događanja';
    btn.setAttribute('aria-pressed', show);
  }
  btn.addEventListener('click', function () { show = !show; apply(); });
  apply();
})();
</script>
