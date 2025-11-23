#!/bin/bash
# Crea enlaces simbólicos para TODOS los parches referenciados en series.conf

echo "Creando enlaces para parches faltantes..."

SERIES_FILE="/workspace/aposeekos/builds/armbian-build/patch/kernel/archive/sunxi-6.12/series.conf"
REPO_BASE="/workspace/aposeekos/repos/buildscripts/patch/kernel/archive/sunxi-6.12"
TARGET_BASE="/workspace/aposeekos/builds/armbian-build/patch/kernel/archive/sunxi-6.12"

# Leer series.conf y crear enlaces para cada parche
while IFS= read -r patch_line; do
    # Limpiar línea y extraer ruta del parche
    patch_path=$(echo "$patch_line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Saltar líneas vacías o comentarios
    [[ -z "$patch_path" || "$patch_path" =~ ^# ]] && continue
    
    # Extraer directorio y archivo
    patch_dir=$(dirname "$patch_path")
    patch_file=$(basename "$patch_path")
    
    # Crear directorio destino si no existe
    sudo mkdir -p "$TARGET_BASE/$patch_dir"
    
    # Crear enlace si el archivo origen existe
    if [[ -f "$REPO_BASE/$patch_path" ]]; then
        sudo ln -sf "$REPO_BASE/$patch_path" "$TARGET_BASE/$patch_path"
        echo "Enlace creado: $patch_path"
    else
        echo "ADVERTENCIA: Parche no encontrado: $REPO_BASE/$patch_path"
    fi
done < "$SERIES_FILE"

echo "Proceso completado"
