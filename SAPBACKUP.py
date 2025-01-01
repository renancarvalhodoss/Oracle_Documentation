#----------------------------correcao das permissoes para execucao do backup---------------------------#
[hoafp001alp:root:/usr/sap/PJD/SYS/exe/run:] saproot.sh

# ---------------------------comandos de execucoes dos bkps inc e full --------------------------------#
su - oracle -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/bkp_online_FSAPD_INC.ksh'
su - oracle -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/archive.ksh PJD'
su - oracle -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/bkp_online_FSAPD_FULL.ksh'
su - oracle -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/brarchive_SPOUXPID_FSAPW_PJD.ksh'
su - oracle -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/brbackup_SPOUXPOPDB_FSAPD_POP.ksh'
/sapmnt/PJD/exe/uc/rs6000_64/brarchive -c -sd -u //
dsmc -se=SPOUXPID_ASAPW_PJD

Protect> q sched

ksh -c /usr/tivoli/tsm/tdp_r3/ora64/bkp_online_ASAPW.ksh

/oracle/SPD/saparch/lista.log

#-----------encontrar o caminho atraves do protect-------------------
dsmc -se=SPOUXPID_ASAPW_PJD

 dsmc -se=HOBIQ001ALP_ASAPW_BIQ
 dsmc -se=HOSPD001ALP_ASAPW_SPD

#----------------------------caminho dos scripts brarchive----------------------------------------------#
C:\TSM\SAP\SCRIPTS

/usr/sap/POP/SYS/exe/run/brbackup -u / -c -t online


  #Nla&LTF64m2fUcVR%
[dc12prdrhweb84:root:/rhweb84/tmpbat:] df -g .
           Filesystem      GB blocks      Free    %Used    Iused  %Iused      Mounted on
 /dev/lvrhweb84tmpbat         102.08      101.46     1%      120     1%       /rhweb84/tmpbat

./RmanArchiveLog.ksh PRDBLOC /u03/oradata/PRDBLOC/archive

 su - spdadm -c 'ksh -c /usr/tivoli/tsm/tdp_r3/ora64/bkp_online_FSAPW_BIQ.ksh'








