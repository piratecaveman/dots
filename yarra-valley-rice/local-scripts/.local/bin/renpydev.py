#!/usr/bin/env python

"""
Enable developer mode in Renpy Games
"""

import os
import re
import json

base = os.getcwd()
#source = os.path.join('C:\\', 'users', 'kshit', 'PythonExec', 'cache', 'UnRen.bat')
destination = base
#os.system(f'copy "{source}" "{destination}"')

path = os.path.join(os.getcwd(), 'game')
if os.path.exists(path):
    old_path = os.getcwd()
    os.chdir(path)
    
    """
    List all the Labels in the rpy files, if unpacked.
    """
    lst = os.listdir(path)
    files = []
    labels = []
    for item in lst:
        if item.split('.')[-1] == 'rpy':
            files.append(item)
    
    for item in files:
        file = open(item, 'r', errors = 'ignore')
        content = file.read()
        label = re.findall('label (\w+)', content)
        label = list(set(label))
        for item in label:
            labels.append(item)
    
    labels = list(set(labels))
    file = open('labels.json', 'w')
    file.write(json.dumps(labels, indent = 4))
    file.close()
    lfile = os.path.join(path, 'labels.json')
    
    """
    Write the initialization files
    """
    
    file = open('unren.rpy', 'w')
    file.write("init 999 python:\n")
    file.write("    import json\n")
    file.write("    config.console = True\n")
    file.write("    config.developer = True\n")
    file.write("    renpy.config.rollback_enabled = True\n")
    file.write("    renpy.config.hard_rollback_limit = 512\n")
    file.write("\n")
    
    file.close()
    os.chdir(old_path)
    print("Process completed successfully!")
else:
    print("Directory not found.")
