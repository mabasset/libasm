global  ft_list_push_front

extern  __errno_location, malloc

default rel

section .data:
    size db 16

section .text
ft_list_push_front:
    test rdi, rdi
    jz .bad_addr
    test rsi, rsi
    jz .bad_addr

    push rdi
    push rsi
    movzx rdi, word [size]
    call malloc wrt ..plt
    pop rsi
    pop rdi
    test rax, rax
    jz .out_of_memory
    mov [rax], rsi
    mov r8, [rdi]
    mov [rax + 8], r8
    mov [rdi], rax
    ret

.bad_addr:
    mov r8, 14
    jmp .abort
.out_of_memory:
    mov r8, 12
.abort:
    call __errno_location wrt ..plt
    mov [rax], r8
    xor rax, rax
    ret
