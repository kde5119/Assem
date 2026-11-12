
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
    msg1 BYTE "Enter 5 numbers: ", 0
    inputFmt BYTE "%d", 0
    sumFmt BYTE 13, 10, "Sum = %d", 0
    avgFmt BYTE 13, 10, "Average = %d", 0

    num DWORD 5 DUP(0)
    sum DWORD 0
    avg DWORD 0

.code
main PROC

    mov ecx, 5
    mov esi, OFFSET num

    invoke printf, ADDR msg1

INPUT:
    invoke scanf, ADDR inputFmt, esi

    mov eax, [esi]
    add sum, eax

    add esi, 4
    loop INPUT

    mov eax, sum
    cdq
    mov ebx, 5
    idiv ebx

    mov avg, eax

    invoke printf, ADDR sumFmt, sum
    invoke printf, ADDR avgFmt, avg

    invoke ExitProcess, 0

main ENDP
END main
