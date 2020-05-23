#!/usr/bin/env bash
# SPDX-License-Identifier: ???
# Copyright (c) 2020 Chua Hou

FILE_NAME="link"
ALL_DIR="all/"
TGT_DIR="./"
FILE_EXT=".png"

# $1 = number
# $2 = directory
function num_to_file {
	echo $2$1$FILE_EXT
}

# $1 = source
# $2 = symlink name
function create_link {
	ln -s $1 $2
}

# each line in file is of form
# target_number source_number
while read line; do
	# read line into array
	read -ra ARRAY <<< $line

	# perform link
	create_link $(num_to_file ${ARRAY[1]} $ALL_DIR) \
		$(num_to_file ${ARRAY[0]} $TGT_DIR)
done < $FILE_NAME
