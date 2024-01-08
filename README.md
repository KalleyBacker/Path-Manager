<br/>
<p align="center">
  <a href="https://github.com/KalleyBacker/Path-Manager">
    <img src="https://github.com/KalleyBacker/Path-Manager/blob/main/imagen/1.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Path Manager</h3>

  <p align="center">
    Path_save.sh es un script en bash diseñado para administrar y gestionar rutas de manera eficiente. Puedes utilizarlo para guardar, listar, moverte a través del sistema.
    <br/>
    <br/>
    <a href="https://github.com/KalleyBacker/Path-Manager"><strong>Explora los documentos »</strong></a>
    <br/>
    <br/>
    <a href="https://github.com/KalleyBacker/Path-Manager/issues">Reportar un error</a>
    .
  </p>
</p>
 
## Tabla de contenido

* [Sobre el proyecto](#Sobre-el-proyecto)
* [Instalacion](#Instalacion)
* [Uso](#Uso)
* [Autor](#Autor)
* [Agradecimientos](#Agradecimientos)

## Sobre el proyecto


Este proyecto fue creado con el propósito de facilitar la movilidad en rutas muy largas. A menudo, cuando trabajamos con estructuras de directorios complejas o realizamos tareas que involucran la navegación frecuente entre diferentes ubicaciones, puede resultar tedioso recordar y escribir manualmente las rutas completas. Path_save.sh busca simplificar este proceso al permitirte guardar, explorar y eliminar fácilmente las rutas que utilizas con frecuencia.



## Instalacion

1. Clona el repositorio

```bash
git clone https://github.com/KalleyBacker/Path-Manager.git
```

2. Crea el directorio .functions.d

```bash
mkdir -p ~/.functions.d"
```

3. Copia el script en el directorio .functions.d

```bash
cp ~/Path-Manager/path_save.sh "$HOME/.functions.d/"
```

4. Configura la carga automática en tu archivo ~/.bashrc

```bash
# Cargar scripts en .functions.d
for script in "${HOME}/.functions.d/*"
do
    source "$script"
done
```


## Uso

1. Guardar la ruta actual:

```bash
pmng -s
```

2. Listar todas las rutas guardadas:

```bash
pmng -l
```

3. Moverse a través de una ruta específica:

```bash
pmng -m 1
```

4. Eliminar una ruta de la cache:

```bash
pmng -r 2
```
5. Despliega la ayuda:

```bash
pmng -h
```

## Autor

* **Juan Carlos Morla Reyes** - [KalleyBacker](https://github.com/KalleyBacker) 


## Agradecimientos

* [ShaanCoding](https://readme.shaankhan.dev/)
