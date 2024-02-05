
.eqv BG_COLOR, 0x0F	 # light blue (0/7 red, 3/7 green, 3/3 blue)
.eqv VG_ADDR, 0x11000120
.eqv VG_COLOR, 0x11000140
.eqv sseg, 0x11000040

main:
    li sp, 0x10000     #initialize stack pointer
	li s2, VG_ADDR     #load MMIO addresses 
	li s3, VG_COLOR    
	li s4, 0 #score
	li s5, sseg #sseg address
	sw s4, 0x00(s5)
	
	#setup interrupt
	la    t0, bird_jump
        csrrw x0, mtvec, t0  # setup ISR address
        li t0, 8
        csrrs x0, mstatus, t0     # enable interrupts


	# fill screen using default color
	li a1, 0
	li a3, BG_COLOR
	call draw_background  # must not modify s2, s3
	
	li a3, 0x5a
	li a1, 51
	call draw_background
	
	#draws dot at (10,20)
	li a4, 10
	li a5, 20
	li a3, 0x1F8
	call draw_bird

	li a0, 20 #starting pillar x position

move_loop:
	#moves first pillar
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, BG_COLOR
	call draw_vertical_line  # must not modify s2, s3
	addi a0, a0, -1
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, 0
	call draw_vertical_line
	
	
	#moves second pillar
	addi a0, a0, 21
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, BG_COLOR
	call draw_vertical_line  # must not modify s2, s3
	addi a0, a0, -1
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, 0
	call draw_vertical_line
	
	#moves third pillar
	addi a0, a0, 21
	li a1, 30 	# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, BG_COLOR
	call draw_vertical_line  # must not modify s2, s3
	addi a0, a0, -1
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, 0
	call draw_vertical_line
	
	#moves fourth pillar
	addi a0, a0, 21
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, BG_COLOR
	call draw_vertical_line  # must not modify s2, s3
	addi a0, a0, -1
	li a1, 30		# starting Y coordinate
	li a2, 50		# ending Y coordinate
	li a3, 0
	call draw_vertical_line
	
	
	
	#bird will not fall if at bottom
	li s6, 59
	bge a5, s6, bird_at_bottom
	
	#bird falls
	li a3, BG_COLOR
	call draw_bird
	addi a5, a5, 1
	li a3, 0x1F8
	call draw_bird
	j bird_not_at_bottom
	
bird_at_bottom:	
	call GAMEOVER
	
bird_not_at_bottom:
	call delay
	addi a0, a0, -60 #a0 = x value of leftmost pillar
	bnez a0, move_loop #if pillar is not at left edge, loop
	#pillar has hit left edge
	addi s4, s4, 1 #increments score
	sw s4, 0x00(s5)
	#erases leftmost pillar
	li a1, 30		# starting Y coordinate
	li a2, 59		# ending Y coordinate
	li a3, BG_COLOR
	call draw_vertical_line  # must not modify s2, s3
	
	#draw new pillar on right
	li a0, 80
	li a1, 30		# starting Y coordinate
	li a2, 59		# ending Y coordinate
	li a3, 0
	call draw_vertical_line  # must not modify s2, s3
	li a0, 20
	j move_loop
	

delay:
	li t0, 0x3ebc20
	li t1, 0
delay_loop:
	addi t1, t1, 1
	bne t1, t0, delay_loop
	ret

# draws a horizontal line from (a0,a1) to (a2,a1) using color in a3
# Modifies (directly or indirectly): t0, t1, a0, a2
draw_horizontal_line:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi a2,a2,1	#go from a0 to a2 inclusive
draw_horiz1:
	call draw_dot  # must not modify: a0, a1, a2, a3
	addi a0,a0,1
	bne a0,a2, draw_horiz1
	lw ra, 0(sp)
	addi sp,sp,4
	ret

# draws a vertical line from (a0,a1) to (a0,a2) using color in a3
# Modifies (directly or indirectly): t0, t1, a1, a2
draw_vertical_line:
	addi sp,sp,-4
	sw ra, 0(sp)
	addi a2,a2,1
draw_vert1:
	call draw_dot  # must not modify: a0, a1, a2, a3
	addi a1,a1,1
	bne a1,a2,draw_vert1
	lw ra, 0(sp)
	addi sp,sp,4
	ret

# Fills the 60x80 grid with one color using successive calls to draw_horizontal_line
# Modifies (directly or indirectly): t0, t1, t4, a0, a1, a2, a3
draw_background:
	addi sp,sp,-4
	sw ra, 0(sp)

	li t4, 60 	#max rows
start:	li a0, 0
	li a2, 79 	#total number of columns
	call draw_horizontal_line  # must not modify: t4, a1, a3
	addi a1,a1, 1
	bne t4,a1, start	#branch to draw more rows
	lw ra, 0(sp)
	addi sp,sp,4
	ret

# draws a dot on the display at the given coordinates:
# 	(X,Y) = (a0,a1) with a color stored in a3
# 	(col, row) = (a0,a1)
# Modifies (directly or indirectly): t0, t1
draw_dot: andi t0,a0,0x7F	# select bottom 7 bits (col)
	andi t1,a1,0x3F	# select bottom 6 bits  (row)
	slli t1,t1,7	#  {a1[5:0],a0[6:0]} 
	or t0,t1,t0	# 13-bit address
	sw t0, 0(s2)	# write 13 address bits to register
	sw a3, 0(s3)	# write color data to frame buffer
	ret
	
#draws dot at (a4, a5) with color in a3
draw_bird:
	andi t5, a4, 0x7f
	andi t6, a5, 0x3f
	slli t6, t6, 7
	or t5, t6, t5
	sw t5, 0(s2)
	lw t6, 0x20(s3)
	beqz t6, GAMEOVER
	sw a3, 0(s3)
	ret

GAMEOVER:
	li a3, 0xe0
	li a1, 0
	call draw_background
	call delay
	li t0, 0x989680
	addi t1, x0, 0
	death:
		bgt t1, t0, main
		addi t1, t1, 1
		j death
	j main

bird_jump: li a3, BG_COLOR
	mv s7, t1
	#call draw_bird
	andi t5, a4, 0x7f
	andi t6, a5, 0x3f
	slli t6, t6, 7
	or t5, t6, t5
	sw t5, 0(s2)
	sw a3, 0(s3)
	
	#raises bird 3 
	addi a5, a5, -3
	li a3, 0x1F8
	
	#call draw_bird
	andi t5, a4, 0x7f
	andi t6, a5, 0x3f
	slli t6, t6, 7
	or t5, t6, t5
	sw t5, 0(s2)
	lw t6, 0x20(s3)
	beqz t6, GAMEOVER
	sw a3, 0(s3)
	
	mv t1, s7
	mret
	
	