FROM python:3.13-slim

WORKDIR /app

# Copiar el requirements.txt primero
COPY requirements.txt .

# Instalar dependencias del sistema necesarias para sentencepiece
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Instalar dependencias de Python
RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# mover el directorio de la app
WORKDIR /app
# Ejecutar flask app
CMD ["flask", "run", "--host=0.0.0.0", "--reload"]
