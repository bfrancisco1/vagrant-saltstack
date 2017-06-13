tenable-lce:
  '4.4.0':
    full_name: Tenable LCE Installer
    installer: 'salt://installs/lce_client-4.4.0-windows_2008_x64.msi'
    install_flags: 'SERVERPORT=31300 /L*V c:\temp\lce.log /qn /norestart'
    uninstaller: 'salt://installs/lce_client-4.4.0-windows_2008_x64.msi'
    uninstall_flags: '/qn /norestart'
    msiexec: True
    locale: en_US
    reboot: false