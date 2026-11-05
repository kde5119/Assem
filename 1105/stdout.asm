; stdout.asm
; 32-bit x86 MASM32 console example

include \masm32\include\masm32rt.inc

.data
    message db "2025664005 김동은", 0

.code
start:
    invoke StdOut, addr message
    invoke ExitProcess, 0

end start
