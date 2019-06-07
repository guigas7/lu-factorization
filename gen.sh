#!/bin/bash
# parameters:
# 1 - rows
# 2 - collumns
# [3] - range
# [4] - filename of output

# outputs $1x$2 matrix in $3 file, with values <= $4 or <= $RANGE if $4 is not given

RANGE=201;
if [ -z $1 ] || [ -z $2 ]; then
    echo -e "# parameters\n# 1 - rows\n# 2 - collumns\n# [3] - max (default = $(( $RANGE - 1 )))\n# [4] - filename (default = stdout)";
    exit -1;
fi
# Checks if max is assigned
if [ ! -z $3 ]; then
    RANGE=$(( $3 + 1 ));
fi
# Checks if filename is assigned
if [ -z $4 ]; then
    file="/dev/stdout";
else
    # Creates empty file with parameter 4's name (or clears existing one)
    file="$4";
    > $file;
fi
# For each row assigned by $1
for (( i = 0; i < ${1}; i++ )); do
    # For each collumn assigned by $2
    for (( j = 0; j < ${2}; j++ )); do
        val=$(( $RANDOM % $RANGE ));
        echo -n "$val.0 " >> $file;
    done
    echo >> $file;
done


