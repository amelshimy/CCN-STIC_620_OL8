#!/bin/bash
echo "---------------------------------"
echo "--ELIMINANDO PAQUETES HUÉRFANOS--"
echo "---------------------------------"
read -p "Pulse ENTER para continuar o Ctrl + C para cancelar....."
dnf install -y yum-utils
dnf autoremove
dnf clean all
dnf remove `package-cleanup --orphans`
dnf remove `package-cleanup --leaves`
dnf remove --oldinstallonly
