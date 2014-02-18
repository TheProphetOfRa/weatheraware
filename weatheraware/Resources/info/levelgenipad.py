#!/usr/bin/python

from random import randint

x = 0
y = 0

width = 15
height = 11

maxy = height+1
maxx = width+1

output = "{ \n\t\"map\":[\n\t\t"
for y in range(0,maxy):
    if y > 0:
        output += "],\n\t\t"
    output += "["
    for x in range(0,maxx):
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
           output += str(randint(1,6)) + ","

output += "]\n\t],\n\t\"grassmap\":[\n\t\t"

for y in range(0,maxy):
    if y > 0:
        output += "],\n\t\t"
    output += "["
    for x in range(0,maxx):
        if y > 3 and y < height-1 and x > 2 and x < width - 2:
            output += str(1) + ","
        elif x != width:
            output += str(0) + ","
        else:
            output += str(0)

output += "]\n\t],\n\t\"fencemap\":[\n\t\t"

for y in range(0,maxy):
    if y > 0:
        output += "],\n\t\t"
    output += "["
    for x in range(0,maxx):
        if x == 2 and y == 3:
            output += str(8) + ","
        elif x == 2 and y > 3 and y < height-1:
            output += str(1) + ","
        elif x == width - 2 and y > 3 and y < height - 1:
            output += str(1) + ","
        elif y == height-1 and x == 2:
            output += str(2) + ","
        elif y == height-1 and x > 1 and x < width - 2:
            output += str(3) + ","
        elif y == height-1 and x == width - 2:
            output += str(4) + ","
        elif y == 3 and x == width -2:
            output += str(8) + ","
        elif x != width:
            output += str(0) + ","
        else:
            output += str(0)
output += "]\n\t]\n}"

file = open("mainscene-ipad.json", "w")
file.write(output)
file.close()
