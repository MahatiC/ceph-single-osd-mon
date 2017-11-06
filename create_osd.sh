#!/bin/bash
set -x

#if no OSD exists, i.e if previous OSDs are purged correctly, the ID created below will be 0 (i.e. smallest available number)
UUID=$(uuidgen)
OSD_SECRET=$(ceph-authtool --gen-print-key)
ID=$(echo "{\"cephx_secret\": \"$OSD_SECRET\"}" | sudo ceph osd new $UUID -i - -n client.bootstrap-osd -k /var/lib/ceph/bootstrap-osd/ceph.keyring)

#if you're using a separate disk for OSD, make sure to mount it onto the /var/lib/ceph/osd/ceph-$ID
sudo ceph-authtool --create-keyring /var/lib/ceph/osd/ceph-$ID/keyring --name osd.$ID --add-key $OSD_SECRET
sudo ceph-osd -i $ID --mkfs --osd-uuid $UUID
#sudo chown -R ceph:ceph /var/lib/ceph/osd/ceph-$ID
sudo ceph-osd -i $ID
