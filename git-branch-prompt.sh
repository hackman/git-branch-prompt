#!/bin/bash 

function change_ps {
	PS1='($(git br 2>/dev/null|awk "/^*/{print \$2}")):\w\$ '
	export PSCHANGED=1
}

function revert_ps {
	PS1="\u@\h:\w\$ "
	export PSCHANGED=0
}

function branch {
	cd $1
	if [[ "$PWD" =~ \/home\/hackman\/Projects ]]; then
		if [ "$PSCHANGED" == 1 ]; then
			if [ "$PWD" != "$OLDPWD" ]; then
				change_ps
			fi
		else
			change_ps
		fi
	else
		revert_ps
	fi
}
alias cd=branch
cd .
