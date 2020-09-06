#!/bin/bash

usage() {
    cat << EOF
Create files in specified directory.
Usage: $0 [file(s)] -d [directory]
Examples:
       $0 --help
       $0 file1 file2 -d /tmp/dir1
EOF
}

while [[ $# -gt 0 ]] ; do
	
	case $1 in
		--help)
			usage
			exit 0
		;;
		-d)
			shift
			if [[ -z $DIR ]] ; then
			 	DIR=$1
			else
				echo "Only one directory is allowed." && exit 1
			fi	
			shift
		;;
		-*|--*)
			#ARGS+=($1)
			usage
			exit 5
		;;
		*)
			FILES+=($1)
			shift
		;;	
	esac
done

(( ${#FILES[@]} == 0 )) && echo "No files specified." && exit 2
[[ -z $DIR ]] && echo "No directory specified." && exit 3
[[ ! -d $DIR ]] && mkdir $DIR
#(( ${#ARGS[@]} != 0 )) && echo "No arguments allowed right now" && exit 5
for FILE in ${FILES[@]} ; do
	FULLNAME="${DIR}/${FILE}"
	if [[  $FILE == *"/"* ]] ; then
		echo "Unable to create file with name $FILE"
	else
		if [[  -f $FULLNAME || -h $FULLNAME ]] ; then
			echo "File $FILE already exists in $DIR"
		else
			touch "$FULLNAME"
			[[  $FILE == *".sh" ]] && chmod +x "$FULLNAME" 
		fi	
	fi
done
exit 0
