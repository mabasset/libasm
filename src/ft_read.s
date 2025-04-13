global ft_read

extern __errno_location

section .text
ft_read:
    xor rax, rax
    syscall
    test rax, rax
    js .abort
    ret

.abort:
    neg rax
    push rax
    call __errno_location wrt ..plt
    pop qword [rax]
    mov rax, -1
    ret

