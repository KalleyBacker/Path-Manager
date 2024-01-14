#!/bin/bash

#Author: [ KalleyBacker ]


##BUGS y updates
#
#		Guardar rutas sin tener que estar ubicado en el path(agregar lectura de parámetros para la función save).
#
#		Que muestre el ID de la ruta cuando se guarda.  
#
#		Agregar el id de las rutas al fichero cache para que sean permanentes.
#	
##################################################################################################



function debug {
	set +x
	local interruptor=$1
	
	if [[ ${interruptor} = off ]];then
		set +x
	elif [[ ${interruptor} = on ]];then
		set -x
	fi	
}

function filter { 
    
    local fila=$1
    local columna=$2
    local total=$3
   
    if [[ ${total} == all ]];then
    	cat -n ${ruta}	
    else
    	cat -n ${ruta} | awk -v c=${columna} -v f=${fila} 'NR==f {print $c}'
    fi
}

function Acierto_Error {
  
   	local pregunta=$1
   	local parametro=$2
    
    if [[ ${pregunta} = Error ]];then
    	local signo='❌' && local color=${red}
    elif [[ ${pregunta} = Acierto ]]; then
    	local signo='✅'&& local color=${verd}
    fi 

    echo -e "${white}[${null}${signo}${white}] ${pregunta} - ${null}$(echo -n "$2" |\
        sed -e "s/\[/\\${null}\\${white}&/g" \
            -e "s/]/&\\${null}/g" \
            -e "s/\\033\[0m/&\\${color}/g" \
            -e "s/^\[/\\${white}&/" \
            -e "s/^[^[]/\\${color}&/" \
            -e "s/[^[]$/&\\${null}/")"
}

function pmng {

	debug off
	
   	local verd="\033[32m"
	local red="\033[31m"
	local null="\033[0m"
	local amarillo="\033[33m"
	local white="\033[37m"
	local ruta="${HOME}/.Path_save_cache.cache"
	local temporal="${HOME}/.Path_save_cache.cache1"
	

	function env_cache { 
	
		if ! [[ -f ${ruta} ]];then  
			echo -e "\nMe estas usando por primera vez😉!\n\nVoy a crear un fichero oculto en [ ${ruta} ]\nEsto con finalidad de manejar la cache.\nYa puedes empezar a guardar tus rutas."
			touch ${ruta} && chmod 640 ${ruta}
		fi
	}


	function help {
		
		echo -e "\nUsage: Path_save [OPTIONS]... [ID/Path]...\n"
		echo -e "Guarda las rutas mas concurridas.\n"
		echo -e "Options:\n"
		echo -e "	-l,	Lista todas las rutas guardadas, argumento(opcional): [ID].\n" 
		echo -e "	-s,	Guarda la ruta donde actualmente estas situado, argumento(opcional): [Path].\n"
		echo -e "	-m,	Moverse atravez de las ruta seleccionada, argumento: [ID]\n"
		echo -e "	-r,	Remueve/Elimina la ruta de la cache, argumento: [ID].\n" 
		echo -e "	-h,	Despliega la ayuda.\n"
	
	}

	function lista {

	 	local lista_argumento=$1
		
		if ! [[ -s ${ruta} ]];then		
			Acierto_Error "Error" "El Usuario [${USER}] No tiene rutas guardadas"			
		 	return 1
		elif [[ -z ${lista_argumento} ]];then
			echo -e "✅ Rutas:\n"
			cat -n ${ruta}					
		else 	
			ruta_listada_del_argumento=$(cat -n ${ruta}| grep --color=never -w "^[ ]*[ ]${lista_argumento}")	
			
			if [[ -n ${ruta_listada_del_argumento} ]];then	
				Acierto_Error "Acierto" "Ruta Numero [ ${lista_argumento} ]\n"
				echo ${ruta_listada_del_argumento}
			else 
				Acierto_Error "Error" "No exite una ruta con el ID: [ ${lista_argumento} ]...!"
				return 1
			fi
 	
		fi
	}

	function save {

		(grep -qwE "^$(pwd)$" "${ruta}")
		if [[ $? -eq 0 ]];then
 			Acierto_Error "Error" "Esta ruta esta guardada!"
 			return 1
		else 

			rutas_disponibles=$(echo -n $(cat -n ${ruta} | grep "[0-99].[[:space:]]$"))

			if [[ -n ${rutas_disponibles} ]];then
				read -p 'Quiere enlazar esta ruta con un ID existente❓[Ss o Nn]: ' SoN
				
				if [[ ${SoN} = [Ss] ]];then 

						read -p "Cual ID de los disponibles quiere utilzar❓ [ ${rutas_disponibles} ]: " Numero_de_ruta_disponible
					
					if $(echo $rutas_disponibles| grep -q ${Numero_de_ruta_disponible});then
						
						awk -v rutapwd="$(pwd)" -v numero=${Numero_de_ruta_disponible} 'NR==numero { $0 = rutapwd } 1' ${ruta} > ${temporal}
						mv ${temporal} ${ruta}
						Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ $(pwd) ]" 
					else
						Acierto_Error "Error" "El ID [${Numero_de_ruta_disponible}] esta ocupado"
						return 1
						break	
					fi
				else 
					pwd >> ${ruta}
					Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ $(pwd) ] ID asociado: [ $(filter 0 0 all|tail -n1 |awk '{print $1}') ]"
				fi
			else
				pwd >> ${ruta}	
				Acierto_Error "Acierto" "Comando Exitoso\nNueva ruta guardada:[ $(pwd) ] ID asociado: [ $(filter 0 0 all|tail -n1 |awk '{print $1}') ]"
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
				
				if	[[ $(pwd) == ${ruta_moverme} ]];then
					Acierto_Error "Acierto" "Ya estamos en la ubicacion [ ${ruta_moverme} ]"
				else
					cd ${ruta_moverme} && Acierto_Error "Acierto" "Comando Exictoso\nNueva ruta:[ $(pwd) ]"
	
				fi			
			else 
				Acierto_Error "Error" "No exite una ruta con el ID: [ ${moverme_argumento} ]...!"
				return 1
			fi  
		
		else 
		 	Acierto_Error "Error" 'Hacia donde quieres moverte❓...'
		 	return 1				
		
		fi 	 		
	}

	function remover {

		local remover_argumento=$1
		numero_lineas_existe="$(filter ${remover_argumento} 1)"

		if [[ -n ${numero_lineas_existe} ]];then
			
			ruta_existe="$(filter ${remover_argumento} 2)"
			if [[ -n ${ruta_existe}	]];then	
				
				sed -i "${remover_argumento}s/.*/ /" ${ruta} && Acierto_Error "Acierto" "Comando Exictoso\nRuta: [ ${remover_argumento} ] Borrada..."

				#limpieza de id no utilizados
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
			else 	
				Acierto_Error "Error" "No existe ninguna ruta asociada al ID: [ ${remover_argumento} ]...!"
				return 1
			fi 	 
		else 
			Acierto_Error "Error" "No exite una ruta con el ID: [ ${remover_argumento} ]...!"
			return 1
		fi

	}


	OPTIND=1
	while getopts ":r:m:hsl" options
	do
		case ${options} in
			l)
			OPTARG=$2
			lista ${OPTARG}	
			env_cache
			;;
			s)
			OPTARG=$2 
			if [[ -n $OPTARG ]];then 

				Acierto_Error "Error" "Esta opcion no recibe parametros"			
				return 1
			else	
				save
				env_cache
			fi	
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
			*)	 	
            Acierto_Error "Error" "Opción no válida: [ ${OPTARG} ]"
            help
            env_cache
            return 1
            ;;
		esac

	done 

	if [[ $1 == [-] ]];then	

		Acierto_Error "Error" "Parametro no valido [ $1 ]"
		help	
	elif [[ -z $1 ]];then	
		Acierto_Error "Error" "Agrege un parametro"
		help	
	elif ! [[ $1 =~ ^[-] ]];then
		Acierto_Error "Error" "Parametro no valido [ $1 ]"
		help	
	fi	
	debug off
}