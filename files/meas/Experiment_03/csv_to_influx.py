#!/usr/bin/env python3
"""
Created on Fri July 09 12:00:00 2021
@author: © Vadim Grebnev, Tim Hilker, Delphino Klinker

    Write CSV data into InfluxDB via pandas dataframe.

"""

import pandas as pd
from influxdb import DataFrameClient

#%% Connection data

DBHOST = 'elite.fk4.hs-bremen.de'
DBPORT = 8086
DBUSER = 'ans'
DBPASSWD = 'AI@tESo21'
DBNAME = 'anslab'
PROTOCOL = 'line'

#%% Read data from CSV file.

# Integrator measurements
df_int_gain_datatags = ['time', 'Vout_div_Vin']
df_int_gain = pd.read_csv("../data/int/gain.csv",
                          sep='\t',
                          decimal='.',
                          skiprows=0,
                          header=None,
                          index_col=False,
                          names=df_int_gain_datatags).set_index('time')

df_int_rect_datatags = ['time', 'Vin', 'Vout']
df_int_rect = pd.read_csv("../data/int/rect.csv",
                          sep='\t',
                          decimal='.',
                          skiprows=0,
                          header=None,
                          index_col=False,
                          names=df_int_rect_datatags).set_index('time')

df_int_unitstep_datatags = ['time', 'Vin', 'Vout']
df_int_unitstep = pd.read_csv("../data/int/unitstep.csv",
                              sep='\t',
                              decimal='.',
                              skiprows=0,
                              header=None,
                              index_col=False,
                              names=df_int_unitstep_datatags).set_index('time')

# Differentiator measurements
df_diff_gain_datatags = ['time', 'Vout_div_Vin']
df_diff_gain = pd.read_csv("../data/diff/gain.csv",
                           sep='\t',
                           decimal='.',
                           skiprows=0,
                           header=None,
                           index_col=False,
                           names=df_diff_gain_datatags).set_index('time')

df_diff_rect_datatags = ['time', 'Vin', 'Vout']
df_diff_rect = pd.read_csv("../data/diff/rect.csv",
                           sep='\t',
                           decimal='.',
                           skiprows=0,
                           header=None,
                           index_col=False,
                           names=df_diff_rect_datatags).set_index('time')

df_diff_triangle_datatags = ['time', 'Vin', 'Vout']
df_diff_triangle = pd.read_csv(
    "../data/diff/triangle.csv",
    sep='\t',
    decimal='.',
    skiprows=0,
    header=None,
    index_col=False,
    names=df_diff_triangle_datatags).set_index('time')

#%% Write imported DataFrame data to an influx database (anslab)

# Create client / connection object
client = DataFrameClient(DBHOST, DBPORT, DBUSER, DBPASSWD, DBNAME)

# Write data of "Integrator" measurements of "anslab" database.
client.write_points(df_int_gain,
                    "int_gain",
                    tags={},
                    tag_columns=df_int_gain_datatags[1:],
                    protocol=PROTOCOL)
client.write_points(df_int_gain,
                    "int_rect",
                    tags={},
                    tag_columns=df_int_rect_datatags[1:],
                    protocol=PROTOCOL)
client.write_points(df_int_gain,
                    "int_unitstep",
                    tags={},
                    tag_columns=df_int_unitstep_datatags[1:],
                    protocol=PROTOCOL)

# Write data of "Differentiator" measurements of "anslab" database.
client.write_points(df_int_gain,
                    "diff_gain",
                    tags={},
                    tag_columns=df_diff_gain_datatags[1:],
                    protocol=PROTOCOL)
client.write_points(df_int_gain,
                    "diff_rect",
                    tags={},
                    tag_columns=df_diff_rect_datatags[1:],
                    protocol=PROTOCOL)
client.write_points(df_int_gain,
                    "diff_triangle",
                    tags={},
                    tag_columns=df_diff_triangle_datatags[1:],
                    protocol=PROTOCOL)

#%% EOF
