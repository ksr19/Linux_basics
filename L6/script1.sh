#!/bin/bash 

usage(){
    cat << EOF
Modifying files content: removing empty lines and capitalizing letters.
Output to terminal.
Usage: $0 [option(s)] [file(s)]
Example:
       $0 --help
       $0 -w file1.txt 
EOF
}

while [[ $# -gt 0 ]] ; do
	[[ -f $1 || -h $1 ]] && FILES+=($1) && shift && continue

	case $1 in
		--help)
		     usage
		     exit 0
		;;
		-*|--*)
		     ARGS+=($1)
		     shift
		;;
	esac
done

(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 1
(( ${#ARGS[@]} == 0 )) && sed -e 's/\w/\u&/g; /^$/d' ${FILES[@]} && exit 0
for ARG in ${ARGS[@]} ; do
	if [[ $ARG == '-w' || $ARG == '--write' ]] ; then
		sed -ie 's/\w/\u&/g; /^$/d' ${FILES[@]}
		echo "Files were modified"
		for FILE in ${FILES[@]} ; do
			rm -f $(find -name "${FILE}e")
		done
	else
		echo "No option $ARG. Check $0 --help for additional info." 
	fi
done
exit 0
