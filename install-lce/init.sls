install-tenable-lce:
  pkg.installed:
    - name: tenable-lce
    - require:
      - pkg: install-vsc-2010-sp1