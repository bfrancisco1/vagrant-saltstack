httpd:
  pkg.installed: []
  group.present:
    - gid: 87
    - require:
      - pkg: apache
  user.present:
      - uid: 87
      - gid: 87
      - home: /var/www/html
      - shell: /bin/nologin
      - require:
        - group: apache
  service.running:
    - watch:
      - pkg: httpd
      - user: apache


/var/www/html/index.html:
  file:
    - managed
    - source: salt://apache-rp/files/index.html
    - require:
      - pkg: httpd
      - user: apache