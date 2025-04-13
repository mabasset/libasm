global ft_atoi_base

extern __errno_location

section .text
is_space:
    cmp rdi, ' '
    je .true
    cmp rdi, 9
    jl .false
    cmp rdi, 13
    jg .false
.true:
    mov rax, 1
    ret
.false:
    xor rax, rax
    ret

is_sign:
    cmp rdi, '+'
    je .true
    cmp rdi, '-'
    je .true
    xor rax, rax
    ret
.true:
    mov rax, 1
    ret

get_base_length:
    sub rsp, 256
    mov rcx, 256
    xor rax, rax
    mov rdi, rsp
    rep stosb
    xor rcx, rcx
.loop:
    movzx rdi, byte [rsi + rcx]
    test rdi, rdi
    jz .valid
    call is_sign
    test rax, rax
    jnz .invalid
    cmp byte [rsp + rdi], 1
    je .invalid
    mov byte [rsp + rdi], 1
    inc rcx
    jmp .loop
.invalid:
    xor rax, rax
    jmp .return
.valid:
    mov rax, rcx
.return:
    add rsp, 256
    ret

skip_spaces:
    mov r8, rdi
.loop:
    movzx rdi, byte [r8]
    call is_space
    test rax, rax
    jz .return
    inc r8
    jmp .loop
.return:
    mov rdi, r8
    ret

get_sign:
    mov rax, 1
    jmp .loop
.neg:
    neg rax
.inc:
    inc rdi
.loop:
    cmp byte [rdi], '-'
    je .neg
    cmp byte [rdi], '+'
    je .inc
    ret

get_index:
    xor rax, rax
.loop:
    movzx r8, byte [rsi + rax]
    test r8, r8
    jz .return
    cmp r8, rdi
    je .return
    inc rax
    jmp .loop
.return:
    ret

convert:
    mov r8, rdi
    mov r9, rdx
    xor rax, rax
.loop:
    movzx rdi, byte [r8]
    test rdi, rdi
    jz .return
    push rax
    push r8
    call get_index
    mov r10, rax
    pop r8
    pop rax
    cmp r10, r9
    jge .return
    mul r9
    add rax, r10
    inc r8
    jmp .loop
.return:
    ret

ft_atoi_base:
    test rdi, rdi
    jz .bad_addr
    test rsi, rsi
    jz .bad_addr

    call skip_spaces
    call get_sign
    mov r8, rax
    push rdi
    call get_base_length
    pop rdi
    cmp rax, 2
    jl .invalid_arg
    mov rdx, rax
    push r8
    call convert
    pop r8
    mul r8
    ret

.bad_addr:
    push 14
    jmp .abort
.invalid_arg:
    push 22
.abort:
    call __errno_location wrt ..plt
    pop qword [rax]
    xor rax, rax
    ret