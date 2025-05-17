ORG 0
BITS 16
_start:              ;BIOS PARAMETER BLOCK
    jmp short start
    nop
    times 33 db 0

start:
    jmp 0x7C0:step2

 
     
step2:    
    cli
    mov ax,0x7C0
    mov ds,ax
    mov es,ax
    mov ax,0x00
    mov ss,ax
    mov sp,0x7c00
    sti

    mov ah,02h
    mov al,1
    mov ch,0
    mov cl,2
    mov dh,0
    mov bx,buffer
    int 0x13
    jc error

    mov si,buffer
    call print
    jmp $
error:
    mov si,errorMessage
    call print
    jmp $    

    
    
    jmp $

print:
    mov bx,0
.loop:    
    lodsb
    cmp al,0
    je .done
    call printChar
    jmp .loop

.done:
    ret

printChar:
    mov ah,0eh
    int 0x10
    ret
errorMessage: db 'Failed to load sector',0
times 510-($-$$) db 0
dw 0xAA55

buffer:







