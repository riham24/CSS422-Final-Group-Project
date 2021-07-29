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
            ; conversion code loop should go here - save number in D2 as you go
            BRA         CHECK           ; branch to part of code that checks for valid input
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
BEGIN       DS.L        $0              ; reserve long for starting location
END         DS.L        $0              ; reserve long for ending location 
INTRO       DC.B        'Welcome to the MysteryHuskies 68k Disassembler!',CR,LF
            DC.B        'Please enter your desired starting location in hexadecimal: ',CR,LF,0
INTRO2      DC.B        'Thank you. Now please enter your desired ending location in hexadecimal: ',CR,LF,0
; should add in some different error messages to display for various types of bad addresses

            END         START           ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
