#!/usr/bin/env bash


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
