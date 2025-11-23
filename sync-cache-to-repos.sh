#!/bin/bash
# Mueve cache de Armbian a repositorios permanentes (evita duplicados)

echo "🔄 Moviendo cache a repositorios permanentes..."

# Kernel worktree
if [ -d "/workspace/aposeekos/builds/armbian-build/cache/sources/linux-kernel-worktree" ]; then
    echo "📦 Moviendo kernels..."
    find "/workspace/aposeekos/builds/armbian-build/cache/sources/linux-kernel-worktree" -mindepth 1 -maxdepth 1 -type d | while read -r kernel_dir; do
        kernel_version=$(basename "$kernel_dir" | cut -d'_' -f1)
        sudo mkdir -p "/workspace/aposeekos/repos/linux/kernel-$kernel_version/"
        sudo mv "$kernel_dir"/* "/workspace/aposeekos/repos/linux/kernel-$kernel_version/" 2>/dev/null
    done
fi

# u-boot
if [ -d "/workspace/aposeekos/builds/armbian-build/cache/sources/u-boot" ]; then
    echo "🚀 Moviendo u-boot..."
    sudo mkdir -p "/workspace/aposeekos/repos/u-boot/"
    sudo mv "/workspace/aposeekos/builds/armbian-build/cache/sources/u-boot"/* "/workspace/aposeekos/repos/u-boot/" 2>/dev/null
fi

# Herramientas
if [ -d "/workspace/aposeekos/builds/armbian-build/cache/tools" ]; then
    echo "🛠️ Moviendo herramientas..."
    sudo mkdir -p "/workspace/aposeekos/repos/tools/"
    sudo mv "/workspace/aposeekos/builds/armbian-build/cache/tools"/* "/workspace/aposeekos/repos/tools/" 2>/dev/null
fi

echo "✅ Movimiento completado - Sin duplicados"
