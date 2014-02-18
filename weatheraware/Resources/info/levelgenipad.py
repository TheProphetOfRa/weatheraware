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
        if x == 0:  #lefthand side trees
           output += "\"x\"" + "," 
        elif y == 0 and x != width: #top with no comma
           output += "\"x\"" + ","
        elif y== 0 and x == width: #top with comma
               output += "\"x\""
        elif y == height and x != width: #bottom with no comma
            output += "\"x\"" + ","
        elif y == height and x == width: #bottom with comma
            output += "\"x\""
        elif x == width: #right hand side no comma
           output += "\"x\"" 
        elif y > 3 and y < height-1 and x > 2 and x < width - 2: #middle of board - long grass
            output += "\"g\"" + ","
        elif x == 2 and y == 3: #end of vertical fence left side
            output += "\"w\"" + ","
        elif x == 2 and y > 3 and y < height-1: #left hand side vertical fence
            output += "\"v\"" + ","
        elif x == width - 2 and y > 3 and y < height - 1: #right hand side vertical fence
            output += "\"v\"" + ","
        elif y == height-1 and x == 2: #top left fence corner
            output += "\"l\"" + ","
        elif y == height-1 and x > 1 and x < width - 2: #top horizontal fence
            output += "\"h\"" + ","
        elif y == height-1 and x == width - 2: #top right fence corner
            output += "\"u\"" + "," 
        elif y == 3 and x == width -2: #right hand side vertical end
            output += "\"w\"" + ","
        else: #standard background tile
           output += "\"b\"" + ","

output += "]\n\t]\n}"

file = open("mainscene-ipad.json", "w")
file.write(output)
file.close()
