#!/usr/bin/env bash

MONITOR=$(xrandr --query | grep -i " connected " | awk '{ print $1 }' )
