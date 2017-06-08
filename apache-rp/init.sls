httpd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: httpd

/var/www/index.html:
  file:
    - managed
    - source: salt://files/index.html
    - require:
      - pkg: httpd