    ---- setar asm--------
    sqlplus / as sysasm
    crsctl status res -t
    crsctl check crs
    alter diskgroup DATA mount;
    alter diskgroup DG_ARCH mount;
alter diskgroup DATA mount;

    select name, state from v$asm_diskgroup;



==== Summary of resource auto-start failures follows =====
CRS-2807: Resource 'ora.DG_ARCH.dg' failed to start automatically.
CRS-2807: Resource 'ora.DG_DATA.dg' failed to start automatically.
CRS-2807: Resource 'ora.gsdbesi.db' failed to start automatically.
CRS-6016: Resource auto-start has completed for server dc12prdgsdb01
CRS-6024: Completed start of Oracle Cluster Ready Services-managed resources
CRS-4123: Oracle High Availability Services has been started.
