include:
  - apache

apache-group:
  group.present:
    - gid: 87

apache:
  user.present:
    - fullname: apache user
    - shell: /bin/nologin
    - gid: 87
    - require:
      - group: apache-group


httpd:
  pkg.installed: []
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

enable-proxy-module:
  apache_module.enabled:
    - name: proxy