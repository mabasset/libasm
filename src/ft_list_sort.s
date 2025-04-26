global  ft_list_sort

extern __errno_location

default rel

section .data
sorted db 0

section .bss
compare: resb 8

section .text
call_with_alignment:
    push rbp
    mov rbp, rsp
    and rsp, -16
    call rdx
    mov rsp, rbp
    pop rbp
    ret

ft_list_sort:
    test rdi, rdi
    jz .abort
    test rsi, rsi
    jz .abort
    push rbx
    push r12
    push r13
    push r14
    mov [compare], rsi
    mov rbx, rdi
.outer_loop:
    cmp byte [sorted], 1
    je .return
    mov byte [sorted], 1
    mov r12, 0
    mov r13, [rbx]
.inner_loop:
    test r13, r13
    jz .outer_loop
    mov r14, [r13 + 8]
    test r14, r14
    jz .outer_loop
    mov rdi, [r13]
    mov rsi, [r14]
    mov rdx, [compare]
    call call_with_alignment
    cmp eax, 0
    jle .continue
    mov byte [sorted], 0
    mov r8, [r14 + 8]
    mov [r13 + 8], r8
    mov [r14 + 8], r13
    mov r13, r14
    test r12, r12
    jz .head
    mov [r12 + 8], r13
    jmp .continue
.head:
    mov [rbx], r13
.continue:
    mov r12, r13
    mov r13, [r13 + 8]
    jmp .inner_loop
.return:
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

.abort:
    push 14
    call __errno_location wrt ..plt
    pop qword [rax]
    ret