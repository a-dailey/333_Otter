li x5, 0x11000000    #load switch address
li x6, 0x00000001   #load 1 into x12
li x7, 0x00000fff   #load 4095 into x15
lw x8, 0(x5)         #load switch value into x8
andi x9, x8, 0x03    #check to see if switch value has postive 2 or 1 bit(number not divisible by 4)
beq x0, x9, div_by_4 #if number was divisible by 4, jump to div_by_4 tag
andi x9, x8, 0x01    #check if number divisible by 2
bne x0, x9,  odd     #if number is odd, jumpt to odd tag
sub x13, x8, x6      #subtract 1 from switch value
	j end        #jump to end
	
div_by_4: 
not x13, x8         #invert all bits
	j end       #jump to end
	
odd:
add x13, x8, x7    #add 4,095 to switch values
add x6, x6, x6   #add 1 to 1
srli x13, x13, 1   #divide by 2
	j end       #jump to end

end:
sw x13, 0x40(x5)    #store final value in LED's address



