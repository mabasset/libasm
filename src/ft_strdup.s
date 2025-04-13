global ft_strdup

extern __errno_location, ft_strlen, ft_strcpy, malloc

section .text
ft_strdup:
    test rdi, rdi
    jz .bad_addr
    call ft_strlen
    push rdi
    lea rdi, [rax + 1]
    call malloc wrt ..plt
    pop rsi
    test rax, rax
    jz .out_of_memory
    mov rdi, rax
    call ft_strcpy
    ret

.bad_addr:
    push 14
    jmp .abort
.out_of_memory:
    push 12
.abort:
    call __errno_location wrt ..plt
    pop qword [rax]
    xor rax, rax
    ret
