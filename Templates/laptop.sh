sh ~liparadise/Templates/undervolt.sh
echo ""
echo "undervolt results:"
undervolt --read
echo ""
rfkill block bluetooth
rfkill list | grep -A3 "Bluetooth"
echo ""
sh ~liparadise/Templates/disable_watchdog.sh
echo ""
