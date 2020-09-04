#!/bin/bash

function properties {
    echo ':PROPERTIES:'
    echo -n ':ADD_DATE: '
    sed 's/<DT><.*ADD_DATE="\([0-9]\+\)".*/\1/g' <<< "${*}"
    echo ':END:'
}

function stars {
    for i in $(seq ${1}); do
	echo -n '*'
    done
    echo -n ' '
}

function processline {
    if grep -q '<DT><' <<< "${*}"; then
	stars ${1}
	shift
	if grep -q '<DT><H3 ' <<< "${*}"; then
	    sed 's/<DT><.*">\(.*\)<\/.*>/\1/g' <<< "${*}"
	elif grep -q '<DT><A ' <<< "${*}"; then
	    sed 's/<DT><.*HREF="\(.*\)" ADD.*">\(.*\)<\/.*>/\[\[\1\]\[\2\]\]/g' <<< "${*}"
	fi

	properties ${*}
    fi
}

l=1
n=0

while read line; do
    # echo "Line No. ${l}"
    if grep -q '<DL><p>' <<< "${line}"; then
	n=$((n+1))
    elif grep -q '</DL><p>' <<< "${line}"; then
	n=$((n-1))
    fi
    processline ${n} ${line}
    l=$((l+1))
done
