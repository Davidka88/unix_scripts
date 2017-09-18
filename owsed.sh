
 # run sed and overwrite input file
 # $Id: owsed,v 1.1 2011/04/06 20:51:48 David Exp David $
# modelled on "The UNIX System", page 154
# I can't figure out why they copy the input file; they never use the copy
USAGE="Usage: `basename $0` sed-command file(s)"
Opath=$PATH
PATH=/bin:/usr/bin
if [ $# -lt 2 ]; then echo $USAGE 1>&2; exit 2; fi
Cmd=$1; shift
for File in $*
do
    if [ $# -gt 1 ]; then echo "sed \"$Cmd\" $File"; fi # show if >1 file
    New=/tmp/overwr1.$$
    trap 'rm -f $New; exit 1' 1 2 15        # clean up
    if PATH=$Opath sed "$Cmd" $File >$New   # do actual command, save output
    then
        trap 1 2 15        # we are committed; ignore signals
        cp $New $File
    else
        Ecode=$?
        echo "`basename $0`: $1 failed, $File unchanged" 1>&2
        rm -f $New
        exit $Ecode
    fi
    rm -f $New
done
exit 0
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
