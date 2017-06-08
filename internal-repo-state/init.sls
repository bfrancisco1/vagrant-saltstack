/etc/yum.repos.d:
  file.recurse:
    - name: salt://internal-repo-state/files
    - clean: true