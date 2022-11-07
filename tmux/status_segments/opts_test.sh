#!/bin/bash

OPTS=`getopt p:h $*`

eval set -- "$OPTS"

PATTERN="."

while true; do
	case "$1" in
		-p)
			PATTERN="$2"; shift 2;;
		-h)
			echo "help text!"; shift ;;
		--)
			shift ; break ;;
		*)
			echo "ERR!" ; exit 1 ;;
	esac
done

eval "$@"
fswatch -o $PATTERN | xargs -n 1 -I {} "$@"

