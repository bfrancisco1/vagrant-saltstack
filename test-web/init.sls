include:
  - enable-ius

python2-pip:
  pkg.installed

flask:
  pip.installed:
    - require:
      - pkg: python2-pip
      - sls: enable-ius