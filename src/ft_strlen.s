global ft_strlen

extern __errno_location

section .text
ft_strlen:
    test rdi, rdi
    jz .abort
    xor rax, rax
.count_loop:
    cmp byte [rdi + rax], 0
    je .end
    inc rax
    jmp .count_loop
.end:
    ret

.abort:
    call __errno_location wrt ..plt
    mov dword [rax], 14
    xor rax, rax
    ret