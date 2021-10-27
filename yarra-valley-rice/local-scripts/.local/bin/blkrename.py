#!/usr/bin/env python

import argparse
import pathlib
import glob

current_working_directory: pathlib.Path = pathlib.Path.cwd()
files = current_working_directory.iterdir()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-p",
        "--padding",
        action='store',
        dest='padding',
        type=int,
        default=4,
        help="padding size to use in renaming",
        required=False
    )
