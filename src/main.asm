org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;
; Prints a string to the screen
; Params
;   -   ds:si points to the string
puts:
    ; save the registers to modify in the stack
    push si
    push ax
    push bx

.loop:
    lodsb              ; loads next character in al and the increases si
    or al, al           ; verify if the next character is null, if so sets the zero flag register
    jz .done            ; jumps if zero flag is set

    mov ah, 0x0e        ; Calls BIOS interrupt
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret


main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00

    ; print message
    mov si, msg_hello
    call puts
    
    hlt

.halt:
    jmp .halt


msg_hello: db 'Hey There!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h