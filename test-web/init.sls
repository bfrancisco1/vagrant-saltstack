include:
  - enable-ius

python2-pip:
  pkg.installed

flask:
  pip.installed:
    - require:
      - pkg: python-pip
      - sls: enable-ius