#!/usr/bin/env python

import argparse
import pathlib
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument(
    '-d',
    '--directory',
    action="store",
    dest="directory",
    required=True,
    help="path to directory with images"
)
parser.add_argument(
    '-s',
    '--sample-size',
    action="store",
    dest="sample_size",
    required=False,
    default=5,
    type=int,
    help="Sample size for testing Quality"
)

parsed = parser.parse_args()
directory = pathlib.Path(parsed.directory)
sample_size: int = parsed.sample_size
if not directory.exists():
    print(f"{directory.absolute()} does not exist")
    exit(1)
elif directory.is_file():
    print(f"{directory.absolute()} is a file")
    exit(1)

if __name__ == '__main__':
    files = list(directory.glob("*.jpg"))
    files.extend(directory.glob("*.webp"))
    files.extend(directory.glob("*.png"))
    files.extend(directory.glob("*.jpeg"))
    total = len(files) if len(files) < sample_size else sample_size
    command = ['identify', '-format', '%Q']
    quality: int = 0
    for item in range(0, total):
        command.append(str(files[item].absolute()))
        quality += int(subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout.decode('utf-8'))
        command.pop()

    final = quality / total if total != 0 else quality
    print(int(final))
    exit(0)
