global  ft_list_remove_if

extern free, __errno_location

section .text
call_with_alignment:
    push rbp
    mov rbp, rsp
    and rsp, -16
    call rdx
    mov rsp, rbp
    pop rbp
    ret

remove_if:
    mov r14, [r13 + 8]
    mov rdi, [r13]
    mov rsi, [rbp - 16]
    mov rdx, [rbp - 24]
    call call_with_alignment
    test rax, rax
    jnz .return
    mov rdx, [rbp - 32]
    test rdx, rdx
    jz .free_node
    mov rdi, [r13]
    call call_with_alignment
.free_node:
    mov rdi, r13
    call free wrt ..plt
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
    push r12
    push r13
    push r14
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov r12, [rdi]
    test r12, r12
    jz .return
.loop:
    mov r13, [r12 + 8]
    test r13, r13
    jz .head
    call remove_if
    test rax, rax
    jz .remove
    mov r12, r13
    jmp .loop
.remove:
    mov [r12 + 8], r14
    jmp .loop
.head:
    mov r12, [rbp - 8]
    mov r13, [r12]
    call remove_if
    test rax, rax
    jnz .return
    mov [r12], r14
.return:
    mov rsp, rbp
    pop rbp
    pop r14
    pop r13
    pop r12
    ret

.abort:
    push 14
    call __errno_location wrt ..plt
    pop qword [rax]
    ret
