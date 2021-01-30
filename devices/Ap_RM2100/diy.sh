find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4
sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json

sed -i "s/OpenWrt_2G/RMWiFi/g" feeds/custom/mt-drivers/mt_wifi/files/mt7603.dat
sed -i "s/OpenWrt_5G/RMWiFi_5G/g" feeds/custom/mt-drivers/mt_wifi/files/mt7612.dat
sed -i "s/OpenWrt_5G/RMWiFi_5G/g" feeds/custom/mt-drivers/mt_wifi/files/mt7615.dat
sed -i "s/OpenWrt/MiRouter/g" package/base-files/files/bin/config_generate

rm -f feeds/custom/luci-theme-edge/htdocs/luci-static/edge/logo.png
cp package/logos/milogo.png feeds/custom/luci-theme-edge/htdocs/luci-static/edge/logo.png
cp package/logos/opcpuinfo files/sbin/cpuinfo
rm -Rf package/logos
