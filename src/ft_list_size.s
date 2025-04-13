global  ft_list_size

section .text
ft_list_size:
    xor rax, rax
.loop:
    test rdi, rdi
    je .return
    mov rdi, [rdi + 8]
    inc rax
    jmp .loop
.return:
    ret