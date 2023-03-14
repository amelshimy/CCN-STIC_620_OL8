#!/bin/bash
echo "---------------------------------------"
echo "--DESINSTALANDO USUARIOS INNECESARIOS--"
echo "---------------------------------------"
read -p "Pulse ENTER para continuar o Ctrl + C para cancelar....."

cat /etc/shells|grep "sbin"|grep -q "halt"

if ! [[ $? = 0 ]]; then

	echo "/sbin/halt" >> /etc/shells
fi

cat /etc/shells|grep "sbin"|grep -q "shutdown"

if ! [[ $? = 0 ]]; then

	echo "/sbin/shutdown" >> /etc/shells
fi

cat /etc/shells|grep "bin"|grep -q "false"

if ! [[ $? = 0 ]]; then

	echo "/bin/false" >> /etc/shells
fi

groupdel games
groupdel floppy
userdel games


cat /etc/passwd | cut -d ":" -f1,2,3,4,6> /Scripts/rcs.txt

for LOGIN in `awk -F: '( $3 >= 1 && $3 < 1000 ) { print $1 }' /Scripts/rcs.txt`
do
   echo $LOGIN
   usermod -s /bin/false $LOGIN
done

chsh -s /bin/false root 
chsh -s /bin/false nobody 
chsh -s /sbin/shutdown shutdown 
chsh -s /sbin/halt halt 
