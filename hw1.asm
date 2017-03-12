PAGE 55,132
.386

STACK_SEG SEGMENT STACK USE16
		DB 100 DUP(?)
STACK_SEG ENDS

DATA_SEG SEGMENT 'DATA' USE16

MSG DB 'HOMEWORK-LOWERCASE TO UPPERCASE',0DH,0AH
		DB 'ENTER A STRING FROM KEYBOARD: $'
MSG2 DB 0DH,0AH,'CONVERTED STRING IS: $'
STR1 DB 255 dup('$')
NEWLINE DB 0DH,0AH,'$'
DATA_SEG ENDS

CODE_SEG SEGMENT PARA 'CODE' PUBLIC USE16

ASSUME CS:CODE_SEG, DS:DATA_SEG, SS:STACK_SEG

BEGIN:
          MOV AX,DATA_SEG
          MOV DS,AX

          LEA DX,MSG
          MOV AH,09H	;msg ekrana yaz
          INT 21H

          LEA SI,STR1
          MOV AH,01H	;ekrandan oku
		  
READ:
          INT 21H
          MOV BL,AL

          CMP AL,0DH
          JE  DISPLAY
		  
		  CMP AL,'a'
		  JL CONVERT2
		
		  CMP AL,'Z'
		  JG CONVERT

CONVERT2:
		  
          MOV [SI],AL
          INC SI
		  
		  CMP BL,0DH
          JMP READ
		  
CONVERT:
		  SUB AL,20H
          MOV [SI],AL
          INC SI
		  
		  CMP BL,0DH
          JMP READ
  
DISPLAY:

          MOV AL,'$'
          MOV [SI],AL

          LEA DX,MSG2
          MOV AH,09H
          INT 21H


          LEA DX,STR1
          MOV AH,09H
          INT 21H

          MOV AH,4CH
          INT 21H
          .EXIT


CODE_SEG ENDS
END BEGIN 
