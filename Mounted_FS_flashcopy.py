[root@i99sv499fsc2p:/oracle/PEAI/orasys]# cd /so_ibm/scripts/flashcopy/

[root@i99sv499fsc2p:/so_ibm/scripts/flashcopy]# ls -ltr | grep PEAI
-rwxrwxr-x    1 root     system         1018 Feb 01 15:39 PEAI-pares.txt
-rwxrwxr-x    1 root     system         1154 Feb 01 15:39 PEAI.cfg
-rwxrwxr-x    1 root     system         4706 Jun 27 13:40 monta_clone_tdp_mirror_PEAI.ksh
-rwxrwxr-x    1 root     system         1391 Jun 27 15:38 split_cmd_PEAI_PRD.sh
-rwxrwxr-x    1 root     system          645 Jun 27 16:44 monta_filesystem_PEAI.ksh
-rwxrwxr-x    1 root     system          963 Jun 27 18:34 resync_cmd_PEAI_PRD.sh

# se for instancia PEAI  rodar o monta_clone_tdp_mirror_PEAI.ksh, senao rodar monta_clone_tdp_mirror.ksh + o cfg da instancia especifica
/so_ibm/scripts/flashcopy/monta_clone_tdp_mirror.ksh /so_ibm/scripts/flashcopy/ICT.cfg
/so_ibm/scripts/flashcopy/monta_clone_tdp_mirror_PEAI.ksh /so_ibm/scripts/flashcopy/PEAI.cfg


# a primeira linha apos a execucao gera uma log ex:
[root@i99sv499fsc2p:/so_ibm/scripts/flashcopy]# /so_ibm/scripts/flashcopy/monta_clone_tdp_mirror_PEAI.ksh /so_ibm/scripts/flashcopy/PEAI.cfg
/so_ibm/log/montaclone-PEAI-20220730_053706.log

# verifique se a log se os na log se os vgs foram montados com sucesso