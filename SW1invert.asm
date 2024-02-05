li x7, 0x11000000 #Load switch address to x7
lh x5, 0(x7)      #Load 16 bit switch value into x5
neg x6, x5	  #Negate switch value and store in x6
sh x6, 0x20(x7)   #Store word in LED address