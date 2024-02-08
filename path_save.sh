#!/bin/bash

#Author: [ KalleyBacker ]

function pmng {

	debug off
	
	local ruta="${HOME}/.Path_save_cache.cache"
    local temporal="${HOME}/.Path_save_cache.cache1"
	color

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