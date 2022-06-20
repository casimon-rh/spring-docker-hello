# Spring - Docker - Hello

Aplicación demo Spring 🍃, cuenta con Dockerfiles y otros scripts para ejemplificar el proceso de despliegue via contenedor (Docker 🐳) y Openshift 🔴

## >>> Scripts de gestión

### Docker 🐳

El directorio **docker-scripts** cuenta con un subdirectorio donde se almacenan archivos dockerfile y scripts para generar imágenes que contengan el código. Las 2 opciones son:

* Base Java-Openjdk
* Base JBoss EAP

### Openshift 🔴

El directorio de **openshift** cuenta con subdirectorios en los que se almacenan otros archivos dockerfile y scripts para generar el proceso de despliegue a openshit. Las 3 opciones son:

* Via Docker, Imagen Java-Openjdk
* Via Docker, Imagen JBoss EAP
* Via Source2Image, Imagen JBoss EAP