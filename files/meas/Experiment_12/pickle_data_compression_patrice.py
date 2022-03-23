#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
@author: Patrice Bönig

"""

import pandas as pd
import os

# ------------------------ 


def compression(file_type, seperator, path):   
    r'''

    Parameters
    ----------
    file_type : string
        Enthält den zu komprimierenden Dateitypen
    path : string
        Enthält den Pfad zu den Dateien. 

    Returns
    -------
    None.

    '''
    i = 0 
    
    # Auswahl ob dafault Pfad oder nicht
    os.chdir("./")
    if path != "":
        os.chdir(path)
    
    # lesen der Dateien in Pfad 
    files = os.listdir("./")
    
    # Parameter für die unterschiedlichen Dateitypen unter Berücksichtigung von 
    # Groß- und Kleinschreibung
    if file_type == "txt":
        ending = [".txt", ".TXT"]

        for end in ending:  # die zwei Endungen durchiterieren
            for name in files:
                if name.endswith(end):    
                    i = i + 1
                    print("converting file " + str(i) + " with ending " + end + " ...")
                    df = pd.read_table(name, decimal=str(seperator))
                    df.to_pickle(name + '.pkl.xz', compression='infer')
        print("\n" + str(i) + " files where converted, finished.")
        
    elif file_type == "csv":
        ending = ["csv", "CSV"]

        for end in ending:  # die zwei Endungen durchiterieren
            for name in files:
                if name.endswith(end):    
                    i = i + 1
                    print("converting file " + str(i) + " with ending " + end + " ...")
                    df = pd.read_table(name, sep=seperator, engine='python')
                    df.to_pickle(name + '.pkl.xz', compression='infer')
        print("\n" + str(i) + " files where converted, finished.")
    

# ------------------------        

print("\n With this little program all files in one folder where compressed, via pickle.\n")        
answer = input("Which file type should be comprossed? [txt/csv]: ")
seperator = input("Which seperator? [,/;]: ")
path = input("In which folder are they? default -> [./]: ")

compression(answer, seperator, path)        
        
