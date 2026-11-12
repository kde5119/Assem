.386
.model flat, c
.stack 4096

includelib kernel32.lib
includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

EXTERN printf:PROC

.data
    message db "2025664005 김동은", 10, 0

.code
main PROC
    ; printf("2025664005 김동은\n") 호출
    push OFFSET message
    call printf
    add esp, 4

    ; 프로그램 정상 종료
    xor eax, eax
    ret
main ENDP

END
