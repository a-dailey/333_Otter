li x5, 0x11000000      #load switch address into x5
li x6, 0x00000004      #load 4 into x6
li x7, 0x00007fa6      #load 32,678 into x7
lw x8, 0(x5)           #load 32-bit switch value into x8
bge x8, x7, TRUE       #if switch value greater than or equal to 32,678, jump to TRUE tag
add x9, x8, x8         #double switch value and store in x9
	j END          #jump to end
TRUE: srli x9, x8, 2   #divide switch value by 4
END: sw x9, 0x40(x5)   #store final value in LED address

