#!/run/current-system/sw/bin/bash
killall polybar

if [ $1 = 'normal' ]; then
	polyexec="polybar"
	if [ $2 = 'opaque' ]; then
		$polyexec base &
		sleep 0.1
		$polyexec empty &
	elif [ $2 = 'transparent' ]; then
		$polyexec transparent &
	else
		echo "I don't know what to do :("
	fi
elif [ $1 = 'desaturated' ]; then
	polyexec="polybar --config=~/.config/polybar/confdesat.ini"
	if [ $2 = 'opaque' ]; then
		$polyexec base &
		sleep 0.1
		$polyexec empty &
	elif [ $2 = 'transparent' ]; then
		$polyexec transparent &
	else
		echo "I don't know what to do :("
	fi
else
	echo "I don't know what to do :("
fi
