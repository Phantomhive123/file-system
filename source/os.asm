; haribote-os
; TAB=4
struc   file
.name      RESB    1
.type       RESB    1
.no       RESB    1
.next       RESB    1
.data RESB 60
.size:
endstruc


		ORG		0x8200			;
        segment .bss
iArr: RESB file.size * 8
iArr_l: EQU ($-iArr)/file.size

segment .text
;MOV AL,0x13;
 ;       MOV AH,0x00
  ;              INT 0x10

mov cx, iArr_l
mov si, iArr

L1:
mov al, 'a'
mov [si+file.name], al
mov al, 'b'
mov [si+file.type], al
mov al, 'c'
mov [si+file.no], al
mov al, 0x02
mov [si+file.next], al
mov al, 'c'
;mov [si+file.data], al
add  si, file.size 
loop L1
    

int 0x11
;mov al, ah
;add al ,0x30
mov ah, 0x0e
int 0x10

mov si, 0

retry:
mov al, '7'
MOV AH,0x0e
int 0x10


         mov ax, 0x0820
mov es, ax
mov ch, 0
mov dh, 0
mov cl, 2

mov ah, 0x03
mov al, 1
mov bx, 0
mov dl, 0x01
int 0x13
jnc next


add si, 1
cmp si, 5


jae error

MOV AH,0x00
MOV DL,0x01; A驱动器
INT 0x13; 重置驱动器

jmp retry

error:
mov al, ah
add al ,0x30
MOV AH,0x0e
int 0x10

next:

;mov ax, es
;add ax, 0x0020
;mov es, ax
;mov ch, 0
;mov dh, 0
;mov cl, 5

;mov ah, 0x02
;mov al, 1
;mov bx, 0
;mov dl, 0x00
;int 0x13


mov bx, es
mov al, [0x8200]
MOV AH,0x0e
int 0x10
mov al, [0x8400]
MOV AH,0x0e
int 0x10

mov al, [0x8600]
MOV AH,0x0e
int 0x10





jmp short boot







bootmesg db "Our OS boot sector loading ......"

print_mesg : 
mov ah,0x13 
mov al,0x00 
mov bx,0x0007 
mov cx,0x20 
mov dx,0x0000 
int 0x10 
ret 

get_key :
mov ah,0x00
int 0x16 
MOV AH,0x0e
int 0x10
;jmp get_key
ret

clrscr : 
mov ax,0x0600 
mov cx,0x0000 
mov dx,0x174f 
mov bh,0
int 0x10
ret 

boot:
    
;    mov bp,bootmesg
;    call print_mesg
;    call get_key
MOV AH,0x0e
    mov al, 'H'
    INT 0x10
    mov al, 'U'
    INT 0x10
    mov al, 'S'
    INT 0x10
    mov al, 'T'
    INT 0x10
    call get_key


mov ah, 0x24
mov al, 1
int 15h


fin:
		HLT
		JMP		fin
