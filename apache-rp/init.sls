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
      - file: /etc/httpd/conf.d/default-site.conf


/var/www/html/index.html:
  file:
    - managed
    - source: salt://apache-rp/files/index.html
    - require:
      - pkg: httpd
      - user: apache

default-site-apache:
  file.managed:
    - name: /etc/httpd/conf.d/default-site.conf
    - source: salt://apache-rp/files/default-site.conf
    - require:
      - pkg: httpd