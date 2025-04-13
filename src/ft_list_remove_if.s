global  ft_list_remove_if

extern _free

section .text
.remove_if:
    mov r8, rdi
    mov rdi, [r8]
    call rdx
    test rax, rax
    jnz .return
    test rcx, rcx
    jz .free_node
.free_data:
    call rcx
.free_node:
    mov rdi, r8
    call _free
    xor rax, rax
.return:
    ret

ft_list_remove_if:
    test rdi, rdi
    jz .abort
    test rsi, rsi
    jz .abort
    test rdx, rdx
    jz .abort

    mov r8, [rdi]
    test r8, r8
    jz .return
.loop:
    mov r9, [r8 + 8]
    test r9, r9
    jz .head
    mov r10, [r9 + 8]
    push rdi
    push r8
    mov rdi, r9
    call .remove_if
    pop r8
    pop rdi
    test rax, rax
    jz .loop
    mov r8, r9
    jmp .loop
.head:
    mov 
    push rdi
    mov 
.return:
    ret

.abort:
    mov r8, 14
    call __errno_location wrt ..plt
    mov [rax], r8
    ret

