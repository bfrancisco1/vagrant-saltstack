nginx:
  pkg.installed

run-nginx:
  service.running:
  - name: nginx
  - enable: True
  - watch:
    - file: /etc/nginx/nginx.conf
  - require:
    - file: /etc/nginx/nginx.conf
    - pkg: nginx

conf-nginx:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

/var/www/html:
  - file.recurse:
    - source: salt://nginx/files/html
    - include_empty: True
