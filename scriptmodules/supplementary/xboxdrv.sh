rp_module_id="xboxdrv"
rp_module_desc="Install XBox contr. 360 driver"
rp_module_menus="3+"

function install_xboxdrv() {
    rps_checkNeededPackages xboxdrv
    if [[ -z `cat /etc/rc.local | grep "xboxdrv"` ]]; then
        sed -i -e '13,$ s|exit 0|xboxdrv --daemon --id 0 --led 2 --deadzone 4000 --silent --trigger-as-button --next-controller --id 1 --led 3 --deadzone 4000 --silent --trigger-as-button --dbus disabled --detach-kernel-driver \&\nexit 0|g' /etc/rc.local
    fi
    ensureKeyValueBootconfig "dwc_otg.speed" "1" "/boot/config.txt"
    dialog --backtitle "$__backtitle" --msgbox "Installed xboxdrv and adapted /etc/rc.local. It will be started on boot." 22 76
}