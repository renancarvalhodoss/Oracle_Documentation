srvctl status database -d ogld01dr
uptime
 srvctl start database -d ogld01dr
 shutdown abort;

 srvctl start instance -db LBSTCDB
 srvctl start instance -d ogld01dr -i ogld01dr1

srvctl start database -d LBSTCDB -n node2
crsctl start resource ora.LBSTCDB.db -n node2
 ./crsctl start res pra.crsd -init

 srvctl start database -d LBSTCDB
 srvctl status scan_listener