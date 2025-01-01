set lines 2000
SET PAGESIZE 20000
col RESOURCE_NAME for a30
select RESOURCE_NAME, CURRENT_UTILIZATION, MAX_UTILIZATION,  ROUND((CURRENT_UTILIZATION/MAX_UTILIZATION)*100, 2) pct_used
from v$resource_limit 
where RESOURCE_NAME = 'processes';


/u01/app/oracle/diag/rdbms/dbstgprd/DBSTGPRD

select * from v$recovery_file_dest;

set pagesize 0
select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where status='INACTIVE';


select 'kill -9 ' || p.SPID, s.USERNAME, 'alter system kill session '''||sid||',' || s.serial# || ''';',s.STATUS
from v$session s, v$process p
where s.PADDR = p.ADDR (+)
and s.STATUS='INACTIVE'
order by 1;

alter system kill session '2316,16809' immediate;
alter system kill session '23,4495' immediate;
alter system kill session '45,913' immediate;
alter system kill session '90,943' immediate;
alter system kill session '91,645' immediate;
alter system kill session '96,465' immediate;
alter system kill session '137,1845' immediate;
alter system kill session '162,421' immediate;
alter system kill session '163,687' immediate;
alter system kill session '216,1607' immediate;
alter system kill session '224,1455' immediate;
alter system kill session '280,233' immediate;
alter system kill session '350,1581' immediate;
alter system kill session '417,1721' immediate;
alter system kill session '481,657' immediate;
alter system kill session '506,1' immediate;
alter system kill session '542,1417' immediate;
alter system kill session '593,4567' immediate;
alter system kill session '605,8303' immediate;
alter system kill session '632,1' immediate;
alter system kill session '671,77' immediate;
alter system kill session '731,645' immediate;
alter system kill session '733,6337' immediate;
alter system kill session '798,3327' immediate;
alter system kill session '843,2913' immediate;
alter system kill session '854,647' immediate;
alter system kill session '923,955' immediate;
alter system kill session '970,1159' immediate;
alter system kill session '977,671' immediate;
alter system kill session '1021,725' immediate;
alter system kill session '1110,675' immediate;
alter system kill session '1171,681' immediate;
alter system kill session '1174,677' immediate;
alter system kill session '1227,659' immediate;
alter system kill session '1231,457' immediate;
alter system kill session '1289,2279' immediate;
alter system kill session '1299,1497' immediate;
alter system kill session '1347,1277' immediate;
alter system kill session '1349,1527' immediate;
alter system kill session '1417,699' immediate;
alter system kill session '1421,645' immediate;
alter system kill session '1477,675' immediate;
alter system kill session '1486,649' immediate;
alter system kill session '1537,1479' immediate;
alter system kill session '1550,647' immediate;
alter system kill session '1608,1477' immediate;
alter system kill session '1610,901' immediate;
alter system kill session '1667,669' immediate;
alter system kill session '1669,649' immediate;
alter system kill session '1731,663' immediate;
alter system kill session '1735,1403' immediate;
alter system kill session '1738,667' immediate;
alter system kill session '1768,10155' immediate;
alter system kill session '1791,649' immediate;
alter system kill session '1864,659' immediate;
alter system kill session '1868,217' immediate;
alter system kill session '1919,527' immediate;
alter system kill session '1924,443' immediate;
alter system kill session '1977,2317' immediate;
alter system kill session '1985,597' immediate;
alter system kill session '1986,615' immediate;
alter system kill session '2031,429' immediate;
alter system kill session '2045,683' immediate;
alter system kill session '2087,1139' immediate;
alter system kill session '2112,645' immediate;
alter system kill session '2118,635' immediate;
alter system kill session '2145,9349' immediate;
alter system kill session '2175,1455' immediate;
alter system kill session '2181,943' immediate;
alter system kill session '2234,799' immediate;
alter system kill session '2242,1381' immediate;
alter system kill session '2273,7387' immediate;
alter system kill session '2285,1249' immediate;
alter system kill session '2355,1373' immediate;
alter system kill session '2357,647' immediate;
alter system kill session '2397,7113' immediate;
alter system kill session '2431,3027' immediate;
alter system kill session '2477,845' immediate;
alter system kill session '2486,647' immediate;
alter system kill session '2492,1077' immediate;
alter system kill session '2549,4073' immediate;
alter system kill session '2554,675' immediate;
alter system kill session '2606,1669' immediate;
alter system kill session '2616,665' immediate;
alter system kill session '2621,421' immediate;
alter system kill session '2677,693' immediate;
alter system kill session '2678,813' immediate;
alter system kill session '2682,645' immediate;
alter system kill session '2725,433' immediate;
alter system kill session '2731,855' immediate;
alter system kill session '2746,3315' immediate;
alter system kill session '2777,4467' immediate;
alter system kill session '2808,2973' immediate;
alter system kill session '2813,339' immediate;
alter system kill session '2838,3133' immediate;
alter system kill session '2876,1313' immediate;
alter system kill session '2922,413' immediate;
alter system kill session '2932,1605' immediate;
alter system kill session '2937,665' immediate;
alter system kill session '2939,671' immediate;
alter system kill session '2978,6455' immediate;
alter system kill session '2979,9047' immediate;
alter system kill session '2987,781' immediate;
alter system kill session '2999,2347' immediate;










req: 986254597	
req: 986254567	
req: 986254604	
req: 986254589	
req: 986254563	
req: 986254575	
req: 986254570	
req: 986254610	
req: 986254606	
req: 986254601	



