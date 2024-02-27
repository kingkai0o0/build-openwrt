#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
sed -i 's/192.168.8.1/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
svn co https://github.com/coolsnowwolf/lede package/luci-app-accesscontrol
svn co https://github.com/coolsnowwolf/lede package/luci-app-adguardhome
svn co https://github.com/coolsnowwolf/lede package/luci-app-arpbind
svn co https://github.com/coolsnowwolf/lede package/luci-app-autoreboot
svn co https://github.com/coolsnowwolf/lede package/luci-app-ddns
svn co https://github.com/coolsnowwolf/lede package/luci-app-diskman
svn co https://github.com/coolsnowwolf/lede package/luci-app-docker
svn co https://github.com/coolsnowwolf/lede package/luci-app-filetransfer
svn co https://github.com/coolsnowwolf/lede package/luci-app-firewall
svn co https://github.com/coolsnowwolf/lede package/luci-app-netdata
svn co https://github.com/coolsnowwolf/lede package/luci-app-nlbwmon
svn co https://github.com/coolsnowwolf/lede package/luci-app-nps
svn co https://github.com/coolsnowwolf/lede package/luci-app-openclash
svn co https://github.com/coolsnowwolf/lede package/luci-app-passwall
svn co https://github.com/coolsnowwolf/lede package/luci-app-smartdns
svn co https://github.com/coolsnowwolf/lede package/luci-app-ssr-plus
svn co https://github.com/coolsnowwolf/lede package/luci-app-syncdial
svn co https://github.com/coolsnowwolf/lede package/luci-app-ttyd
svn co https://github.com/coolsnowwolf/lede package/luci-app-turboacc
svn co https://github.com/coolsnowwolf/lede package/luci-app-upnp
svn co https://github.com/coolsnowwolf/lede package/luci-app-wol
svn co https://github.com/coolsnowwolf/lede package/luci-app-wrtbwmon


# Fix runc version error
# rm -rf ./feeds/packages/utils/runc/Makefile
# svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------

