global ft_write

extern __errno_location

section .text
ft_write:
    mov rax, 1
    syscall
    test rax, rax
    js .abort
    ret

.abort:
    neg rax
    mov r8, rax
    call __errno_location wrt ..plt
    mov [rax], r8
    mov rax, -1
    ret