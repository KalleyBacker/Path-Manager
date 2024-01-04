#!/bin/bash
#
#
#Author: Author https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3
#   
#   [ Juan Carlos Morla Reyes ]
#
#Linkedin 
#   
#   [ https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3 ]
#
#VERSION 
#      
#		1.3 
#
#
#NAME 
#       path_save.sh  
#
#SYNOPSIS
#		   
#		pmng {argumento} {parametro}
#
#
#DESCRIPTION
#
#			Administrador de rutas concurrentes
#			p=path mng=manager
#		 	  
#								
#BUGS 
#
#Cuando se intente buscar una ruta con un ID que no exista tiene que dar error
#
#Listar una ruta esta solo debe recibir parámetros numéricos
#		
#Agregar más funciones para reemplazar el código repetido y mal escrito 
#
#Guardar rutas sin tener que estar ubicado en el path(agregar lectura de parámetros para la función save)
#
##################################################################################################


function pmng {

##DEBUG
#set -x
	 
	local ruta="${HOME}/.Path_save_cache.cache"
	local temporal="${HOME}/.Path_save_cache.cache1"
	function help {
		echo -e "\nUsage: Path_save [OPTIONS]... [NUMBER]...\n"
		echo -e "Guarda las rutas mas (concurridas).\n"
		echo -e "Options:\n"
		echo -e "	-l,	Lista todas las rutas guardadas. argumentos: [Numero,all].\n" 
		echo -e "	-s,	Guarda la ruta donde actualmente estas situado.\n"
		echo -e "	-m,	Moverse atravez de las ruta seleccionada, argumento: [Numero]\n"
		echo -e "	-r,	Remueve la ruta que se ponga en el argumento: [Numero].\n" 
		echo -e "	-h,	Despliega la ayuda.!\n"
	}

	function env_cache { 
	
		if ! [[ -f ${ruta} ]];then  
			echo -e "\nMe estas usando por primera vez😉!\n\nVoy a crear un fichero oculto en [ ${ruta} ]\nEsto con finalidad de manejar la cache.!\nYa puedes empezar a guardar tus rutas!\n"
			touch ${ruta} && chmod 640 ${ruta}
		fi
	}


	 function lista {

	 	local lista_argumento=$1
 			
		if ! [[ -s ${ruta} ]];then		
			echo -e "El Usuario:[ ${USER} ]\n❌No tiene rutas guardadas"			
		else 
			if [[ ${lista_argumento} == all ]];then
				echo -e "✅ Rutas:\n"
				cat -n ${ruta}					
			else 	
				echo -e "✅ Ruta Numero [ ${lista_argumento} ]\n"
				nl -n'ln' ${ruta}| grep --color=never -w  ^"[${lista_argumento}]"
			fi 	
		fi
	}

	function save {

		(egrep -qw "^$(pwd)$" "${ruta}")
		if [[ $? -eq 0 ]];then
 			echo "✅ Esta ruta esta guardada!"
		else 

			rutas_disponibles=$(echo -n $(cat -n ${ruta} | grep "[0-99].[[:space:]]$"))

			if [[ -n ${rutas_disponibles} ]];then
				read -p 'Quiere enlazar esta ruta con un ID existente❓[Ss o Nn]: ' SoN
				
				if [[ ${SoN} = [Ss] ]];then 

						read -p "Cual ID de los disponibles quiere utilzar❓ [ ${rutas_disponibles} ]: " Numero_de_ruta_disponible
					
					if $(echo $rutas_disponibles| grep -q ${Numero_de_ruta_disponible});then
						
						awk -v rutapwd="$(pwd)" -v numero=${Numero_de_ruta_disponible} 'NR==numero { $0 = rutapwd } 1' ${ruta} > ${temporal}
						mv ${temporal} ${ruta}
						echo -e "✅ Comando Exitoso\nNueva ruta guardada:[ $(pwd) ]" 
					else
						echo "❌Error ese ID esta ocupado"
						break	
					fi
				else 
					pwd >> ${ruta}
					echo -e "✅ Comando Exitoso\nNueva ruta guardada:[ $(pwd) ]"

				fi
			else
				pwd >> ${ruta}
				echo -e "✅ Comando Exitoso\nNueva ruta guardada:[ $(pwd) ]"	
			fi
		fi

	}	

	function moverme {
		local moverme_argumento=$1
		if [[ -n ${moverme_argumento} ]];then
		
			ruta_moverme="$(nl -n'ln' ${ruta}|\
				grep --color=never -w  ^"[${moverme_argumento}]"|\
				 	sed "s/^[[:alnum:]].*[[:space:]]//g")"	
			
			if [[ -d ${ruta_moverme} ]];then
				cd ${ruta_moverme} && echo -e "✅ Comando Exictoso\nNueva ruta:[ $(pwd) ]"
					
			else 
				echo -e "❌No exite una ruta con el ID: [${moverme_argumento}]...!"
			fi  
		
		else 
		 	echo -e "❌Hacia donde quieres moverte❓..."				
		
		fi 	 		
	}

	function remover {

		local remover_argumento=$1
		numero_lineas_existe="$(cat -n ${ruta}|grep -wo ${remover_argumento})"

		if [[ -n ${numero_lineas_existe} ]];then

			sed -i "${remover_argumento}s/.*/ /" ${ruta} && echo -e "✅ Comando Exictoso\n Ruta: [ $remover_argumento ] Borrada...\n"
		
			numero_lineas=$(cat -n ${ruta} | grep  -A1 "[0-99].[[:space:]]$"|wc -l)
			if [[ $numero_lineas -eq 1 ]];then
				numero_de_linea_eliminar=$(cat -n /home/jcarlos/.Path_save_cache.cache  | grep "[0-99].[[:space:]]$")
				sed -i "${numero_de_linea_eliminar}d" ${ruta}		
			fi 
			lista all

		else 
			echo -e "❌No exite una ruta con el ID: [ ${remover_argumento} ]...!"
		fi

	}


	OPTIND=1
	while getopts "l:r:m:hs" options
	do
		case ${options} in
			l)
			lista ${OPTARG}
			env_cache
			;;
			s)
			save
			env_cache
			;;		
			r)
			remover ${OPTARG}
			env_cache
			;;
			m)
			moverme ${OPTARG}
			env_cache
			;;
			h)
			help
			env_cache
			;;
			?)
			env_cache
            echo "Opción no válida: ${OPTARG}"
            help
            ;;
		esac

	done 

##DEBUG
#set +x
}