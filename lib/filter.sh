

#--------------------------------SOCIAL NETWORKS-------------------------------﹁
#                                                                               |
#   https://github.com/KalleyBacker                                             |
#   https://www.instagram.com/linux_debugging/                                  |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/              |
#                                                                               |
#---------------------------------DOCUMENTACION---------------------------------⸡
#                                                                               |
#    La función filter en Bash toma tres parámetros:                            | 
#    fila, columna, y total. Si total es "all",                                 |
#    muestra todas las filas numeradas del archivo                              | 
#    en la ruta especificada. Si no, filtra la fila                             |  
#    especificada (fila) del archivo en la ruta especificada                    |
#    y muestra el valor de la columna especificada (columna).                   |
#    Utiliza awk para lograr esto, extrayendo el valor de la                    |   
#    columna indicada en la fila especificada.                                  |
#                                                                               |
#--------------------------------FUNCIONAMIENTO---------------------------------⸡
#                                                                               |
#    filter 1 2     - Para imprimir el valor de la columna 2 en la fila 1       |
#    filter 1 @     - Para imprimir el valor de la columna 1 y 2 en la fila 1   |
#    filter 0 0 all - Para imprimir todas las filas numeradas del archivo       |
#                                                                               |
#-------------------------------------------------------------------------------｣



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
