ssh -oKexAlgorithms=diffie-hellman-group1-sha1 -c aes128-cbc ibmfso2@10.141.68.141
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c aes128-cbc
ssh -oKexAlgorithms=diffie-hellman-group1-sha1 -c aes128-cbc soadm1@172.16.2.201
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c aes128-cbc soadm1@172.16.2.201