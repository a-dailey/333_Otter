li x7, 0x11000000 #load switch location to x7
li x6, 0x00000000 #load 0 into x6
lhu x5, 0(x7)     #load first 16 bit input from switches
add x6, x6, x5    #add first value to switches
lhu x5, (x7)  #load second switch value to x5
add x6, x6, x5    #add second switch value to x6
lhu x5, (x7)  #load 3rd switch value to x5
add x6, x6, x5    #add 3rd switch value to x6
sw x6, 0x20(x7)   #write final sum to LED's
