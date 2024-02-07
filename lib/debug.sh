#!/usr/bin/env bash


function debug {
	set +x
	local interruptor=$1

	if [[ ${interruptor} = off ]];then
		set +x
	elif [[ ${interruptor} = on ]];then
		set -x
	fi
}
