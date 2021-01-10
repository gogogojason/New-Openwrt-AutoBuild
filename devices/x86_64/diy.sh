#!/bin/bash
sed -i "s/OpenWrt/MyRouter/g" package/base-files/files/bin/config_generate
rm -f feeds/custom/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
cp package/logos/opunblockmusic.po feeds/custom/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
rm package/logos -r

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/64/config-5.4
