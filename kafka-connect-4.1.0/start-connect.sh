#!/bin/bash
# start-connect.sh - Script de inicio para Kafka Connect con soporte para variables de entorno

set -e

# Configuraciones por defecto
CONNECT_CONFIG_FILE=${CONNECT_CONFIG_FILE:-/opt/kafka/config/connect/connect-distributed.properties}
TEMP_CONFIG_FILE="/tmp/connect-distributed.properties"

# Crear archivo de configuración temporal
cp "$CONNECT_CONFIG_FILE" "$TEMP_CONFIG_FILE"

# Función para actualizar propiedades desde variables de entorno
update_config() {
    local env_var=$1
    local property=$2
    local value=${!env_var}
    
    if [ -n "$value" ]; then
        echo "Configurando $property=$value"
        # Eliminar la propiedad si ya existe
        sed -i "/^$property=/d" "$TEMP_CONFIG_FILE"
        # Agregar la nueva configuración
        echo "$property=$value" >> "$TEMP_CONFIG_FILE"
    fi
}

# Aplicar TODAS las variables de entorno que empiecen con CONNECT_
echo "Aplicando configuraciones dinámicas desde variables de entorno..."
for env_var in $(env | grep -E '^CONNECT_[^=]+='); do
    # Extraer nombre de la variable (ej: CONNECT_PRODUCER_MAX_REQUEST_SIZE)
    var_name=$(echo "$env_var" | cut -d '=' -f 1)
    # Convertir a propiedad de Kafka (ej: producer.max.request.size)
    property=$(echo "$var_name" | sed 's/^CONNECT_//' | tr '_' '.' | tr '[:upper:]' '[:lower:]')
    # Actualizar configuración
    update_config "$var_name" "$property"
done

# Plugin path
if [ -n "$CONNECT_PLUGIN_PATH" ]; then
    echo "Configurando plugin.path=$CONNECT_PLUGIN_PATH"
    sed -i "/^plugin.path=/d" "$TEMP_CONFIG_FILE"
    echo "plugin.path=$CONNECT_PLUGIN_PATH" >> "$TEMP_CONFIG_FILE"
fi

# Configurar JAVA_OPTS si no está definido
if [ -z "$KAFKA_HEAP_OPTS" ]; then
    export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"
fi

# Mostrar información de inicio
echo "Iniciando Kafka Connect..."
echo "Archivo de configuración: $TEMP_CONFIG_FILE"
echo "Plugin path: ${CONNECT_PLUGIN_PATH:-/opt/kafka/plugins}"

# Mostrar configuración final (para debugging)
if [ "$CONNECT_DEBUG" = "true" ]; then
    echo "=== Configuración final ==="
    cat "$TEMP_CONFIG_FILE"
    echo "=========================="
fi

# Iniciar Kafka Connect en modo distribuido
echo "Ejecutando: /opt/kafka/bin/connect-distributed.sh $TEMP_CONFIG_FILE"
exec /opt/kafka/bin/connect-distributed.sh "$TEMP_CONFIG_FILE"