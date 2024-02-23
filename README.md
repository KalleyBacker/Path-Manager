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

1. Muevete al home y clona el repositorio

```bash
cd ${HOME} && git clone https://github.com/KalleyBacker/Path-Manager.git
```

2. Crea el directorio .functions.d

```bash
mkdir ${HOME}/.functions.d
```
3. Copia el script en el directorio .functions.d
```bash
cp -r ${HOME}/Path-Manager/*.sh "${HOME}/.functions.d/"
```
4. Configura la carga automática en tu archivo ~/.bashrc

```bash
echo -e '\n#source_script
####################################################################
for script in $(find ${HOME}/.functions.d -type f -name "*.sh" )   #
do                                                                 #
        source $script                                             #
done                                                               #
####################################################################\n' >> ~/.bashrc
```

5. Carga la configuracion del bashrc
```bash
source ~/.bashrc
```
 <br/>

## Uso

1. Guardar la ruta actual:

```bash
pmng -s
```



<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/cf8c56c4-e49f-40c3-912e-9ef011ac6445" alt="Logo" width="1010" height="200">

<br/>
<br/>
<br/>
<br/>
 
2. Listar todas las rutas guardadas:

```bash
pmng -l
```


<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/ff6207b8-3f22-48bd-b761-86b0738f7c37" alt="Logo" width="1020" height="400">

<br/>
<br/>
<br/>
<br/>

3. Moverse a través de una ruta específica:

```bash
pmng -m {ID DE LA RUTA}
```


<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/72be3b6b-3c15-4809-999c-508f55094c51" alt="Logo" width="1010" height="200">

<br/>
<br/>
<br/>
<br/>

4. Eliminar una ruta de la cache:

```bash
pmng -r {ID DE LA RUTA}
```


<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/a2dee2f6-f053-4de0-91a2-35ec32b4242c" alt="Logo" width="700" height="200">

<br/>
<br/>
<br/>
<br/>

5. Despliega la ayuda:

```bash
pmng -h
```

<img src="https://github.com/KalleyBacker/Path-Manager/assets/84671791/40b38e2f-7016-45a0-bd3f-93a15382c79e" alt="Logo" width="1010" height="500">
<br/>

## Autor
 
* **Juan Carlos Morla Reyes** - [KalleyBacker](https://github.com/KalleyBacker) 

<br/>

## Agradecimientos

* [ShaanCoding](https://readme.shaankhan.dev/)
