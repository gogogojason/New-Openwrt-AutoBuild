#!/bin/bash
#=================================================
rm -Rf feeds/custom/diy
mv -f feeds/packages/libs/libx264 feeds/custom/libx264
mv -f feeds/packages/net/aria2 feeds/custom/aria2
mv -f feeds/packages/net/openvpn feeds/custom/openvpn
mv -f feeds/packages/admin/netdata feeds/custom/netdata
mv -f feeds/packages/net/shadowsocks-libev feeds/custom/shadowsocks-libev
rm -Rf feeds/packages/net/{smartdns,frp,mwan3,miniupnpd,aria2} feeds/luci/applications/{luci-app-dockerman,luci-app-smartdns,luci-app-frpc}
svn co https://github.com/project-openwrt/packages/trunk/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful
rm -Rf feeds/custom/luci-app-unblockmusic
rm -Rf feeds/custom/UnblockNeteaseMusic-Go
rm -Rf feeds/custom/UnblockNeteaseMusic
rm -Rf feeds/custom/ddns-scripts-aliyun
rm -Rf feeds/custom/ddns-scripts-dnspod
svn co https://github.com/Lienol/openwrt/trunk/package/lean/luci-app-unblockmusic feeds/custom/luci-app-unblockmusic
svn co https://github.com/Lienol/openwrt/trunk/package/lean/UnblockNeteaseMusic feeds/custom/UnblockNeteaseMusic
svn co https://github.com/Lienol/openwrt/trunk/package/lean/UnblockNeteaseMusicGo feeds/custom/UnblockNeteaseMusicGo
svn co https://github.com/Lienol/openwrt/trunk/package/lean/ddns-scripts-aliyun feeds/custom/ddns-scripts-aliyun
svn co https://github.com/Lienol/openwrt/trunk/package/lean/ddns-scripts-dnspod feeds/custom/ddns-scripts-dnspod
rm -Rf feeds/custom/AdGuardHome
rm -Rf feeds/custom/luci-app-adguardhome
#sed -i 's/etc\/AdGuardHome/etc\/AdGuardHome\/AdGuardHome/g' /luci-app-adguardhome/root/etc/init.d/AdGuardHome
svn co https://github.com/kenzok8/openwrt-packages/trunk/AdGuardHome feeds/custom/AdGuardHome
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome feeds/custom/luci-app-adguardhome
#sed -i 's/etc\/AdGuardHome/etc/g' feeds/custom/luci-app-adguardhome/root/etc/config/AdGuardHome
./scripts/feeds update luci packages custom
./scripts/feeds install -a
./scripts/feeds update -a
sed -i 's/Os/O2/g' include/target.mk
rm -Rf package/network/utils/iwinfo; svn co https://github.com/coolsnowwolf/lede/trunk/package/network/utils/iwinfo package/network/utils/iwinfo
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
echo -e "\q" | svn co https://github.com/project-openwrt/openwrt/branches/master/package/network/utils/iptables/patches package/network/utils/iptables/patches
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i '/depends on PACKAGE_php7-cli || PACKAGE_php7-cgi/d' package/*/*/php7/Makefile
sed -i 's/DEPENDS:= strongswan/DEPENDS:=+strongswan/g' package/*/*/strongswan/Makefile
sed -i '/exit 1/d' package/*/*/docker-ce/Makefile
sed -i 's/+acme\( \|$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/bench.log' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/\/etc\/profile/d' package/base-files/files/lib/upgrade/keep.d/base-files-essential
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
find target/linux -path "target/linux/*/config-*" | xargs -i sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\n \
CONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\nCONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' {}
sed -i 's/service_start $PROG/service_start $PROG -R/g' package/*/*/php7/files/php7-fpm.init
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
rm -rf ./feeds/packages/lang/golang
svn co https://github.com/project-openwrt/packages/trunk/lang/golang feeds/packages/lang/golang
mkdir package/network/config/firewall/patches
wget -O package/network/config/firewall/patches/fullconenat.patch https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
sed -i 's?package.mk?package.mk\ninclude $(INCLUDE_DIR)/package_lang.mk?g' package/*/custom/luci-app-*/Makefile
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i '/killall -HUP/d' feeds/luci/luci.mk
find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
find package/feeds/custom/*/ -maxdepth 1 -name "Makefile" ! -path "*rclone*" ! -path "*shadowsocksr-libev*" ! -path "*rtl8821cu*" \
| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
date1=`date +%Y.%m.%d`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='hfy166 Ver.D$date1'/g" package/base-files/files/etc/openwrt_release
sed -i "s/192.168.1.1/192.168.2.1/g" package/base-files/files/bin/config_generate
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini
sed -i 's/https:\/\/op.supes.top/http:\/\/openwrt.ink:8666/g' feeds/custom/luci-app-gpsysupgrade/root/usr/bin/upgrade.lua
sed -i 's/https:\/\/op.supes.top/http:\/\/openwrt.ink:8666/g' feeds/custom/luci-app-gpsysupgrade/luasrc/model/cbi/gpsysupgrade/sysupgrade.lua
rm -f feeds/custom/luci-app-gpsysupgrade/luasrc/view/admin_status/index/links.htm
git clone https://github.com/gogogojason/logos.git package/logos
cp package/logos/oplinks.htm feeds/custom/luci-app-gpsysupgrade/luasrc/view/admin_status/index/links.htm
rm -f package/system/rpcd/Makefile
cp package/logos/oldrpcd package/system/rpcd/Makefile
sed -i 's/系统在线更新/系统升级/g' feeds/custom/luci-app-gpsysupgrade/po/zh_Hans/gpsysupgrade.po
sed -i "1i\msgstr \"Passwall+\"" feeds/custom/luci-app-bypass/po/zh_Hans/bypass.zh-cn.po
sed -i "1i\msgid \"Bypass\"" feeds/custom/luci-app-bypass/po/zh_Hans/bypass.zh-cn.po
sed -i "2a\lovertg520" feeds/custom/luci-app-bypass/po/zh_Hans/bypass.zh-cn.po
sed -i 's/lovertg520//g' feeds/custom/luci-app-bypass/po/zh_Hans/bypass.zh-cn.po
sed -i 's/"IP限速"/"网速控制"/g' feeds/custom/luci-app-eqos/po/zh_Hans/eqos.po
sed -i 's/+luci-theme-bootstrap/+luci-theme-edge/g' feeds/luci/collections/luci/Makefile
sed -i "s/bootstrap/argon/g" feeds/luci/modules/luci-base/root/etc/config/luci
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/a0f4fe0c3eb8faa5bd9c8376d132f340b9558e750c91deb2d5028aa3d0047767/993a3a5490a544c2cbf2ef15cf7e7ed21af1845baf228318d5c36ef8827e157c/g' package/network/utils/iptables/Makefile
sed -i 's/1.8.6/1.8.4/g' package/network/utils/iptables/Makefile
