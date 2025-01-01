    ---- setar asm--------
    sqlplus / as sysasm
    crsctl status res -t
    crsctl check crs
    alter diskgroup DATA mount;
    select name, state from v$asm_diskgroup;


