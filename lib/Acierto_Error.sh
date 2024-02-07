#!/usr/bin/env bash

#----------------------------SOCIAL NETWORKS-----------------------------
#                                                                       |
#   https://github.com/KalleyBacker                                     |
#   https://www.instagram.com/linux_debugging/                          |
#   https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/      |
#                                                                       |
#-----------------------------DOCUMENTACION------------------------------
#                                                                       |
#  Función encargada de colorear los mensajes que pmng envía al output  |
#                                                                       |
#-----------------------------FUNCIONAMIENTO-----------------------------
#                                                                       |
#       Para enviar mensajes de error                                   | 
#       Acierto_error "Error" "mensaje...[variable a destacar]..."      |
#                                                                       |
#       Para enviar mensajes de Aciertos                                |
#       Acierto_error "Acierto" "mensaje...[variable a destacar]..."    |
#                                                                       |
#------------------------------------------------------------------------

function Acierto_Error {
  
   	
    local pregunta=$1 #--- Indica si el mensaje es de Error o Acierto
   	local parametro=$2 #-- Cuerpo del mensaje 
    
    if [[ ${pregunta} = Error ]];then
    	local signo='❌' && local color=${red}
    elif [[ ${pregunta} = Acierto ]]; then
    	local signo='✅'&& local color=${verd}
    fi

    #--"Destaca el contenido que esté dentro de [Bracket] y asigna el color correspondiente
    echo -e "${white}[${null}${signo}${white}] ${pregunta} - ${null}$(echo -n "$2" |\
        sed -e "s/\[/\\${null}\\${white}&/g" \
            -e "s/]/&\\${null}/g" \
            -e "s/\\033\[0m/&\\${color}/g" \
            -e "s/^\[/\\${white}&/" \
            -e "s/^[^[]/\\${color}&/" \
            -e "s/[^[]$/&\\${null}/")"
}
