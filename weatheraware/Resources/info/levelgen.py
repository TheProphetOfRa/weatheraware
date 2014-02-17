#!/usr/bin/python

from random import randint

x = 0
y = 0

width = 17
height = 9

output = "{ \"map\":["
for y in range(0,10):
    if y > 0:
        output += "],"
    output += "["
    for x in range(0,18):
        if x == 0: 
           output += str(0) + "," 
        elif y == 0 and x != width:
           output += str(0) + ","
        elif y== 0 and x == width:
               output += str(0)
        elif y == height and x != width:
            output += str(0) + ","
        elif y == height and x == width:
            output += str(0)
        elif x == width:
           output += str(0)
        else:
           output += str(randint(1,10)) + ","

output += "]]}"

file = open("mainscene-iphone.json", "w")
file.write(output)
file.close()
