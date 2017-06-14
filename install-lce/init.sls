install-tenable-lce:
  pkg.installed:
    - name: tenable-lce
    - require:
      - pkg: install-vscc-2010