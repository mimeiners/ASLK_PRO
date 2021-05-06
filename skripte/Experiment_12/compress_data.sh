#!/bin/bash -
#===============================================================================
#
#          FILE: compress_data.sh
#
#         USAGE: ./compress_data.sh
#
#   DESCRIPTION: Pickle with Compression 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mirco Meiners (MM), Mirco.Meiners@hs-bremen.de
#  ORGANIZATION: 
#       CREATED: 03.05.2020 15:45:50
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
for f in `ls *.txt`; 
do 
    python pickle_data.py $f;
done
