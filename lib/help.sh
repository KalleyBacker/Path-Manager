#----------------------------SOCIAL NETWORKS-----------------------------
#                                                                       |
#   https://github.com/KalleyBacker                                     |
#   https://www.instagram.com/linux_debugging/                          |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/      |
#                                                                       |
#-----------------------------DOCUMENTACION------------------------------
#                                                                       |
# 						 Muestra la ayuda[help]                         |
#                                                                       |
#------------------------------------------------------------------------


function help {
		
	echo -e "\nUsage: Path_save [OPTIONS]... [IDs/Path]...\n"
	echo -e "Guarda las rutas mas concurridas.\n"
	echo -e "Options:\n"
	echo -e "	-l,	Lista todas las rutas guardadas, argumento(opcional): [ID/s].\n" 
	echo -e "	-s,	Guarda la ruta donde actualmente estas situado, argumento(opcional): [Path].\n"
	echo -e "	-m,	Moverse atravez de las ruta seleccionada, argumento: [ID]\n"
	echo -e "	-r,	Remueve/Elimina la ruta de la cache, argumento: [ID/s].\n" 
	echo -e "	-h,	Despliega la ayuda.\n"
	
}
