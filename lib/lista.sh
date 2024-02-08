#--------------------------------SOCIAL-NETWORKS-------------------------------﹁
#                                                                               |
#   https://github.com/KalleyBacker                                             |
#   https://www.instagram.com/linux_debugging/                                  |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/              |
#                                                                               |
#---------------------------------DOCUMENTACION---------------------------------⸡
#                                                                               |
#    Este script Bash define una función llamada lista que se utiliza para      |
#	 gestionar y mostrar rutas almacenadas en un archivo de caché. La función   |
#	 puede ser invocada desde la línea de comandos o desde otros scripts para   |
#	 listar las rutas almacenadas o para buscar rutas específicas por su ID.    |
#                                                                               |
#--------------------------------FUNCIONAMIENTO---------------------------------⸡
#                                                                               |
#    lista  - lista todas las rutas guardadas   							    |
#    lista {ID/s} - lista las ruta de lo/s ID/s especificado/s                  |
#																				|
#-------------------------------------------------------------------------------｣



function lista {

	################# --- Revisa si el fichero cache existe	
	if ! [[ -s ${ruta} ]];then
		Acierto_Error "Error" "El Usuario [${USER}] No tiene rutas guardadas"
	################# --- Verifica si no se proporcionaron argumentos  				
	elif [[ -z ${array_argumentos[@]} ]];then
		echo -e "✅ Rutas:\n"
		cat -n ${ruta}					
	else
			 
		for conteo in ${!array_argumentos[@]} 
		do
			ruta_listada_del_argumento=$(filter ${array_argumentos[${conteo}]} @)

			################# --- Verifica si no se encontró una ruta correspondiente al ID
			if [[ -z ${ruta_listada_del_argumento} ]];then
				Acierto_Error "Error" "No exite una ruta con el ID: [ $(echo -n ${array_argumentos[${conteo}]}) ]...!"
			else
				[[ -z ${ya_ejecutado} ]] && Acierto_Error "Acierto" "Ruta/s ID/s [ $(echo -n ${array_argumentos[@]}) ]" &&echo &&ya_ejecutado=true
				
				################# ---  Imprime la ruta encontrada
				echo ${ruta_listada_del_argumento} 
			fi
		done
		################# --- Restablece la variable ya_ejecutado
		unset ya_ejecutado 
	fi
}
