# Python 3.13 (slim)

Imagen basada en la imagen oficial python 3.13-slim (https://github.com/docker-library/python/blob/3fae0a14ac171f46e47d7ce41567e40524af5bcc/3.13/slim-bookworm/Dockerfile).

## Descripción

El objetivo de esta imagen es la de mantener una versión estandarizada para los proyectos basados en python 3.13 en la cual se basa la imagen oficial de python 3.13-slim, para proyectos de naturaleza web, donde se utiliza el framework flask (https://flask.palletsprojects.com/)

## Requisitos

Los paquetes necesarios para construir esta imagen son:

- flask
- transformers
- torch
- ftfy
- python-dotenv
- sentencepiece
- sacremoses
- python-jose
- flask-sqlalchemy
- flask-migrate
- pymysql
- pytest