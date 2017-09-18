 # which" cmd copied from K&P unix manual - finds where in current path
 # $Id: findx,v 1.1 2011/04/06 20:51:48 David Exp David $
# a command is located
# heavily modified Sep 1995 by David Elins to find aliases
# (modified on C-shell 'which' command)
CMD=echo
BREAKOUT=break
while getopts av C
do
    case $C in
    a) BREAKOUT=; ;;
    v) CMD=file; ;;
    \?) CMD=error; ;;
    esac
done
if [ $CMD = error ]
then
    shift $#
else
    shift `expr $OPTIND - 1`
fi
if [ $# = 0 ]; then echo 'Usage: ' `basename $0` ' [-av] command_name';exit 2;fi
exitstat=1
check_alias() {
    csh -f -s "$@" << \EOF
    set _which_saved_path_ = ""
    set prompt = ""
    if ( -r ~/.cshrc && -f ~/.cshrc ) source ~/.cshrc
    set alius = `alias $argv[1]`
    switch ( $#alius )
    case 0 :
	exit 1
    default :
	echo ${argv[1]} aliased to $alius
	exit 0
    endsw
EOF
}
PATHS=`echo $PATH | sed 's/^:/.:/; s/::/:.:/; s/:$/:./; s/:/ /g'`
for I
do
    if check_alias "$I"; then continue; fi
    for J in $PATHS
    do
	f=$J/$I
	#if [ -x $f ]; then file $f; exitstat=0; $BREAKOUT; fi
	if [ -r $f -a -f $f ]; then $CMD $f; exitstat=0; $BREAKOUT; fi
    done
done
exit $exitstat
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
