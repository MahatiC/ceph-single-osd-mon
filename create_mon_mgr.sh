#!/bin/bash
set -x

var='/var/lib/ceph'
ceph='/etc/ceph'

for dir in $var $ceph "$var/mgr" "$var/mon" "$var/bootstrap-osd" "$var/osd"
do
  if [[ ! -e $dir ]]; then
    sudo mkdir $dir
  fi
done

ceph-authtool --create-keyring /tmp/ceph.mon.keyring --gen-key -n mon. --cap mon 'allow *'
sudo ceph-authtool --create-keyring /etc/ceph/ceph.client.admin.keyring --gen-key -n client.admin --set-uid=0 --cap mon 'allow *' --cap osd 'allow *' --cap mds 'allow *' --cap mgr 'allow *'
sudo ceph-authtool --create-keyring /var/lib/ceph/bootstrap-osd/ceph.keyring --gen-key -n client.bootstrap-osd --cap mon 'profile bootstrap-osd'

sudo chmod 644 /etc/ceph/ceph.client.admin.keyring

sudo ceph-authtool /tmp/ceph.mon.keyring --import-keyring /etc/ceph/ceph.client.admin.keyring
sudo ceph-authtool /tmp/ceph.mon.keyring --import-keyring /var/lib/ceph/bootstrap-osd/ceph.keyring

#create your own fsid below using uuidgen tool and be sure to replace this value under [global] section in ceph.conf
monmaptool --create --clobber --add mymon 127.0.0.1:6789 --fsid eeb884ad-a8bd-4618-8bda-1a0c55fd5677 /tmp/monmap

sudo rm -rf /var/lib/ceph/mon/ceph-mymon

sudo ceph-mon --mkfs -i mymon --monmap /tmp/monmap --keyring /tmp/ceph.mon.keyring

sudo ceph-mon -i mymon

ceph auth get-or-create mgr.mymgr mon 'allow profile mgr' osd 'allow *' mds 'allow *' | sudo tee /var/lib/ceph/mgr/ceph-mymgr/keyring

sudo ceph-mgr -i mymgr

















