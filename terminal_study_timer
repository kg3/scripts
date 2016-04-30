#!/usr/local/bin/python3
# -*- coding: utf-8 -*-
# terminal timer with breaks from studying or working
import sys
import time

def Timer(_time):
    #   Input: an integer of time
    #  Return: nothing
    # Purpose: run a loop pausing every minute
    minute = 60
    i = 1
    while i <= _time :
        currentString = returnCurrent(i)
        sys.stdout.write('\r[{0}{1}] {2}'.format('#'*(i), ' '*(_time-i),' %s  %s ' % (i,currentString)))
        sys.stdout.flush()
        time.sleep(minute)
        i+=1
    print("\n")

def returnCurrent(i):
    #   Input: an integer
    #  Return: string of a bar
    # Purpose: to animate the update progress
    # /-\|
    # ◐◓◑◒
    # ◢◣◤◥
    # ←↖↑↗→↘↓↙
    if (i%4) == 0: 
        return '\b◐'
    elif (i%4) == 1: 
        return '\b◓'
    elif (i%4) == 2:
        return '\b◑'
    elif (i%4) == 3: 
        return '\b◒'


on = 30
off = 20
prep = 5
while True:
    print("\nPress Ctrl-Z to Exit\n")
    print("Get ready to study\n")
    Timer(prep)
    print("Should be working right now\n")
    Timer(on)
    print("Break Time now\n")
    Timer(off)
