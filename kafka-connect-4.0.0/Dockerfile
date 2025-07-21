# Dockerfile para Kafka Connect - Versión simplificada
FROM apache/kafka:4.0.0

# Trabajar como root (más simple, evita problemas de usuarios)
USER root

# Verificar qué package manager está disponible e instalar curl (opcional)
RUN if command -v apt-get >/dev/null 2>&1; then \
        apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*; \
    elif command -v yum >/dev/null 2>&1; then \
        yum install -y curl; \
    elif command -v apk >/dev/null 2>&1; then \
        apk add --no-cache curl; \
    elif command -v microdnf >/dev/null 2>&1; then \
        microdnf install curl; \
    else \
        echo "Continuando sin curl"; \
    fi

# Crear directorio para configuraciones de Connect
RUN mkdir -p /opt/kafka/config/connect

# Copiar archivos
COPY start-connect.sh /opt/kafka/bin/start-connect.sh
COPY connect-distributed.properties /opt/kafka/config/connect/connect-distributed.properties

# Dar permisos de ejecución
RUN chmod +x /opt/kafka/bin/start-connect.sh

# Crear directorio para plugins
RUN mkdir -p /opt/kafka/plugins

# Exponer puerto
EXPOSE 8083

# Establecer directorio de trabajo
WORKDIR /opt/kafka

# Comando por defecto
CMD ["/opt/kafka/bin/start-connect.sh"]