#!/bin/bash
# Armbian ApoSeek v1.0 - Complete Personalization

echo "🎯 Armbian ApoSeek v1.0 - Applying personal touches..."

# 1. Boot0 Integration
if [[ -f "./userpatches/bootloader/sunxi/boot0_sdcard_axp1530.fex" ]]; then
    echo "✅ Using real boot0 with AXP1530 support"
    cp ./userpatches/bootloader/sunxi/boot0_sdcard_axp1530.fex ${SDCARD}/boot/boot0_sdcard.fex
fi

# 2. Hostname personalizado
echo "mxqbox_server" > ${SDCARD}/etc/hostname
sed -i 's/127.0.1.1.*/127.0.1.1\tmxqbox_server/g' ${SDCARD}/etc/hosts

# 3. MOTD personalizado - Armbian ApoSeek v1.0
cat > ${SDCARD}/etc/motd << 'MOTD_EOF'

╔═══════════════════════════════════════╗
║           Armbian ApoSeek v1.0          ║
║        MXQ Pro H616 Server            ║
║     Developer: Nathan Mateo           ║
║     Email: apocalisys@github.com          ║
║            apocalisys@gmail.com             ║
║     GitHub: apocalisys                   ║
║   Filipenses 4:13 - Todo lo puedo en  ║
║        Cristo que me fortalece        ║
╚═══════════════════════════════════════╝

MOTD_EOF

# 4. Información del sistema personalizada
echo "Armbian ApoSeek v1.0" > ${SDCARD}/etc/os-release
cat > ${SDCARD}/etc/lsb-release << 'LSB_EOF'
DISTRIB_ID=Armbian
DISTRIB_RELEASE=1.0
DISTRIB_CODENAME=aposeek
DISTRIB_DESCRIPTION="Armbian ApoSeek v1.0"
LSB_EOF

# 5. Prompt personalizado en bashrc
echo 'PS1="\[\033[1;32m\]\u@mxqbox\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ "' >> ${SDCARD}/etc/bash.bashrc

echo "✅ Armbian ApoSeek v1.0 personalization complete!"

# 6. Configuración de zona horaria - America/Santo_Domingo
echo "🕐 Configuring timezone: America/Santo_Domingo"
echo "America/Santo_Domingo" > ${SDCARD}/etc/timezone
ln -sf /usr/share/zoneinfo/America/Santo_Domingo ${SDCARD}/etc/localtime

# 7. Configuración de locale
echo "es_DO.UTF-8 UTF-8" >> ${SDCARD}/etc/locale.gen
echo "LANG=es_DO.UTF-8" > ${SDCARD}/etc/default/locale
echo "LC_ALL=es_DO.UTF-8" >> ${SDCARD}/etc/default/locale

# 8. Configurar NTP para sincronización de tiempo
cat > ${SDCARD}/etc/systemd/timesyncd.conf << 'TIMESYNC_EOF'
[Time]
NTP=0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org
FallbackNTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
TIMESYNC_EOF

echo "✅ Timezone America/Santo_Domingo configured!"
