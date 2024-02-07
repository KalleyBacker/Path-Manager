#----------------------------SOCIAL NETWORKS-----------------------------
#                                                                       |
#   https://github.com/KalleyBacker                                     |
#   https://www.instagram.com/linux_debugging/                          |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/      |
#                                                                       |
#-----------------------------DOCUMENTACION------------------------------
#                                                                       |
# 		        Crear el archivo que almacena las rutas	            	|
#                                                                       |
#------------------------------------------------------------------------


function env_cache { 
	
	if ! [[ -f ${ruta} ]];then
		echo -e "\nMe estas usando por primera vez😉!\n\nVoy a crear un fichero oculto en [ ${ruta} ]"
		echo -e "Esto con finalidad de manejar la cache.\nYa puedes empezar a guardar tus rutas."
		touch ${ruta} && chmod 640 ${ruta}
	fi
}
