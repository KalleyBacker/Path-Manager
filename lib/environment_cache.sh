function env_cache { 
	
	if ! [[ -f ${ruta} ]];then
		echo -e "\nMe estas usando por primera vez😉!\n\nVoy a crear un fichero oculto en [ ${ruta} ]"
		echo -e "Esto con finalidad de manejar la cache.\nYa puedes empezar a guardar tus rutas."
		touch ${ruta} && chmod 640 ${ruta}
	fi
}
