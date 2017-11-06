# ceph-single-osd-mon
Creates a Ceph cluster with one OSD, one monitor and a manager daemon

Be sure to read through the scripts to replace with custom values for partitions etc.

Run the below scripts to create the cluster:

1) create_mon_mgr.sh
2) create_osd.sh

It will create manager and monitor with 'mymgr' and 'mymon' names respectively.
Run the script "remove_osd_mon_mgr.sh" to tear down the cluster.
