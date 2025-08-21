#!/bin/bash

strip_comment() {
	local line="$1"
	local result=""
	local in_quote=0
	local char

	for (( i=0; i<${#line}; i++ )); do
		char="${line:$i:1}"
		if [[ "$char" == "\"" ]]; then
			((in_quote ^= 1))  # Toggle quote flag
			result+="$char"
		elif [[ "$char" == "#" && $in_quote -eq 0 ]]; then
			break  # Stop on comment start (outside quotes)
		else
			result+="$char"
		fi
	done

	echo "$result"
}
