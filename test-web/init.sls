include:
  - enable-ius

python-pip:
  pkg.installed

flask:
  pip.installed:
    - require:
      - pkg: python-pip
      - sls: enable-ius