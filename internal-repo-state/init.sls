/etc/yum.repos.d:
  file.recurse:
    - source: salt://internal-repo-state/files
    - clean: true