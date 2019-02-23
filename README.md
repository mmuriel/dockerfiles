# Dockerfiles

## Objetivo del repositorio

Este repositorio tiene por objetivo, mantener los diferentes archivos Dockerfile (base para crear imágenes bajo la tecnología Docker, docker.com) que requiera generar para mis proyectos (personales y profesionales) de acuerdo a las tecnologías que se vayan requieriendo, de tal manera que el despliegue hacia máquinas de desarrollo o producción tengan la menor "fricción" posible.

## Ordenamiento

Se generará una carpeta por cada Dockerfile que se requiera crear, manteniendo en el nombre (de cada carpeta) la siguiente estrcutura:

ImagenBase-TecnologíaUtilizada1-TecnologíaUtilizada2-...TecnologíaUtilizadaN

De tal manera que se pueda identificar con una simple inspección visual los componentes de la imagen (o al menos los más importante)

Por ejemplo:

El primer Dockerfile que se creo para este repositorio es un servidor de aplicaciones basado en el servidor web Apache 2.4 integrado con el lenguaje de programación php 7.3, usando como imagen base el sistema operativo Centos 6.10, de esta manera la carpeta del Dockerfile se nombra así:

centos-6.10-php73

