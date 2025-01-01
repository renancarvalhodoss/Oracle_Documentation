Servidor atlanta CLIENTE ADP
High space used (90%) for /rhweb29/temp ou /rhweb29/tmpbat
[atlanta@soadm2:/home/soadm2]$ sudo su -
rodar
find / <<COLOCAR TEMP OU TMPBAT, CONF O CHAMADO>> -size +200000 | xargs -I {} ls -ld {} | sort -n -k 5
[atlanta@root:/]# find /rhweb27/temp  -size +200000  | xargs -I {} ls -ld {} | sort -n -k 5
-rw-rw-rw-    1 root     system   21543986176 Apr 09 09:37 /rhweb29/tmpbat/srtZ_aqeb
-rw-rw-rw-    1 root     system   25064205312 Apr 09 09:37 /rhweb29/tmpbat/srtOBWqeb
-rw-rw-rw-    1 root     system   81605069824 Apr 09 09:37 /rhweb29/tmpbat/lbiZcaqea
-rw-rw-rw-    1 root     system   94979079168 Apr 09 09:37 /rhweb29/tmpbat/lbiNvWqea
[atlanta@root:/]# df -g /rhweb29/tmpbat
Filesystem    GB blocks      Free %Used    Iused %Iused Mounted on
/dev/rhweb29_tmpbat_     69.88     21.15   70%      358     1% /rhweb29/tmpbat
ver se tem pid relacionado
se nao tiver, vai voltar conforme abaixo
[atlanta@root:/]# fuser /rhweb29/tmpbat/lbiNvWqea
/rhweb29/tmpbat/lbiNvWqea:
[atlanta@root:/]# fuser /rhweb29/tmpbat/lbiZcaqea
/rhweb29/tmpbat/lbiZcaqea:
[atlanta@root:/]# fuser /rhweb29/tmpbat/srtOBWqeb
/rhweb29/tmpbat/srtOBWqeb:
[atlanta@root:/]# fuser /rhweb29/tmpbat/srtZ_aqeb
/rhweb29/tmpbat/srtZ_aqeb:
[atlanta@root:/]#
Entao pode apagar, conforme abaixo
[atlanta@root:/]# > /rhweb29/tmpbat/srtZ_aqeb
[atlanta@root:/]# > /rhweb29/tmpbat/srtOBWqeb
[atlanta@root:/]# > /rhweb29/tmpbat/lbiZcaqea
[atlanta@root:/]# > /rhweb29/tmpbat/lbiNvWqea
[atlanta@root:/]# df -g /rhweb29/tmpbat
Filesystem    GB blocks      Free %Used    Iused %Iused Mounted on
/dev/rhweb29_tmpbat_     69.88     69.54    1%      358     1% /rhweb29/tmpbat
[atlanta@root:/]#
CONFORME LUCIVAN
vc so nao faz isso nas areas dos bancos
os /ai/* - /bi/* - /db/* - /db1/*
nas areas /temp /tmpbat pode