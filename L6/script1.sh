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
		-w|--write)
		     WRITE=TRUE
		     shift
		;;
	esac
done

(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 1
if [[ -n $WRITE ]] ; then
    sed -ie 's/\w/\u&/g; /^$/d' ${FILES[@]}
    echo "Files were modified"
else
    sed -e 's/\w/\u&/g; /^$/d' ${FILES[@]}
fi
exit 0
