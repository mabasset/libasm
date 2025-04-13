global ft_strcpy

extern __errno_location

section .text
ft_strcpy:
    test rdi, rdi
    jz .abort
    test rsi, rsi
    jz .abort
    xor rcx, rcx
.loop:
    mov al, [rsi + rcx]
    mov [rdi + rcx], al
    inc rcx
    test al, al
    jnz .loop
    mov rax, rdi
    ret

.abort:
    call __errno_location wrt ..plt
    mov dword [rax], 14
    xor rax, rax
    ret