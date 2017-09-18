 # remove carriage returns from input files
# $Id: nocr,v 1.1 2011/04/06 20:51:48 David Exp David $
if [ $# -eq 0 ]
then
    tr -d '\015'	# use stdin
else
    for F in "$@"
    do
	tr -d '\015'  <$F
    done
fi
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
