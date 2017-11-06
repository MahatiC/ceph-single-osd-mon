#!/bin/bash

#remove OSD 0; this assumes the OSD created is 0 (smallest number) in a single OSD setup
sudo pkill ceph-osd -9
sudo ceph osd down 0
sudo ceph osd out 0
sudo ceph osd purge 0 --yes-i-really-mean-it
sudo rm -rf /var/lib/ceph/osd/ceph-0

#comment out the below three lines if you're not using a separate disk for OSD; Otherwise change the partition names accordingly
sudo umount /dev/disk/by-partlabel/osd-device-0-data
sudo mkfs.xfs /dev/disk/by-partlabel/osd-device-0-data -f
sudo mount /dev/disk/by-partlabel/osd-device-0-data /var/lib/ceph/osd/ceph-0

#kill mon and mgr
sudo pkill ceph-mon
sudo pkill ceph-mgr
