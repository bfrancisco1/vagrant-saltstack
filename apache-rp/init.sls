httpd:
  pkg.installed: []
  service.running:
    - watch:
      - pkg: httpd
      - user: apache
  user.present:
      - uid: 87
      - gid: 87
      - home: /var/www/html
      - shell: /bin/nologin
      - require:
        - group: apache
  group.present:
    - gid: 87
    - require:
      - pkg: apache

/var/www/html/index.html:
  file:
    - managed
    - source: salt://apache-rp/files/index.html
    - require:
      - pkg: httpd
      - user: apache