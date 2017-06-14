install-tenable-lce:
  pkg.installed:
    - name: tenable-lce
    - require:
      - pkg: ms-vsc-2010-sp1