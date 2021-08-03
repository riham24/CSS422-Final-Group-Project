*-----------------------------------------------------------
* Title      : Final Project
* Written by : MysteryHuskies
* Date       : 7/28/21
* Description: Disassembler
*-----------------------------------------------------------
    
            ORG         $1000           ; start at $1000
    
START:                                  ; first instruction of the program 
   
FIRSTNUM    LEA         INTRO,A1        ; load intro message into A1
            MOVE.B      #14,D0          ; move the number 14 to D0
            TRAP        #15             ; display the intro message in the console
            MOVE.B      #2,D0           ; move the number 2 to D0
            TRAP        #15             ; read a string from the keyboard and store at (A1)
            BRA         HEX             ; branch to part of code that converts string to hex
            
PRESECNUM   MOVE.L      D2,BEGIN        ; move converted input to BEGIN
            CLR.L       D2              ; clear out D2

SECONDNUM   LEA         INTRO2,A1       ; load message asking for second number into A1
            MOVE.B      #14,D0          ; move the number 14 to D0
            TRAP        #15             ; display the intro message in the console
            MOVE.B      #2,D0           ; move the number 2 to D0
            TRAP        #15             ; read a string from the keyboard and store at (A1)

HEX         ADD.B       #1,D3           ; add 1 to D3 - use to keep track of whether on first or second user input
            MOVE.B      #8,D4           ; set D4 to 7
            
LETTER      CMP.B       #0,D4           ; use D4 to keep track of where in input you're at
            BEQ         CHECK           ; branch to checking validity of input if entire input taken
            SUBI.B      #1,D4           ; subtract 1 from D4 to keep track of number of loops
            MOVE.B      (A1)+,D1        ; move next part of A1 to D1
            CMP.B       #$39,D1         ; compare $39 to D1 to see if 1-9
            BGT         HEXA            ; if greater branch to hexa
            ADD.B       #$D0,D1         ; add #$D0 to D1 to cancel out 30
            BRA         COMBINE         ; skip to combining step
            
HEXA        CMP.B       #$42,D1         ; compare 42 to D1
            BGE         HEXB
            MOVE.B      #$0A,D1         ; replace with 0A
            BRA         COMBINE         ; skip to combining step
            
HEXB        CMP.B       #$43,D1         ; compare 43 to D1
            BGE         HEXC
            MOVE.B      #$0B,D1         ; replace with 0B
            BRA         COMBINE
            
HEXC        CMP.B       #$44,D1         ; compare 44 to D1
            BGE         HEXD
            MOVE.B      #$0C,D1         ; replace with 0C
            BRA         COMBINE
            
HEXD        CMP.B       #$45,D1         ; compare 45 to D1
            BGE         HEXE
            MOVE.B      #$0D,D1         ;replace with 0D
            BRA         COMBINE
            
HEXE        CMP.B       #$46,D1         ; compare 46 to D1
            BGE         HEXF
            MOVE.B      #$0E,D1         ; replace with 0E
            BRA         COMBINE
            
HEXF        MOVE.B      #$0F,D1         ; replace with 0F
            BRA         COMBINE         ; branch back to beginning of loop to check if done
            
COMBINE     ASL.L       #4,D2           ; move D2 2 digits to the left
            ADD.B       D1,D2           ; add byte of data from D1 to D2
            
            BRA         LETTER          ; branch back to beginning of loop
            
ENDCHECK    CMP.B       #1,D3           ; compare D3 to 1 to see which number we're on
            BLE         PRESECNUM       ; branch back to get second user input
            MOVE.L      D2,END          ; move converted input to END
            BRA         NEXT            ; branch to next when done
            
CHECK       ; code to check for bad input should go here
            BRA         ENDCHECK        ; if okay, go back to ENDCHECK
            ; else should print specific error message if bad
            CMP.B       #1,D3           ; compare D1 to 1 to see which number we're on
            BEQ         FIRSTNUM        ; then go back to asking for first number if on that one
            BRA         SECONDNUM       ; or go back to asking for second number if on that one
            
NEXT        ; add JSR jump table subroutine here for first four bits of each
            ; decode the rest from there
            ; print the instructions

CR          EQU         $0D             ; carriage return
LF          EQU         $0A             ; line feed
BEGIN       DS.L        1               ; reserve long for starting location
END         DS.L        1               ; reserve long for ending location 
INTRO       DC.B        'Welcome to the MysteryHuskies 68k Disassembler!',CR,LF
            DC.B        'Please enter your desired starting location in 8 digit, upper-case hexadecimal: ',CR,LF,0
INTRO2      DC.B        'Thank you. Now please enter your desired ending location in 8 digit, upper-case hexadecimal: ',CR,LF,0
; should add in some different error messages to display for various types of bad addresses

            END         START           ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
