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
    promptMsg   BYTE "정수 5개를 입력하세요 (예: 10 20 30 40 50): ", 0
    scanFmt     BYTE "%d %d %d %d %d", 0
    resultMsg   BYTE "입력한 5개 수의 평균(정수 몫): %d", 10, 0
    
    num1        DWORD ?
    num2        DWORD ?
    num3        DWORD ?
    num4        DWORD ?
    num5        DWORD ?
    avg         DWORD ?

.code
main PROC
    ; 1. 안내 메시지 출력
    push OFFSET promptMsg
    call printf
    add esp, 4

    ; 2. 5개의 정수 입력받기
    push OFFSET num5
    push OFFSET num4
    push OFFSET num3
    push OFFSET num2
    push OFFSET num1
    push OFFSET scanFmt
    call scanf
    add esp, 24

    ; 3. 5개의 수 합산하기
    mov eax, num1
    add eax, num2
    add eax, num3
    add eax, num4
    add eax, num5

    ; 4. 평균 계산하기
    cdq
    mov ebx, 5
    idiv ebx
    mov avg, eax

    ; 5. 결과 출력
    push avg
    push OFFSET resultMsg
    call printf
    add esp, 8

    ; 6. C 런타임으로 정상 복귀하며 프로그램 종료 (반환값 0)
    xor eax, eax
    ret
main ENDP

END
