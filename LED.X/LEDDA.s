PROCESSOR 16F887
#include <xc.inc>

    ;CONFIG word1
CONFIG FOSC=INTRC_NOCLKOUT
CONFIG WDTE=OFF
CONFIG PWRTE=ON
CONFIG MCLRE=OFF
CONFIG CP=OFF
CONFIG CPD=OFF
CONFIG BOREN=OFF
CONFIG IESO=OFF
CONFIG FCMEN=ON
CONFIG DEBUG=ON

    ;CONFIG word2
CONFIG BOR4V=BOR40V
CONFIG WRT=OFF

PSECT udata
registro3:
    DS 1
registro2:
    DS 1
registro1:
    DS 1

PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL LED
goto LED

PSECT code
back:    
MOVLW    50       
MOVWF    registro3         

ext:   
MOVLW     50        
MOVWF    registro2       
mitad:    
MOVLW    65    
MOVWF    registro1         

inte:    
DECFSZ   registro1,1     
GOTO     inte                
DECFSZ   registro2,1       
GOTO        mitad         
DECFSZ   registro3,1       
GOTO        ext            
RETURN                     
    
LED:
    BANKSEL ANSEL
    clrf ANSEL
    BANKSEL PORTA
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    BANKSEL PORTA
    
    loop1:
    rrf PORTA,1
    call back
    btfss PORTA,0
    goto loop1
    loop2:
    rlf PORTA,1
    call back
    btfss PORTA,7
    goto loop2
    goto loop1
    END


