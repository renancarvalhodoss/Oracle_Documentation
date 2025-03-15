icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.164.94\mock1_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.164.73\mock1_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.47\DLSI-OCI_private_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.51\DLSI-OCI_private_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.34\zabbix_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F 
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.73\DLSI-OCI_openssh.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private.ppk" /inheritance:r /grant:r RenanCarvalhoDosSant:F
icacls "C:\Clientes\Essilor\OCI_Acesso\172.22.164.51\ess-ocikey-PROD.pem" /inheritance:r /grant:r RenanCarvalhoDosSant:F
scp -r /tmp/kHC_*aggregate_FINAL.report.txt soadm1@172.22.165.47:/tmp/hc_pdb
# ----------------------------------ESSLPBR12DB1-------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.94\mock1_openssh.pem opc@172.22.164.94

# ----------------------------------ESSLPBR12DB2--------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.73\mock1_openssh.pem opc@172.22.164.73

# ----------------------------------ESSLTLSIDB01--------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.80\DLSI-OCI_private_openssh.pem opc@172.22.165.80

# ----------------------------------ESSLDLSIDB01--------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.73\DLSI-OCI_openssh.pem opc@172.22.165.73

# ----------------------------------HODBQESS028---------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.47\DLSI-OCI_private_openssh.pem opc@172.22.165.47

# ----------------------------------HODBQESS025---------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.51\DLSI-OCI_private_openssh.pem opc@172.22.165.51


# ----------------------------------TOWERZABBIX---------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.165.34\zabbix_openssh.pem opc@172.22.165.34


# ----------------------------------hoebspessapp01--------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.51\ess-ocikey-PROD.pem opc@172.22.164.51

# ----------------------------------hoebspessapp02--------------------------------------------------------------
ssh -i C:\Clientes\Essilor\OCI_Acesso\172.22.164.51\ess-ocikey-PROD.pem opc@172.22.164.29