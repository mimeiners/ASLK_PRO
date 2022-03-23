#!/bin/bash -
#===============================================================================
#
#          FILE: mksqlite.sh
#
#         USAGE: ./mksqlite.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mirco Meiners (Mirco.Meiners@hs-bremen.de), 
#  ORGANIZATION: HSB
#       CREATED: 21.06.2019 14:15:30
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
for file in *.CSV
do 
    sqlite3 Messdaten.sqlite -echo -cmd ".mode csv" ".import ${file} ${file/.CSV}"
done 
