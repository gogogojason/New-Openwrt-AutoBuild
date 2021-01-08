#!/bin/bash
sed -i "s/OpenWrt/MyRouter/g" package/base-files/files/bin/config_generate

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/64/config-5.4
