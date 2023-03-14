#!/bin/bash
echo "--------------------------------"
echo "--APLICANDO CONTRASEÑA DE GRUB--"
echo "--------------------------------"
read -p "Pulse ENTER para continuar o Ctrl + C para cancelar....."
echo
echo "<<Inserte usuario para la edicion de GRUB>>:  "
read -p "" USUG
grub2-mkpasswd-pbkdf2 | tee -a hash
var=$(tail -n1 hash | cut -d' ' -f8)
echo set superusers="$USUG" >>/etc/grub.d/40_custom
echo password_pbkdf2 $USUG $var >>/etc/grub.d/40_custom
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
chmod 600 /boot/grub2/grub.cfg
chmod 600 /boot/efi/EFI/redhat/grub.cfg

chmod 755 /etc/grub.d/40_custom
chown root:root /etc/grub.d/40_custom