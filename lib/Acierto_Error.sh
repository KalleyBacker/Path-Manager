#!/usr/bin/env bash

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
