#!/bin/bash

import re
import os
import subprocess

current = os.getcwd()
game_name = current.split('/')[-1]
renpy_path = os.path.join(current, 'renpy')
init_path = os.path.join(renpy_path, '__init__.py')
if os.path.exists(renpy_path):
    file = open(init_path, 'r')
    content = file.read()
    pattern = re.compile(r"version_tuple = \(([0-9], [0-9], [0-9]), .*?\)")
    match = re.findall(pattern, content)
    file.close()
    if match:
        match = match[0]
        version = match.replace(' ', '')
        version = version.replace(',', '.')
        print(f"Game: {game_name}", f"Version: {version}")
        os.chdir(os.pardir)
        cmd = subprocess.Popen(['sh', '/home/ranger/.local/bin/renpy2sh.sh', game_name, version], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        cmd.communicate()
    else:
        print("No match found!")
else:
    print("Renpy directory not found!")
