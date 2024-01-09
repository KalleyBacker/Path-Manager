<br/>
<p align="center">
  <a href="https://github.com/KalleyBacker/Path-Manager">
    <img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/6e53829a-da25-483e-bbbf-3a67212d0ca2" alt="Logo" width="600" height="225">
  </a>
  <h2 align="center">Path Manager</h2>

  <p align="center">
    Path_save.sh es un script en bash diseñado para administrar y gestionar rutas de manera eficiente. Puedes utilizarlo para guardar, listar, moverte a través del sistema.
    <br/>
    <br/>
    <a href="https://github.com/KalleyBacker/Path-Manager"><strong>Explora los documentos »</strong></a>
    <br/>
    <a href="https://github.com/KalleyBacker/Path-Manager/issues">Reportar un error »</a>
    
  </p>
</p>
<br/>

## Tabla de contenido

* [Sobre el proyecto](#Sobre-el-proyecto)
* [Instalacion en bash](#Instalacion-en-bash)
* [Uso](#Uso)
* [Autor](#Autor)
* [Agradecimientos](#Agradecimientos)

<br/>
 
## Sobre el proyecto


Este proyecto fue creado con el propósito de facilitar la movilidad en rutas muy largas. A menudo, cuando trabajamos con estructuras de directorios complejas o realizamos tareas que involucran la navegación frecuente entre diferentes ubicaciones, puede resultar tedioso recordar y escribir manualmente las rutas completas. Path_save.sh busca simplificar este proceso al permitirte guardar, explorar y eliminar fácilmente las rutas que utilizas con frecuencia.

 <br/>

## Instalacion en bash

1. Clona el repositorio

```java
git clone https://github.com/KalleyBacker/Path-Manager.git
```


2. Crea el directorio .functions.d

```java
mkdir ~/.functions.d"
```

3. Copia el script en el directorio .functions.d

```java
cp ~/Path-Manager/path_save.sh $HOME/.functions.d/
```

4. Configura la carga automática en tu archivo ~/.bashrc

```java
# Cargar scripts en .functions.d
for script in "${HOME}/.functions.d/*"
do
    source "$script"
done
```
5. Carga la configuracion del bashrc

```java
source ~/.bashrc
```
 <br/>

## Uso

1. Guardar la ruta actual:

```java
pmng -s
```
<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/dfbd7dd1-2a6b-4af2-a060-94cbd4b8654b" alt="Logo" width="1010" height="200">

<br/>
<br/>
<br/>
<br/>
 
2. Listar todas las rutas guardadas:

```bash
pmng -l
```
<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/ef4f2721-edac-49fe-967e-32f737a2d747" alt="Logo" width="1020" height="400">

<br/>
<br/>
<br/>
<br/>


3. Moverse a través de una ruta específica:

```bash
pmng -m 1
```
<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/f8400601-dfa1-4e9c-a92f-5c7b7bfee8ec" alt="Logo" width="1010" height="200">

<br/>
<br/>
<br/>
<br/>

4. Eliminar una ruta de la cache:

```bash
pmng -r 2
```
<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/54332974-a5c8-49b8-b1b9-8c711e0d5fb5" alt="Logo" width="700" height="200">

<br/>
<br/>
<br/>
<br/>


5. Despliega la ayuda:

```bash
pmng -h
```
<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/35352eae-2a3d-4d0e-8765-12f4659292d0" alt="Logo" width="1010" height="500">



<br/>

## Autor
 

* **Juan Carlos Morla Reyes** - [KalleyBacker](https://github.com/KalleyBacker) 

<br/>

## Agradecimientos

* [ShaanCoding](https://readme.shaankhan.dev/)
