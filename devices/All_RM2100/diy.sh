find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4

sed -i "s/OpenWrt_2G/RMWiFi/g" feeds/custom/mt-drivers/mt_wifi/files/mt7603.dat
sed -i "s/OpenWrt_5G/RMWiFi_5G/g" feeds/custom/mt-drivers/mt_wifi/files/mt7612.dat
sed -i "s/OpenWrt_5G/RMWiFi_5G/g" feeds/custom/mt-drivers/mt_wifi/files/mt7615.dat


sed -i 's/${Arch}/${Arch}_softfloat/g' feeds/custom/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
rm -f feeds/custom/luci-theme-edge/htdocs/luci-static/edge/logo.png
cp package/logos/milogo.png feeds/custom/luci-theme-edge/htdocs/luci-static/edge/logo.png
rm package/logos -r
