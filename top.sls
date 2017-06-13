base:
  '*':
    - common
  '*lb*':
    - apache-rp
    - internal-repo-state
  '*web*':
    - nginx
    - internal-repo-state
  '*client*':
    - tenable-lce