base:
  '*':
    - common
  '*lb*':
    - apache-rp
    - internal-repo-state
  '*web*':
    - nginx
    - internal-repo-state
   'os:Windows':
    - match: grain
    - install-vscc-2010
    - install-lce