#!/usr/bin/env python

import argparse
import subprocess
import json


def get_focused_node() -> str:
    sequence = ['bspc', 'query', '--nodes', '--node', 'focused']
    command = subprocess.run(sequence, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip()


def get_focused_desktop() -> str:
    sequence = ['bspc', 'query', '--desktops', '--desktop', 'focused']
    command = subprocess.run(sequence, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip()


def toggle_hide(window_id: str) -> str:
    sequence = ['bspc', 'node', f'{window_id}', '--flag', 'hidden']
    command = subprocess.run(sequence, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip()


def move_to_desktop(window_id: str, desktop_id: str) -> str:
    sequence = ['bspc', 'node', f'{window_id}', '--to-desktop', f'{desktop_id}']
    command = subprocess.run(sequence, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip()


def list_desktops() -> list:
    sequence = ['bspc', 'query', '--desktops']
    command = subprocess.run(sequence, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    return command.stdout.strip().decode('utf-8').split("\n")


def get_nodes_in_desktop(desktop_id: str) -> list:
    sequence = ['bspc', 'query', '--nodes', '--node', '.window', '--desktop', f'{desktop_id}.local']
    command = subprocess.run(sequence, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip().split("\n")


def check_hidden_status(window_id: str) -> bool:
    sequence = ['bspc', 'query', '--tree', '--node', f'{window_id}']
    command = subprocess.run(sequence, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output = command.stdout.decode('utf-8').strip()
    if output:
        return json.loads(output).get('hidden', False)
    return False


def get_hidden_nodes_in_desktop(desktop_id: str) -> list:
    sequence = ['bspc', 'query', '--nodes', '--node', '.window.hidden', '--desktop', f'{desktop_id}.local']
    command = subprocess.run(sequence, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip().split("\n")


def get_desktops() -> list:
    sequence = ['bspc', 'query', '--desktops', '--desktop', '.occupied']
    command = subprocess.run(sequence, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    return command.stdout.decode('utf-8').strip().split("\n")


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--hide',
        action='store_true',
        dest='hide_window',
    )
    parser.add_argument(
        '--unhide',
        action='store_true',
        dest='unhide_window',
    )
    content = {desktop: get_hidden_nodes_in_desktop(f'{desktop}') for desktop in get_desktops()}

    parsed = parser.parse_args()
    if parsed.hide_window:
        win_id = get_focused_node()
        if not check_hidden_status(win_id):
            content.get(get_focused_desktop(), list()).append(win_id)
            toggle_hide(win_id)
            exit(0)

    if parsed.unhide_window:
        desk_id = get_focused_desktop()
        win_id = content.get(desk_id, list()).pop()
        if check_hidden_status(win_id):
            toggle_hide(win_id)
            exit(0)
        else:
            content[desk_id].append(win_id)
            exit(1)
