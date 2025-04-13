global ft_strcmp

extern __errno_location

section .text
ft_strcmp:
    test rdi, rdi
    jz .abort
    test rsi, rsi
    jz .abort
.compare_loop:
    mov al, byte [rdi]
    mov cl, byte [rsi]
    sub al, cl
    test cl, cl
    jz .return
    inc rdi
    inc rsi
    test al, al
    jz .compare_loop
.return:
    movsx rax, al
    ret

.abort:
    call __errno_location wrt ..plt
    mov dword [rax], 14
    mov rax, -1
    ret