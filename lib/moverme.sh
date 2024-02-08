#--------------------------------SOCIAL-NETWORKS-------------------------------﹁
#                                                                               |
#   https://github.com/KalleyBacker                                             |
#   https://www.instagram.com/linux_debugging/                                  |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/              |
#                                                                               |
#---------------------------------DOCUMENTACION---------------------------------⸡
#                                                                               |
#    Este script Bash define una función llamada moverme se                     |
#	 utiliza para cambiar el directorio de trabajo actual (cd) a una ruta       |
#	 especificada por su ID. La función toma un argumento que representa el     |
#	 ID de la ruta que se desea mover. Busca la ruta correspondiente al ID      |
#	 proporcionado, verifica si la ruta existe y es un directorio válido, y     |
#	 luego cambia al directorio especificado.  								    |
#                                                                               |
#--------------------------------FUNCIONAMIENTO---------------------------------⸡
#                                                                               |
#   		 moverme {El ID de la ruta a la que se desea mover.}     	        |
#																				|
#-------------------------------------------------------------------------------｣

function moverme {

	local moverme_argumento=$1
		
	ruta_moverme="$(filter ${moverme_argumento} @)"
	ruta_moverme="$(echo -n ${ruta_moverme}|sed "s/.*[ ]//")"

	if [[ -n "${ruta_moverme}" ]];then

		if [[ -d "${ruta_moverme}" ]];then

			if	[[ $(pwd) == "${ruta_moverme}" ]];then
				Acierto_Error "Acierto" "Ya estamos en la ubicacion [ ${ruta_moverme} ]"
			else
				cd "${ruta_moverme}" && Acierto_Error "Acierto" "Comando Exictoso\nNueva ruta:[ ${ruta_moverme} ]"
			fi
		else
			Acierto_Error "Error" "La ruta [ ${ruta_moverme} ] ya no existe...!"
			Acierto_Error "Error" "Favor eliminar la ruta con el ID [ ${moverme_argumento} ]"
		fi
	else
		Acierto_Error "Error" "El ID: [ ${moverme_argumento} ] no tiene una ruta asignada..."
	fi
}
