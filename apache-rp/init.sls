httpd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: httpd

/var/www/index.html:
  file:
    - managed
    - source: salt://apache-rp/files/index.html
    - require:
      - pkg: httpd