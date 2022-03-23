#!/usr/bin/env python

import sys
import pandas as pd
# import os
# import sqlite3 as lite

datafile = sys.argv[1]

# Read table data with decimal ',' into dataframe from textfile
df = pd.read_table(datafile, decimal=',')
# Read table data with decimal ',' into dataframe from textfile
# df = pd.read_table(datafile, sep=',')


# Create/Open HDF store
# Für schnelle read/write Operationen
# store = pd.HDFStore('Exp12_data.h5')
# store['Schritt3'] = df
# store.close()


# Create/Open SQLite database
# Stukturiert mit SQL abfragen
# db = lite.connect("Exp12_data.sqlite")
# df.to_sql('Schritt3', con=db)
# db.close()


# Use pickle with compression
# Gut zum Speichern
df.to_pickle(datafile + '.pkl.xz', compression='infer')
