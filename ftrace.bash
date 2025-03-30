#!/bin/bash


TOGGLE=$1

TRACE="/sys/kernel/debug/tracing"

case "$TOGGLE" in
	"on")
		echo 1 > "$TRACE/tracing_on"
		;;
	"off")
		echo 0 > "$TRACE/tracing_on"
		;;
	"set")
		case "$2" in
			"func"|"function")
				echo function > "$TRACE/current_tracer"
				;;
			"graph")
				echo function_graph > "$TRACE/current_tracer"
				;;
			"none"|"nop")
				echo nop > "$TRACE/current_tracer"
				;;
		esac
		;;
	"check")
		cat "$TRACE/current_tracer"
		;;
	"list")
		cat "$TRACE/available_tracers"
		;;
	"view")
		cat "$TRACE/trace ${@:2}" # allows for abritrary args after
		;;
	*)
		echo "usage: $0 on | off | set <func | graph | nop> | check | list | view [args (| head -20)]"
		;;
esac
