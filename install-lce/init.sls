install-tenable-lce:
  pkg.installed:
    - name: tenable-lce
    - require:
      - sls: install-vscc-2010