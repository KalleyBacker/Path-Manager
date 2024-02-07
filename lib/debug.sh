
#----------------------------SOCIAL NETWORKS---------------------------﹁
#                                                                       |
#   https://github.com/KalleyBacker                                     |
#   https://www.instagram.com/linux_debugging/                          |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/      |
#                                                                       |
#-----------------------------DOCUMENTACION-----------------------------⸡
#                                                                       |
#   Esta función de Bash, llamada debug, se utiliza para activar 		|
#   o desactivar el modo de depuración en un script. 					|
#   Cuando se llama a la función con el argumento "on",					|
#   activa el modo de depuración, lo que significa que se mostrarán 	|
#   todos los comandos ejecutados en el script. Por otro lado,			|
#   cuando se llama con el argumento "off", desactiva el modo de 		|
#   depuración, lo que detiene la visualización de los comandos  		|
#   ejecutados. La función utiliza set -x para activar la depuración	|
#   y set +x para desactivarla. Además, la variable interruptor se 		|
#   utiliza para determinar si se debe activar o desactivar 			|
#   la depuración.                    									|
#                                                                       |
#-----------------------------FUNCIONAMIENTO-----------------------------
#                                                                       |
#			debug on; {codigo} debug off -- Activa depuracion			|
#			debug off; {codigo} debug off -- Desactiva depuracion		|
#                                                                       |
#-----------------------------------------------------------------------｣

function debug {
		
	set +x #---Desactiva la bandera en caso de estar activada previamente

	local interruptor=$1

	if [[ ${interruptor} = off ]];then #----Modo desactivado
		set +x
	elif [[ ${interruptor} = on ]];then #----Modo activado
		set -x
	fi
}
