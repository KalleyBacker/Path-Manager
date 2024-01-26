#!/bin/bash

#Author: [ KalleyBacker ]


##BUGS y updates  
# 	
#	reorganizar id no utilzados 
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
		
		echo -e "\nUsage: Path_save [OPTIONS]... [IDs/Path]...\n"
		echo -e "Guarda las rutas mas concurridas.\n"
		echo -e "Options:\n"
		echo -e "	-l,	Lista todas las rutas guardadas, argumento(opcional): [ID/s].\n" 
		echo -e "	-s,	Guarda la ruta donde actualmente estas situado, argumento(opcional): [Path].\n"
		echo -e "	-m,	Moverse atravez de las ruta seleccionada, argumento: [ID]\n"
		echo -e "	-r,	Remueve/Elimina la ruta de la cache, argumento: [ID/s].\n" 
		echo -e "	-h,	Despliega la ayuda.\n"
	
	}

	function lista {
		
		if ! [[ -s ${ruta} ]];then
			Acierto_Error "Error" "El Usuario [${USER}] No tiene rutas guardadas"			
		elif [[ -z ${array_argumentos[@]} ]];then
			echo -e "✅ Rutas:\n"
			cat -n ${ruta}					
		else
			 
			for conteo in ${!array_argumentos[@]} 
			do
				ruta_listada_del_argumento=$(filter ${array_argumentos[${conteo}]} @)

				if [[ -z ${ruta_listada_del_argumento} ]];then
					Acierto_Error "Error" "No exite una ruta con el ID: [ $(echo -n ${array_argumentos[${conteo}]}) ]...!"
				else
					[[ -z ${ya_ejecutado} ]] && Acierto_Error "Acierto" "Ruta/s ID/s [ $(echo -n ${array_argumentos[@]}) ]" &&echo &&ya_ejecutado=true
					echo ${ruta_listada_del_argumento}
				fi
			done
			unset ya_ejecutado
		fi
	}

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

	function remover {
	
		if [[ -n ${array_argumentos[@]} ]];then

			for conteo in ${!array_argumentos[@]} 
			do 	
				numero_linea_existe="$(filter ${array_argumentos[${conteo}]} 1)"
				if [[ -n ${numero_linea_existe} ]];then

					ruta_existe="$(filter ${array_argumentos[${conteo}]} @)"
					ruta_moverme="$(echo -n ${ruta_existe}|sed "s/.*[ ]//")"
					if [[ -n ${ruta_existe}	]];then	
						Acierto_Error "Acierto" "Ruta: [ ${ruta_moverme} ] Borrada..."
						sed -i "${array_argumentos[${conteo}]}s/.*/ /" ${ruta}
					else
						Acierto_Error "Error" "No existe ninguna ruta asociada al ID: [ ${ruta_moverme} ]...!"		
					fi
				else 
					Acierto_Error "Error" "No exite una ruta con el ID: [ $(echo -n ${array_argumentos[${conteo}]}) ]...!"
				fi							 		
			done
			#Acierto_Error "Acierto" "Total: [ $((${conteo}+1)) ] rutas Borradas..."
		else
			Acierto_Error "Error" "Agrege un parametro"
		fi


	## Limpieza de los ulimos id no utilizados ##
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


	OPTIND=1
	while getopts ":r:m:hsl" options
	do
		case ${options} in
			l)
			shift
			while [[ true ]];do	
				if [[ $1 != "" ]];then							
					argumentos+="$1\n"
					shift
				else 
					break
				fi
			done

			if [[ -n ${argumentos} ]];then
				argumentos=${argumentos%%\\n} # ==   sed "/^[ ]*$/d"
				readarray -t array_argumentos <<< $(echo -e "${argumentos}"| sort -n|uniq)
			fi
			lista
			unset argumentos array_argumentos
			env_cache				
			;;
			s)
			OPTARG=$2 
			save ${OPTARG}
			env_cache
			;;		
			r)
			shift
			while [[ true ]];do	
				if [[ $1 != "" ]];then							
					argumentos+="$1\n"
					shift
				else 
					break
				fi
			done

			if [[ -n ${argumentos} ]];then
				argumentos=${argumentos%%\\n} # ==   sed "/^[ ]*$/d"
				readarray -t array_argumentos <<< $(echo -e "${argumentos}"| sort -n|uniq)
			fi
			remover
			unset argumentos array_argumentos
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

	debug off
}