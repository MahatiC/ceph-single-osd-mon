# ceph-single-osd-mon
Creates a Ceph cluster with one OSD, one monitor and a manager daemon

Be sure to read through the scripts to replace with custom values for partitions etc.

Place ceph.conf in /etc/ceph. And run the below scripts to create a cluster:

1) create_mon_mgr.sh
2) create_osd.sh

It will create manager and monitor with 'mymgr' and 'mymon' names respectively.
Run the below script to tear down the cluster.

3) remove_osd_mon_mgr.sh
