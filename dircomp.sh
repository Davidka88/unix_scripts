 # script to compare two directories
 # $Id: dircomp,v 1.1 2011/04/06 20:51:48 David Exp David $
 # modified 7-3-90 to find plain files and symbolic links
TEMP=/tmp/df$$.tmp
if [ "$1" = -v ]; then LOUD=yes; shift; fi
if [ $# -eq 0 ]
then
    echo "usage: `basename $0` [-v] dir_1 [dir_2 [filenames]]"
    exit 1
fi
if [ $# -eq 1 ]; then IN='.'; OUT=$1; else IN=$1; OUT=$2; shift; fi
shift
HERE=`pwd`
cd $IN; IN=`pwd`; cd $HERE
cd $OUT; OUT=`pwd`; cd $HERE
echo "< Base  directory is $IN"
echo "> Other directory is $OUT"
if [ $# -gt 0 ]; then FILES="$*"; else FILES=`find $IN \( -type f -o -type l \) -print`; fi
for HERE in $FILES
do
    BASE=`echo $HERE | sed "s!$IN/!!"`
    OTHER=$OUT/$BASE
    if [ "$LOUD" ]
    then
	diff $HERE $OTHER >$TEMP 2>&1
    else
	diff $HERE $OTHER >/dev/null 2>$TEMP
    fi
    case $? in
    0) echo "No Change - $BASE";;
    1) echo "Is Change - $BASE"; if [ $LOUD ]; then cat $TEMP; fi;;
    *) cat $TEMP;;
    esac
done
#                   Copyright 2011 by David M. Elins
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the  Free  Software  Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,  but
# WITHOUT   ANY   WARRANTY;  without  even  the  implied  warranty  of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the  GNU
# General Public License for more details.
#
# A  copy  of  the  GNU  General  Public  License  (GPL)  be  found at
# <http://www.gnu.org/licenses/gpl-3.0-standalone.html>.
#
# One  is  supposed  to be included here but doing so would bloat this
# source code too much.
#
# vim:tabstop=8:shiftwidth=4:noexpandtab filetype=sh
