#--------------------------------SOCIAL-NETWORKS-------------------------------﹁
#                                                                               |
#   https://github.com/KalleyBacker                                             |
#   https://www.instagram.com/linux_debugging/                                  |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/              |
#                                                                               |
#---------------------------------DOCUMENTACION---------------------------------⸡
#                                                                               |
#	La función save se utiliza para guardar una ruta específica en un    		|
#	archivo de caché, junto con un ID opcionalmente asignado.					|
#	La función puede recibir una ruta como parámetro,    						|
#	y si no se proporciona ninguna, utiliza el directorio actual.    			|
#	La ruta se verifica para asegurarse de que exista y de que el usuario 		|
#	tenga permisos para acceder a ella antes de guardarla en   					|
#	 archivo de caché.  								        		        |
#                                                                               |
#--------------------------------FUNCIONAMIENTO---------------------------------⸡
#                                                                               |
#	save 	 	 	- 	Guarda la ruta actual									|
#	save . 		 	- 	Guarda la ruta actual								    |
#	save ..		 	- 	Guarda la ruta anterior									|
#	save  /path/ 	- 	Guarda la ruta que se pase por parametro	    	    |
#	save ~ 		 	-	guada el home                                           |
#	save - ../../   -   Guardará la ruta dos directorios arriba      		 	|
#																				|
#-------------------------------------------------------------------------------｣


function save {

	local path_por_parametro=${@//[ ]/\\ }

	if [[ -z ${path_por_parametro} ]];then
		path_por_parametro="$(pwd)"
	fi
	
	if [[ -d ${path_por_parametro} ]];then

		path_por_parametro=$(readlink -f "${path_por_parametro}")

		if [[ -x ${path_por_parametro} ]];then

			(grep -qwE "^${path_por_parametro}$" "${ruta}")
			if [[ $? -eq 0 ]];then
 				Acierto_Error "Error" "Esta ruta [ ${path_por_parametro} ] esta guardada!"
 				return 1
			else
				rutas_disponibles=$(echo -n $(filter 0 0 all | grep "[0-99].[[:space:]]$"))
	
				if [[ -n ${rutas_disponibles} ]];then
					read -p 'Quiere enlazar esta ruta con un ID existente❓[Ss o Nn]: ' SoN
				
					if [[ ${SoN} = [Ss] ]];then

						read -p "Cual ID de los disponibles quiere utilzar❓ [ ${rutas_disponibles} ]: " Numero_de_ruta_disponible
					
						if $(echo $rutas_disponibles| grep -q ${Numero_de_ruta_disponible});then
						
							awk -v rutapwd="${path_por_parametro}" -v numero=${Numero_de_ruta_disponible} 'NR==numero { $0 = rutapwd } 1' ${ruta} > ${temporal}
							mv ${temporal} ${ruta}
							Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ ${path_por_parametro} ]" 
						else
							Acierto_Error "Error" "El ID [${Numero_de_ruta_disponible}] esta ocupado"
							return 1
							break	
						fi
					else 
						echo "${path_por_parametro}" >> ${ruta}
						Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ ${path_por_parametro} ] ID asociado: [ $(filter 0 0 all|tail -n1 |awk '{print $1}') ]"
					fi
				else
					echo "${path_por_parametro}" >> ${ruta}	
					Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ ${path_por_parametro} ] ID asociado: [ $(filter 0 0 all|tail -n1 |awk '{print $1}') ]"
				fi
			fi
		else
			Acierto_Error "Error" "No tienes permisos para ingresar al directorio. [ ${path_por_parametro} ]"
		fi
		else
			Acierto_Error "Error" "Ruta no existe [ ${path_por_parametro} ]"	
	fi
	unset path_por_parametro
}
