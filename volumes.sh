#!/bin/bash 
#scan the scsi controller for new disks
echo "- - -" > /sys/class/scsi_host/host0/scan
#create new partition on disk with Linux LVM type
(echo n; echo p; echo 1; echo ; echo ; echo t; echo 8e; echo w) | fdisk /dev/sdb
#create new physical volume
pvcreate /dev/sdb1
#create new volume group
vgcreate vg01 /dev/sdb1
#add logical volume for /tmp
lvcreate -L 1G -n lv_tmp vg01
#add logical volume for /var
lvcreate -L 8G -n lv_var vg01
#add logical volume for /var/tmp
lvcreate -L 1G -n lv_var_tmp vg01
#add logical volume for /var/logical
lvcreate -L 8G -n lv_var_log vg01
#add logical volume for /var/log/audit
lvcreate -L 4G -n lv_var_log_audit vg01
#add logical voluem for /opt
lvcreate -L 8G -n lv_opt vg01
#add logical volume for /home
lvcreate -L 1G -n lv_home vg01
#add filesystem to each volume
mkfs.xfs /dev/mapper/vg01-lv_home
mkfs.xfs /dev/mapper/vg01-lv_tmp
mkfs.xfs /dev/mapper/vg01-lv_var
mkfs.xfs /dev/mapper/vg01-lv_var_tmp
mkfs.xfs /dev/mapper/vg01-lv_var_log
mkfs.xfs /dev/mapper/vg01-lv_var_log_audit
mkfs.xfs /dev/mapper/vg01-lv_opt

#install rsync
yum install rsync -y
#!/bin/bash
#make temporary directory for /home
mkdir /mnt/newhome

#mount new directory to new volume
mount /dev/mapper/vg01-lv_home /mnt/newhome

#copy existing files to new directory
rsync -aqxP /home/* /mnt/newhome

#move the current temp to home.old
mv /home /home.old

#recreate a new home directory
mkdir /home

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_home

#mount the new home directory from new volume
mount /dev/mapper/vg01-lv_home /home

#restore selinux
restorecon -vr /home

#edit fstab
echo -n "/dev/mapper/vg01-lv_home" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/home" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "defaults,nodev" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#!/bin/bash
#make temporary directory for /opt
mkdir /mnt/newopt

#mount new directory to new volume
mount /dev/mapper/vg01-lv_opt /mnt/newopt

#copy existing files to new directory
rsync -aqxP /opt/* /mnt/newopt

#move the current temp to opt.old
mv /opt /opt.old

#recreate a new opt directory
mkdir /opt

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_opt

#mount the new opt directory from new volume
mount /dev/mapper/vg01-lv_opt /opt

#restore selinux
restorecon -vr /opt

#edit fstab
echo -n "/dev/mapper/vg01-lv_opt" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/opt" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "defaults" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#!/bin/bash
#make temporary directory for /tmp
mkdir /mnt/newtmp

#mount new directory to new volume
mount /dev/mapper/vg01-lv_tmp /mnt/newtmp

#copy existing files to new directory
rsync -aqxP /tmp/* /mnt/newtmp

#move the current temp to tmp.old
mv /tmp /tmp.old

#recreate a new tmp directory
mkdir /tmp

#change permissions per CIS v2.1.1 1.1.3
chmod 1777 /dev/mapper-lv_tmp

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_tmp

#mount the new tmp directory from new volume
mount /dev/mapper/vg01-lv_tmp /tmp

#restore selinux
restorecon -vr /tmp

#edit fstab
echo -n "/dev/mapper/vg01-lv_tmp" >> /etc/fstab
echo -e -n "\t" >> /tmp    #INSERT TAB
echo -n "/tmp" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "rw,strictatime,noexec,nodev,nosuid" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstabv

#!/bin/bash
#make temporary directory for /var
mkdir /mnt/newvar

#mount new directory to new volume
mount /dev/mapper/vg01-lv_var /mnt/newvar

#copy existing files to new directory
rsync -aqxP /var/* /mnt/newvar

#move the current temp to var.old
mv /var /var.old

#recreate a new var directory
mkdir /var

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_var

#mount the new var directory from new volume
mount /dev/mapper/vg01-lv_var /var

#restore selinux
restorecon -vr /var

#edit fstab
echo -n "/dev/mapper/vg01-lv_var" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/var" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "defaults" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#!/bin/bash
#make temporary directory for /var_tmp
mkdir /mnt/newvar_tmp

#mount new directory to new volume
mount /dev/mapper/vg01-lv_var_tmp /mnt/newvar_tmp

#copy existing files to new directory
rsync -aqxP /var/tmp/* /mnt/newvar_tmp

#move the current temp to var_tmp.old
mv /var/tmp /var_tmp.old

#recreate a new var_tmp directory
mkdir /var/tmp

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_var_tmp

#mount the new var_tmp directory from new volume
mount /dev/mapper/vg01-lv_var_tmp /var/tmp

#restore selinux
restorecon -vr /var/tmp

#edit fstab
echo -n "/dev/mapper/vg01-lv_var_tmp" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/var/tmp" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "strictatime,noexec,nodev,nosuid" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#!/bin/bash
#make temporary directory for /var_log
mkdir /mnt/newvar_log

#mount new directory to new volume
mount /dev/mapper/vg01-lv_var_log /mnt/newvar_log

#copy existing files to new directory
rsync -aqxP /var/log/* /mnt/newvar_log

#move the current temp to var_log.old
mv /var/log /var_log.old

#recreate a new var_log directory
mkdir /var/log

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_var_log

#mount the new var_log directory from new volume
mount /dev/mapper/vg01-lv_var_log /var/log

#restore selinux
restorecon -vr /var/log

#edit fstab
echo -n "/dev/mapper/vg01-lv_var_log" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/var/log" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "defaults" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#!/bin/bash
#make temporary directory for /var_log_audit
mkdir /mnt/newvar_log_audit

#mount new directory to new volume
mount /dev/mapper/vg01-lv_var_log_audit /mnt/newvar_log_audit

#copy existing files to new directory
rsync -aqxP /var/log/audit/* /mnt/newvar_log_audit

#move the current temp to var_log_audit.old
mv /var/log/audit /var_log_audit.old

#recreate a new var_log_audit directory
mkdir /var/log/audit

#unmount the new directory from new volume
umount /dev/mapper/vg01-lv_var_log_audit

#mount the new var_log_audit directory from new volume
mount /dev/mapper/vg01-lv_var_log_audit /var/log/audit

#restore selinux
restorecon -vr /var/log/audit

#edit fstab
echo -n "/dev/mapper/vg01-lv_var_log_audit" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "/var/log/audit" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "xfs" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab    #INSERT TAB
echo -n "defaults" >> /etc/fstab
echo -e -n "\t" >> /etc/fstab
echo "0 0" >> /etc/fstab

#enable epel
yum install epel-release -y

#install salt master
yum install salt-master -y

#install salt minion
yum install salt-minion -y

#install salt-ssh
yum install salt-ssh -y

#install salt cloud
yum install salt-cloud -y
