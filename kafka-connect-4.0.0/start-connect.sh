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

# Mapear variables de entorno a propiedades de Kafka Connect
echo "Aplicando configuraciones desde variables de entorno..."

# Configuraciones básicas
update_config "CONNECT_BOOTSTRAP_SERVERS" "bootstrap.servers"
update_config "CONNECT_GROUP_ID" "group.id"
update_config "CONNECT_REST_HOST_NAME" "rest.host.name"
update_config "CONNECT_REST_PORT" "rest.port"
update_config "CONNECT_REST_ADVERTISED_HOST_NAME" "rest.advertised.host.name"
update_config "CONNECT_REST_ADVERTISED_PORT" "rest.advertised.port"

# Topics de almacenamiento interno
update_config "CONNECT_CONFIG_STORAGE_TOPIC" "config.storage.topic"
update_config "CONNECT_OFFSET_STORAGE_TOPIC" "offset.storage.topic"
update_config "CONNECT_STATUS_STORAGE_TOPIC" "status.storage.topic"

# Factores de replicación
update_config "CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR" "config.storage.replication.factor"
update_config "CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR" "offset.storage.replication.factor"
update_config "CONNECT_STATUS_STORAGE_REPLICATION_FACTOR" "status.storage.replication.factor"

# Convertidores
update_config "CONNECT_KEY_CONVERTER" "key.converter"
update_config "CONNECT_VALUE_CONVERTER" "value.converter"
update_config "CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE" "key.converter.schemas.enable"
update_config "CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE" "value.converter.schemas.enable"

# Convertidores internos
update_config "CONNECT_INTERNAL_KEY_CONVERTER" "internal.key.converter"
update_config "CONNECT_INTERNAL_VALUE_CONVERTER" "internal.value.converter"
update_config "CONNECT_INTERNAL_KEY_CONVERTER_SCHEMAS_ENABLE" "internal.key.converter.schemas.enable"
update_config "CONNECT_INTERNAL_VALUE_CONVERTER_SCHEMAS_ENABLE" "internal.value.converter.schemas.enable"

# Timeouts y configuraciones de red
update_config "CONNECT_HEARTBEAT_INTERVAL_MS" "heartbeat.interval.ms"
update_config "CONNECT_SESSION_TIMEOUT_MS" "session.timeout.ms"
update_config "CONNECT_REBALANCE_TIMEOUT_MS" "rebalance.timeout.ms"

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