#!/bin/bash
# parameters:
# 1 - rows
# 2 - collumns
# [3] - range
# [4] - decimal places
# [5] - signed
# [6] - filename of output

# outputs $1x$2 matrix in $3 file, with values <= $4 or <= $RANGE if $4 is not given

RANGE=200;
DECIMAL=2;
SIGNED="6";
if [ -z $1 ] || [ -z $2 ]; then
    echo -e "# parameters\n# 1 - rows\n# 2 - collumns\n# [3] - max (default = $RANGE)\n# [4] - decimal places (default = $DECIMAL)\n# [5] - signed (0 - always pos, else prob[signal] = 1/signed, default = 6)\n# [6] - filename (default = stdout)";
    exit -1;
fi
# Checks if max is assigned
if [ ! -z $3 ]; then
    RANGE=$3;
fi
# Checks if decimal is assigned
if [ ! -z $4 ]; then
    DECIMAL=$4;
fi
# Checks if signed is assigned
if [ ! -z $5 ]; then
    SIGNED=$5;
fi
# Checks if filename is assigned
if [ -z $6 ]; then
    file="/dev/stdout";
else
    # Creates empty file with parameter 5's name (or clears existing one)
    file="$6";
    > $file;
fi
DRANGE=$(( 10 ** DECIMAL ));
# For each row assigned by $1
echo "$1" > $file;
for (( i = 0; i < ${1}; i++ )); do
    # For each collumn assigned by $2
    for (( j = 0; j < ${2}; j++ )); do
        val=$(( $RANDOM % $RANGE ));
        dec=$(( $RANDOM % $DRANGE ));
        # Decimal place with leading 0's
        string="%d.%0${DECIMAL}d ";
        num=$(printf "$string" $val $dec);
        if [ $SIGNED -eq 0 ]; then
            sign='';
        else
            vsign=$(( RANDOM % $SIGNED ));
            if [ $vsign -gt $(( $SIGNED - 2 )) ]; then
                sign='-';
            else
                sign='';
            fi
        fi
        echo -n "$sign$num " >> $file;
    done
    echo >> $file;
done


