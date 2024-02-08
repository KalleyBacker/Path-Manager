#--------------------------------SOCIAL-NETWORKS-------------------------------﹁
#                                                                               |
#   https://github.com/KalleyBacker                                             |
#   https://www.instagram.com/linux_debugging/                                  |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/              |
#                                                                               |
#---------------------------------DOCUMENTACION---------------------------------⸡
#                                                                               |
#	La función remover se utiliza para eliminar rutas almacenadas en un archivo |
#	de caché basadas en sus IDs. La función toma los IDs de las rutas que se    |
# 	desean eliminar como argumentos y busca y elimina las correspondientes      |
#	entradas en el archivo de caché.  								            |
#                                                                               |
#--------------------------------FUNCIONAMIENTO---------------------------------⸡
#                                                                               |
#                     remover {ID/s que desea eliminar}     			   		|
#																				|
#-------------------------------------------------------------------------------｣

function remover {
	
	if [[ -n ${array_argumentos[@]} ]];then

		for conteo in ${!array_argumentos[@]} 
		do 	
			numero_linea_existe="$(filter ${array_argumentos[${conteo}]} 1)"
			if [[ -n ${numero_linea_existe} ]];then

				ruta_existe="$(filter ${array_argumentos[${conteo}]} 2)"
	
				if [[ -n ${ruta_existe}	]];then	
					Acierto_Error "Acierto" "Ruta: [ ${ruta_existe} ] Borrada..."
					sed -i "${array_argumentos[${conteo}]}s/.*/ /" ${ruta}
				else
					Acierto_Error "Error" "El ID: [ ${numero_linea_existe} ] no tiene una ruta asociada!"		
				fi
			else 
				Acierto_Error "Error" "El ID: [ $(echo -n ${array_argumentos[${conteo}]}) ] no existe!"
			fi							 		
		done
	fi

	# Limpieza de los ulimos id no utilizados #
	total_numero_lineas=$(cat -n ${ruta}|wc -l)
	total1=${total_numero_lineas}
				
	for (( i = 1; i <= ${total_numero_lineas}; i++ )); do
		no_existe=$(filter ${total1} 2)
		if 	[[ -z $no_existe ]];then	
    		sed -i "${total1}d" ${ruta}
   	    else
      		break
    	fi				
    	   ((total1--)) 
	done			
}
