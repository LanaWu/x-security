(() => {
  const toggle = document.querySelector('.menu-toggle');
  const nav = document.querySelector('.main-nav');
  if (!toggle || !nav) return;
  toggle.addEventListener('click', () => {
    const open = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!open));
    nav.classList.toggle('open', !open);
  });
  nav.querySelectorAll('.nav-group > .nav-link').forEach(link => {
    link.addEventListener('click', event => {
      if (window.matchMedia('(max-width: 700px)').matches) {
        const group = link.closest('.nav-group');
        if (!group.classList.contains('expanded')) {
          event.preventDefault();
          group.classList.add('expanded');
        }
      }
    });
  });
  document.addEventListener('keydown', event => {
    if (event.key === 'Escape') {
      nav.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
    }
  });
})();
