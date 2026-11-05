/* Moj Otok Krk – popisi članaka: prvih N + gumb „VIŠE”, filtar-čipovi; stare poveznice /kategorije/#slug */
(function () {
  /* /kategorije/#mrkopalj → /kategorije/mrkopalj/ */
  var hub = document.querySelector('.kat-hub');
  if (hub && location.hash.length > 1) {
    var t = document.getElementById(decodeURIComponent(location.hash.slice(1)));
    if (t && t.classList.contains('kat-tile')) { location.replace(t.href); return; }
  }

  function rijec(n) {
    var a = n % 10, b = n % 100;
    if (b >= 11 && b <= 14) return 'članaka';
    if (a === 1) return 'članak';
    if (a >= 2 && a <= 4) return 'članka';
    return 'članaka';
  }

  [].forEach.call(document.querySelectorAll('[data-kl]'), function (box) {
    var po = parseInt(box.getAttribute('data-po'), 10) || 10;
    var items = [].slice.call(box.querySelectorAll('[data-kl-lista] > li'));
    var btn = box.querySelector('[data-kl-vise]');
    var btnN = box.querySelector('[data-kl-vise-n]');
    var status = box.querySelector('[data-kl-status]');
    var prazno = box.querySelector('[data-kl-prazno]');
    var chips = document.querySelector('[data-kl-chips="' + box.id + '"]');
    var broj = document.querySelector('[data-kat-broj]');
    var brojR = document.querySelector('[data-kat-rijec]');
    var shown = po, filt = '';

    function matches() {
      return items.filter(function (li) { return !filt || (li.getAttribute('data-tags') || '').indexOf(',' + filt + ',') !== -1; });
    }
    function render() {
      var m = matches();
      items.forEach(function (li) { li.hidden = true; li.classList.remove('kl-prvi'); });
      m.forEach(function (li, i) { if (i < shown) li.hidden = false; });
      if (m[0]) m[0].classList.add('kl-prvi');
      var vis = Math.min(shown, m.length), rest = m.length - vis;
      btn.hidden = rest <= 0;
      if (rest > 0) btnN.textContent = '(još ' + Math.min(rest, po) + ' od ' + rest + ')';
      status.hidden = m.length <= po;
      status.textContent = 'Prikazano ' + vis + ' od ' + m.length;
      if (prazno) prazno.hidden = m.length > 0;
      if (broj && chips) { broj.textContent = m.length; if (brojR) brojR.textContent = rijec(m.length); }
    }
    btn.addEventListener('click', function () {
      var prije = Math.min(shown, matches().length);
      shown += po;
      render();
      var novi = matches()[prije];
      if (novi) { var a = novi.querySelector('a'); if (a) a.focus({ preventScroll: true }); }
    });
    if (chips) {
      chips.hidden = false;
      chips.addEventListener('click', function (e) {
        var c = e.target.closest('[data-kl-filter]');
        if (!c) return;
        filt = c.getAttribute('data-kl-filter');
        [].forEach.call(chips.querySelectorAll('[data-kl-filter]'), function (x) {
          var on = x === c; x.classList.toggle('is-active', on); x.setAttribute('aria-pressed', on ? 'true' : 'false');
        });
        shown = po;
        render();
      });
    }
    box.classList.add('kl-js');
    render();
  });
})();
