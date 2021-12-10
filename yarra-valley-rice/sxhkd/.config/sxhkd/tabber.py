#!/usr/bin/env python

import subprocess
import typing


def run_command(command: list[str]) -> str:
    output = subprocess.run(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return output.stdout.decode('utf-8')


def get_focused_node() -> str:
    command = ['bspc', 'query', '--nodes', '--node', 'focused']
    result = run_command(command)
    return result


def make_tabbed(window_id: str) -> str:
    command = ['tabc', 'create', window_id]
    _ = run_command(command)
    return get_focused_node()


def detach_window(window_id: str):
    command = ['tabc', 'detach', window_id]
    _ = run_command(command)
    return


def attach_window(window_id: str, tabbed_window_id: typing.Union[str, None] = None):
    tabc
