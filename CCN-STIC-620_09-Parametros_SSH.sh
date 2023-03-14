#!/bin/bash
tiempo=$( date +"%d-%b-%y-%H:%M:%S" )

echo "-----------------------------------"
echo "-- MODIFICANDO CONFIGURACION SSH --"
echo "-----------------------------------"
echo -e "\n"
echo " ANTES DE COMENZAR SE CREARÁ UN BACKUP DEL FICHERO "/etc/ssh/sshd_config" " 
echo " CON LA SIGUIENTE NOMENCLATURA "/etc/ssh/sshd_config_backup[fecha/hora]" "
echo " NO DETENGA EL SCRIPT, NI HAGA NADA HASTA QUE EL SCRIPT FINALICE"
echo " EN CASO DE DETENCIÓN DEL SCRIPT; VUELVA A EJECUTARLO ANTES DE REINICIAR HASTA QUE FINALICE EL PROCESO CORRECTAMENTE"
read -p "Pulse ENTER para continuar o Ctrl + C para cancelar....."
cp -r /etc/ssh/sshd_config /etc/ssh/sshd_config_bakup_$tiempo
cat /etc/ssh/sshd_config |grep -v "#" >/etc/ssh/sshd_config.R

echo "<<introduzca el puerto de escucha SSH que desea >> a continuación:  "
read -p "" PORT

sed -i '1i###############################################################\n# Parámetros configuración perfilado intermedio de seguridad\n###############################################################\n\nPort '$PORT' \nProtocol 2\nHostKey /etc/ssh/ssh_host_rsa_key\nHostKey /etc/ssh/ssh_host_ecdsa_key\nHostKey /etc/ssh/ssh_host_ed25519_key\nSyslogFacility AUTHPRIV\nLoginGraceTime 2m  \nPermitRootLogin no  \nMaxAuthTries 6\nAuthorizedKeysFile	.ssh/authorized_keys\nPermitEmptyPasswords no\nPasswordAuthentication yes\nChallengeResponseAuthentication no\nKerberosAuthentication no\nGSSAPIAuthentication no\nGSSAPICleanupCredentials no\nUsePAM yes\nX11Forwarding no\nPrintMotd no\nPermitUserEnvironment no\nClientAliveInterval 300\nClientAliveCountMax 3\nPermitTunnel no\nBanner /etc/issue.net\nAcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES\nAcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT\nAcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE\n	X11Forwarding no\n	AllowTcpForwarding no\nKexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr\nMACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com\n###############################################################\n# Parámetros configuración previos de la organización\n###############################################################
' /etc/ssh/sshd_config

semanage port -m -t ssh_port_t -p tcp $PORT

service sshd reload

systemctl status sshd.service

gnome-text-editor /etc/ssh/sshd_config

echo "El script ha finalizado de configurar los parámetros de SSH"
read -p "Pulse ENTER para continuar o Ctrl + C para cancelar....."