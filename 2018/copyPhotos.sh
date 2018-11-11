#! /bin/sh
PATH_IN=$1
PATH_OUT=$2


inotifywait -m $PATH_IN  -e moved_to  |
	while read path action file; do
		echo "The file '$file' appeared in directory '$path' via '$action'"
		convert $path/$file -resize 800x600 $PATH_OUT/$(ls -l1 $PATH_OUT | wc -l ).jpg
    done
