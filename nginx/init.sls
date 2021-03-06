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
    - user: nginx
    - group: nginx
    - mode: 644
    - require:
      - pkg: nginx

html-nginx:
  file.recurse:
    - name: /var/www/html
    - source: salt://nginx/files/html
    - include_empty: True

index-nginx:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://nginx/files/{{ pillar['index-file'] }}.html
    - user: nginx
    - group: nginx
    - mode: 644
