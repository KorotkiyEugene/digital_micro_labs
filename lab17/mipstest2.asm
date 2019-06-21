main:       
        addi $2, $0, 0
        addi $3, $0, 10
        addi $4, $0, 0x989    # $4 = 0x989
        sll  $4, $4, 12       # $4 = $4 << 12 = 0x989000
        addi $4, $4, 0x680    # $4 = $4 + 0x680 = 0x989680 
        srl  $11, $4, 3       # $11 = $4 >> 3 (Testing srl)  
        addi $7, $0, 0x80     # $7 = 0x80
        sll  $7, $7, 24       # $7 = $7 << 24 = 0x80000000
        addi $7, $7, 0x0040   # $7 = $7 + 0x0040 = 0x80000040 

count_loop:            

# Display number

        addi $9, $0, 0
        addi $8, $0, 0x40
        beq  $2, $9, display

        addi $9, $0, 1
        addi $8, $0, 0x79
        beq  $2, $9, display

        addi $9, $0, 2
        addi $8, $0, 0x24
        beq  $2, $9, display


        addi $9, $0, 3
        addi $8, $0, 0x30
        beq  $2, $9, display

        addi $9, $0, 4
        addi $8, $0, 0x19
        beq  $2, $9, display

        addi $9, $0, 5
        addi $8, $0, 0x12
        beq  $2, $9, display

        addi $9, $0, 6
        addi $8, $0, 0x02
        beq  $2, $9, display

        addi $9, $0, 7
        addi $8, $0, 0x78
        beq  $2, $9, display

        addi $9, $0, 8
        addi $8, $0, 0x00
        beq  $2, $9, display

        addi $9, $0, 9
        addi $8, $0, 0x18
        beq  $2, $9, display

        addi $8, $0, 0x00

display:
        sw   $8, 0($7)

# Make delay
        add  $5, $4, $0        # $5 = $4 
delay:
        beq  $5, $0, delay_end
        addi $5, $5, -1
        j delay

delay_end:

        addi $2, $2, 1        # $2 = $2 + 1

        beq $2, $3, rst_cnt
        j count_loop
rst_cnt:      
        addi $2, $0, 0 
        j count_loop 
