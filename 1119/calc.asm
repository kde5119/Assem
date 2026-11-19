.386
.model flat, c
.stack 4096

includelib kernel32.lib
includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

EXTERN printf:PROC
EXTERN scanf:PROC

.data
    promptMsg   BYTE "두 개의 정수를 입력하세요 (예: 20 6): ", 0
    scanFmt     BYTE "%d %d", 0
    
    addMsg      BYTE 10, "[덧셈] %d + %d = %d", 10, 0
    subMsg      BYTE 10, "[뺄셈] %d - %d = %d", 10, 0
    mulMsg      BYTE 10, "[곱셈] %d * %d = %d", 10, 0
    divMsg      BYTE 10, "[나눗셈] %d / %d = 몫: %d, 나머지: %d", 10, 0
    
    regMsg      BYTE "   -> 레지스터 상태 | EAX(AX): %d (0x%08X) | EBX(BX): %d (0x%08X) | ECX(CX): %d (0x%08X) | EDX(DX): %d (0x%08X)", 10, 0

    num1        DWORD ?
    num2        DWORD ?
    resVal      DWORD ?
    remVal      DWORD ?

    ; 연산 직후의 레지스터 값을 보관할 변수
    saveEax     DWORD ?
    saveEbx     DWORD ?
    saveEcx     DWORD ?
    saveEdx     DWORD ?

.code
; ---------------------------------------------------------
; 1단계: 연산 직후의 EAX, EBX, ECX, EDX 값을 메모리에 백업
; ---------------------------------------------------------
SaveRegisters PROC
    mov saveEax, eax
    mov saveEbx, ebx
    mov saveEcx, ecx
    mov saveEdx, edx
    ret
SaveRegisters ENDP

; ---------------------------------------------------------
; 2단계: 백업해 둔 레지스터 값을 출력
; ---------------------------------------------------------
PrintSavedRegisters PROC
    push saveEdx
    push saveEdx
    push saveEcx
    push saveEcx
    push saveEbx
    push saveEbx
    push saveEax
    push saveEax
    push OFFSET regMsg
    call printf
    add esp, 36
    ret
PrintSavedRegisters ENDP

; ---------------------------------------------------------
; 메인 프로시저
; ---------------------------------------------------------
main PROC
    push OFFSET promptMsg
    call printf
    add esp, 4

    push OFFSET num2
    push OFFSET num1
    push OFFSET scanFmt
    call scanf
    add esp, 12

    ; =========================================================
    ; 1. 덧셈 (결과 출력 -> 레지스터 출력)
    ; =========================================================
    mov eax, num1
    mov ebx, num2
    xor ecx, ecx
    xor edx, edx
    add eax, ebx
    mov resVal, eax

    call SaveRegisters          ; 1) 연산 직후 레지스터 값 먼저 저장

    push resVal                 ; 2) 덧셈 결과 먼저 출력
    push num2
    push num1
    push OFFSET addMsg
    call printf
    add esp, 16

    call PrintSavedRegisters    ; 3) 저장해 둔 레지스터 상태 출력

    ; =========================================================
    ; 2. 뺄셈 (결과 출력 -> 레지스터 출력)
    ; =========================================================
    mov eax, num1
    mov ebx, num2
    xor ecx, ecx
    xor edx, edx
    sub eax, ebx
    mov resVal, eax

    call SaveRegisters          ; 1) 백업

    push resVal                 ; 2) 뺄셈 결과 출력
    push num2
    push num1
    push OFFSET subMsg
    call printf
    add esp, 16

    call PrintSavedRegisters    ; 3) 레지스터 출력

    ; =========================================================
    ; 3. 곱셈 (결과 출력 -> 레지스터 출력)
    ; =========================================================
    mov eax, num1
    mov ebx, num2
    xor ecx, ecx
    xor edx, edx
    imul ebx
    mov resVal, eax

    call SaveRegisters          ; 1) 백업

    push resVal                 ; 2) 곱셈 결과 출력
    push num2
    push num1
    push OFFSET mulMsg
    call printf
    add esp, 16

    call PrintSavedRegisters    ; 3) 레지스터 출력

    ; =========================================================
    ; 4. 나눗셈 (결과 출력 -> 레지스터 출력)
    ; =========================================================
    mov eax, num1
    mov ebx, num2
    xor ecx, ecx
    cdq
    idiv ebx
    mov resVal, eax
    mov remVal, edx

    call SaveRegisters          ; 1) 백업

    push remVal                 ; 2) 나눗셈 결과 출력
    push resVal
    push num2
    push num1
    push OFFSET divMsg
    call printf
    add esp, 20

    call PrintSavedRegisters    ; 3) 레지스터 출력

    xor eax, eax
    ret
main ENDP

END
