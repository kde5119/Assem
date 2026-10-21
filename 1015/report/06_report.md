# Chapter 6: Conditional Processing

# 6.10 Review Questions and Exercises

## 6.10.1 Short Answer

**1.** What will be the value of BX after the following instructions execute?

```asm
mov bx,0FFFFh
and bx,6Bh
```

> 답: BX = 006Bh

**2.** What will be the value of BX after the following instructions execute?

```asm
mov bx,91BAh
and bx,92h
```

> 답: BX = 0092h

**3.** What will be the value of BX after the following instructions execute?

```asm
mov bx,0649Bh
or bx,3Ah
```

> 답:BX = 64BBh

**4.** What will be the value of BX after the following instructions execute?

```asm
mov bx,029D6h
xor bx,8181h
```

> 답: BX = A857h

**5.** What will be the value of EBX after the following instructions execute?

```asm
mov ebx,0AFAF649Bh
or ebx,3A219604h
```

> 답: EBX = BFAFF69Fh

**6.** What will be the value of RBX after the following instructions execute?

```asm
mov rbx,0AFAF649Bh
xor rbx,0FFFFFFFFh
```

> 답: RBX = FFFFFFFF50509B64h

**7.** In the following instruction sequence, show the resulting value of AL where indicated, in binary:

```asm
mov al,01101111b
and al,00101101b      ; a.

mov al,6Dh
and al,4Ah            ; b.

mov al,00001111b
or  al,61h            ; c.

mov al,94h
xor al,37h            ; d.
```

> 답:
> a. 00101101b
> b. 01001000b
> c. 01101111b
> d. 10100011b

**8.** In the following instruction sequence, show the resulting value of AL where indicated, in hexadecimal:

```asm
mov al,7Ah
not al                ; a.

mov al,3Dh
and al,74h            ; b.

mov al,9Bh
or  al,35h            ; c.

mov al,72h
xor al,0DCh           ; d.
```

> 답:
> a. 85h
> b. 34h
> c. BFh
> d. AEh

**9.** In the following instruction sequence, show the values of the Carry, Zero, and Sign flags where indicated:

```asm
mov al,00001111b
test al,00000010b     ; a. CF= ZF= SF=

mov al,00000110b
cmp al,00000101b      ; b. CF= ZF= SF=

mov al,00000101b
cmp al,00000111b      ; c. CF= ZF= SF=
```

> 답:
> a. CF=0, ZF=0, SF=0
> b. CF=0, ZF=0, SF=0
> c. CF=1, ZF=0, SF=1

**10.** Which conditional jump instruction executes a branch based on the contents of ECX?

> 답: ECX가 0일 때 점프하는 명령어는 JECXZ이다.

**11.** How are JA and JNBE affected by the Zero and Carry flags?

> 답: JA와 JNBE는 동의어이며, CF=0 및 ZF=0일 때 점프한다.

**12.** What will be the final value in EDX after this code executes?

```asm
    mov edx,1
    mov eax,7FFFh
    cmp eax,8000h
    jl L1
    mov edx,0
L1:
```

> 답: EDX = 1

**13.** What will be the final value in EDX after this code executes?

```asm
    mov edx,1
    mov eax,7FFFh
    cmp eax,8000h
    jb L1
    mov edx,0
L1:
```

> 답: EDX = 1

**14.** What will be the final value in EDX after this code executes?

```asm
    mov edx,1
    mov eax,7FFFh
    cmp eax,0FFFF8000h
    jl L2
    mov edx,0
L2:
```

> 답: EDX = 0

**15.** (True/False): The following code will jump to the label named Target.

```asm
mov eax,-30
cmp eax,-50
jg Target
```

> 답: 참.

**16.** (True/False): The following code will jump to the label named Target.

```asm
mov eax,-42
cmp eax,26
ja Target
```

> 답: 참.

**17.** What will be the value of RBX after the following instructions execute?

```asm
mov rbx,0FFFFFFFFFFFFFFFFh
and rbx,80h
```

> 답: RBX = 0000000000000080h

**18.** What will be the value of RBX after the following instructions execute?

```asm
mov rbx,0FFFFFFFFFFFFFFFFh
and rbx,808080h
```

> 답: RBX = 0000000000808080h

**19.** What will be the value of RBX after the following instructions execute?

```asm
mov rbx,0FFFFFFFFFFFFFFFFh
and rbx,80808080h
```

> 답: RBX = FFFFFFFF80808080h

---

## 6.10.2 Algorithm Workbench

**1.** Write a single instruction that converts an ASCII digit in AL to its corresponding binary value. If AL already contains a binary value (00h to 09h), leave it unchanged.

> 답:

```asm
and al,0Fh
```

**2.** Write instructions that calculate the parity of a 32-bit memory operand. Hint: Use the formula presented earlier in this section: B0 XOR B1 XOR B2 XOR B3.

> 답:

```asm
.data
mem DWORD 12345678h
.code
mov al,BYTE PTR mem          ; B0
xor al,BYTE PTR [mem+1]      ; B0 XOR B1
xor al,BYTE PTR [mem+2]      ; ... XOR B2
xor al,BYTE PTR [mem+3]      ; ... XOR B3
; 마지막 XOR 직후 PF=1 -> 짝수 패리티, PF=0 -> 홀수 패리티
```

**3.** Given two bit-mapped sets named SetX and SetY, write a sequence of instructions that generate a bit string in EAX that represents members in SetX that are not members of SetY.

> 답:

```asm
mov eax,SetY
not eax            ; SetY의 여집합
and eax,SetX       ; SetX ∩ (SetY의 여집합) = SetX − SetY
```

**4.** Write instructions that jump to label L1 when the unsigned integer in DX is less than or equal to the integer in CX.

> 답:

```asm
cmp dx,cx
jbe L1
```

**5.** Write instructions that jump to label L2 when the signed integer in AX is greater than the integer in CX.

> 답:

```asm
cmp ax,cx
jg L2
```

**6.** Write instructions that first clear bits 0 and 1 in AL. Then, if the destination operand is equal to zero, the code should jump to label L3. Otherwise, it should jump to label L4.

> 답:

```asm
and al,11111100b    ; 비트 0, 1 클리어 (ZF도 함께 설정됨)
jz  L3              ; 결과 = 0 이면 L3
jmp L4              ; 아니면 L4
```

**7.** Implement the following pseudocode in assembly language. Use short-circuit evaluation and assume that val1 and X are 32-bit variables.

```text
if( val1 > ecx ) AND ( ecx > edx )
    X = 1
else
    X = 2;
```

> 답:

```asm
    cmp val1,ecx
    jbe L_else        ; 첫 조건이 거짓 -> 두 번째는 검사하지 않음
    cmp ecx,edx
    jbe L_else
    mov X,1
    jmp L_next
L_else:
    mov X,2
L_next:
```

**8.** Implement the following pseudocode in assembly language. Use short-circuit evaluation and assume that X is a 32-bit variable.

```text
if( ebx > ecx ) OR ( ebx > val1 )
    X = 1
else
    X = 2
```

> 답:

```asm
    cmp ebx,ecx
    ja  L_then        ; 첫 조건이 참 → 바로 then
    cmp ebx,val1
    ja  L_then
    mov X,2           ; 둘 다 거짓
    jmp L_next
L_then:
    mov X,1
L_next:
```

**9.** Implement the following pseudocode in assembly language. Use short-circuit evaluation and assume that X is a 32-bit variable.

```text
if( ebx > ecx AND ebx > edx) OR ( edx > eax )
    X = 1
else
    X = 2
```

> 답:

```asm
    cmp ebx,ecx
    jbe L_or          ; AND의 첫 조건 거짓 → OR의 오른쪽 검사로
    cmp ebx,edx
    ja  L_then        ; ebx>ecx AND ebx>edx 참 → then
L_or:
    cmp edx,eax
    ja  L_then        ; edx > eax 참 → then
    mov X,2
    jmp L_next
L_then:
    mov X,1
L_next:
```

**10.** Implement the following pseudocode in assembly language. Use short-circuit evaluation and assume that A, B, and N are 32-bit signed integers.

```text
while N > 0
    if N != 3 AND (N < A OR N > B)
        N = N - 2
    else
        N = N - 1
end whle
```

> 답:

```asm
L_while:
    cmp N,0
    jle L_endw          ; N <= 0 이면 종료

    cmp N,3
    je  L_else          ; N == 3 → AND가 거짓
    mov eax,N
    cmp eax,A
    jl  L_then          ; N < A → OR가 참
    cmp eax,B
    jg  L_then          ; N > B → OR가 참
    jmp L_else          ; 둘 다 거짓

L_then:
    sub N,2
    jmp L_while
L_else:
    dec N
    jmp L_while
L_endw:
```

---

# 6.11 Programming Exercises

## 6.11.1 Suggestions for Testing Your Code

We have a few suggestions on how you can test the code you write for the programming exercises in this chapter, and in future chapters.

- Always step through your program with a debugger the first time you test it. It’s so easy to forget a small detail, and the debugger lets you see exactly what’s going on.
- If the specifications call for a signed array, be sure to include some negative values.
- When a range of input values is specified, include test data that falls before, on, and after these boundaries.
- Create multiple test cases, using arrays of different lengths.
- When you’re writing a program that writes to an array, the Visual Studio debugger is the best tool for evaluating your program’s correctness. Use the debugger’s Memory window to display the array, choosing either hexadecimal or decimal representation.
- Immediately after calling the procedure you’re testing, call it a second time to verify that the procedure has preserved all registers. Here’s an example:

  ```asm
  mov esi,OFFSET array
  mov ecx,count
  call CalcSum ; returns sum in EAX
  call CalcSum ; call second time to see if registers are preserved
  ```

  Usually there is a single return value in EAX, which of course, cannot be preserved. For that reason, you usually should not use EAX as an input parameter.

- If you’re planning to pass more than one array to a procedure, make sure you do not refer to the array by name inside the procedure. Instead, set ESI or EDI to the array’s offset before calling your procedure. That means you will be using indirect addressing (such as [esi] or [edi]) inside the procedure.
- If you need to create a variable for use only inside the procedure, you can use the .data directive before the variable, and then follow it with the .code directive. Here’s an example:

  ```asm
  MyCoolProcedure PROC
  .data
  sum SDWORD ?
  .code
      mov sum,0
      (etc.)
  ```

  The variable will still be publicly visible, unlike local variables in languages like C++ or Java. But when you declare it inside a procedure, you’re making it obvious that you do not plan to use it anywhere else. Of course, you must use a runtime instruction to initialize variables used inside a procedure, because you will call this procedure more than once. You don’t want it to have any leftover value the second time the procedure is called.

---

## 6.11.2 Exercise Descriptions

### ★ 1. Filling an Array

Create a procedure that fills an array of doublewords with N random integers, making sure the values fall within the range j...k, inclusive. When calling the procedure, pass a pointer to the array that will hold the data, pass N, and pass the values of j and k. Preserve all register values between calls to the procedure. Write a test program that calls the procedure twice, using different values for j and k. Verify your results using a debugger.

> 답:

```asm
INCLUDE Irvine32.inc

.data
array1 DWORD 20 DUP(?)
array2 DWORD 15 DUP(?)

.code
main PROC
    call Randomize

    mov esi,OFFSET array1     ; 배열 포인터
    mov ecx,LENGTHOF array1   ; N
    mov ebx,-20               ; j
    mov edx,20                ; k
    call FillArray

    mov esi,OFFSET array2
    mov ecx,LENGTHOF array2
    mov ebx,100
    mov edx,200
    call FillArray
    exit
main ENDP

;---------------------------------------------------
; FillArray
; 입력: ESI = 배열 주소, ECX = N, EBX = j(최소), EDX = k(최대)
; 출력: 배열이 j~k 범위의 난수로 채워짐 (모든 레지스터 보존)
;---------------------------------------------------
FillArray PROC
    pushad
    mov edi,edx
    sub edi,ebx
    inc edi                  ; EDI = k - j + 1 (범위 크기)
    jecxz FillDone           ; N = 0이면 바로 반환
L1:
    mov eax,edi
    call RandomRange         ; EAX = 0 ~ (k-j)
    add eax,ebx              ; EAX = j ~ k
    mov [esi],eax
    add esi,4
    loop L1
FillDone:
    popad
    ret
FillArray ENDP
END main
```

### ★★ 2. Summing Array Elements in a Range

Create a procedure that returns the sum of all array elements falling within the range j...k (inclusive). Write a test program that calls the procedure twice, passing a pointer to a signed doubleword array, the size of the array, and the values of j and k. Return the sum in the EAX register, and preserve all other register values between calls to the procedure.

> 답:

```asm
INCLUDE Irvine32.inc

.data
arr SDWORD 10,-5,30,45,-20,7,100,-1,25,60

.code
main PROC
    mov esi,OFFSET arr
    mov ecx,LENGTHOF arr
    mov ebx,0                 ; j
    mov edx,50                ; k
    call SumInRange           ; EAX = 117 (10+30+45+7+25)
    call WriteInt
    call Crlf

    mov esi,OFFSET arr
    mov ecx,LENGTHOF arr
    mov ebx,-10
    mov edx,10
    call SumInRange           ; EAX = 11 (10-5+7-1)
    call WriteInt
    call Crlf
    exit
main ENDP

;---------------------------------------------------
; SumInRange
; 입력: ESI = 배열 주소, ECX = 크기, EBX = j, EDX = k
; 출력: EAX = j~k 범위 원소의 합 (EAX 외 레지스터 보존)
;---------------------------------------------------
SumInRange PROC
    push esi
    push ecx
    xor eax,eax
    jecxz Done               ; 크기가 0이면 바로 종료
L1:
    cmp [esi],ebx
    jl  Skip                 ; 원소 < j
    cmp [esi],edx
    jg  Skip                 ; 원소 > k
    add eax,[esi]
Skip:
    add esi,4
    loop L1
Done:
    pop ecx
    pop esi
    ret
SumInRange ENDP
END main
```

### ★★ 3. Test Score Evaluation

Create a procedure named CalcGrade that receives an integer value between 0 and 100, and returns a single capital letter in the AL register. Preserve all other register values between calls to the procedure. The letter returned by the procedure should be according to the following ranges:

| Score Range | Letter Grade |
| :---------: | :----------: |
|  90 to 100  |      A       |
|  80 to 89   |      B       |
|  70 to 79   |      C       |
|  60 to 69   |      D       |
|   0 to 59   |      F       |

Write a test program that generates 10 random integers between 50 and 100, inclusive. Each time an integer is generated, pass it to the CalcGrade procedure. You can test your program using a debugger, or if you prefer to use the book’s library, you can display each integer and its corresponding letter grade. (The Irvine32 library is required for this solution program because it uses the RandomRange procedure.)

> 답:

```asm
INCLUDE Irvine32.inc

.data
msgArrow BYTE " -> ",0

.code
main PROC
    call Randomize
    mov ecx,10
L1:
    mov eax,51
    call RandomRange          ; 0 ~ 50
    add eax,50                ; 50 ~ 100
    mov ebx,eax               ; EBX = 점수 (입력)
    call WriteDec             ; 점수 출력
    mov edx,OFFSET msgArrow
    call WriteString
    call CalcGrade            ; AL = 등급
    call WriteChar
    call Crlf
    loop L1
    exit
main ENDP

;---------------------------------------------------
; CalcGrade
; 입력: EBX = 점수 (0~100)
; 출력: AL = 등급 문자 (AL 외 레지스터 보존)
;---------------------------------------------------
CalcGrade PROC
    cmp ebx,90
    jae GradeA
    cmp ebx,80
    jae GradeB
    cmp ebx,70
    jae GradeC
    cmp ebx,60
    jae GradeD
    mov al,'F'
    ret
GradeA:
    mov al,'A'
    ret
GradeB:
    mov al,'B'
    ret
GradeC:
    mov al,'C'
    ret
GradeD:
    mov al,'D'
    ret
CalcGrade ENDP
END main
```

### ★★ 4. College Registration

Using the College Registration example from Section 6.7.3 as a starting point, do the following:

- Recode the logic using CMP and conditional jump instructions (instead of the .IF and .ELSEIF directives).
- Perform range checking on the credits value; it cannot be less than 1 or greater than 30. If an invalid entry is discovered, display an appropriate error message.
- Prompt the user for the grade average and credits values.
- Display a message that shows the outcome of the evaluation, such as “The student can register” or “The student cannot register”.

(The Irvine32 library is required for this solution program.)

> 답:

```asm
INCLUDE Irvine32.inc

.data
promptGrade BYTE "Enter grade average (e.g. 275 = 2.75): ",0
promptCred  BYTE "Enter credits (1-30): ",0
errMsg      BYTE "Error: credits must be between 1 and 30.",0
okMsg       BYTE "The student can register",0
noMsg       BYTE "The student cannot register",0
gradeAverage DWORD ?
credits      DWORD ?

.code
main PROC
    mov edx,OFFSET promptGrade
    call WriteString
    call ReadDec
    mov gradeAverage,eax

    mov edx,OFFSET promptCred
    call WriteString
    call ReadDec
    mov credits,eax

    ; ---- credits 범위 검사 (1 ~ 30) ----
    cmp credits,1
    jb  Invalid
    cmp credits,30
    ja  Invalid

    ; ---- .IF gradeAverage > 350 ----
    cmp gradeAverage,350
    ja  CanReg

    ; ---- .ELSEIF (gradeAverage > 250) && (credits <= 16) ----
    cmp gradeAverage,250
    jbe CheckCred12          ; 첫 조건 거짓 → 다음 ELSEIF
    cmp credits,16
    jbe CanReg

CheckCred12:
    ; ---- .ELSEIF credits <= 12 ----
    cmp credits,12
    jbe CanReg

    mov edx,OFFSET noMsg     ; 모두 거짓
    jmp Show
CanReg:
    mov edx,OFFSET okMsg
    jmp Show
Invalid:
    mov edx,OFFSET errMsg
Show:
    call WriteString
    call Crlf
    exit
main ENDP
END main
```

### ★★★ 5. Boolean Calculator (1)

Create a program that functions as a simple boolean calculator for 32-bit integers. It should display a menu that asks the user to make a selection from the following list:

1. x AND y
2. x OR y
3. NOT x
4. x XOR y
5. Exit program

When the user makes a choice, call a procedure that displays the name of the operation about to be performed. You must implement this procedure using the Table-Driven Selection technique, shown in Section 6.5.4. (You will implement the operations in Exercise 6.) (The Irvine32 library is required for this solution program.)

> 답:

```asm
INCLUDE Irvine32.inc

.data
menu BYTE 0Dh,0Ah,"===== Boolean Calculator =====",0Dh,0Ah,
          "1. x AND y",0Dh,0Ah,
          "2. x OR y",0Dh,0Ah,
          "3. NOT x",0Dh,0Ah,
          "4. x XOR y",0Dh,0Ah,
          "5. Exit program",0Dh,0Ah,
          "Select (1-5): ",0
msgInvalid BYTE "Invalid selection.",0
nameAND BYTE "Operation: x AND y",0
nameOR  BYTE "Operation: x OR y",0
nameNOT BYTE "Operation: NOT x",0
nameXOR BYTE "Operation: x XOR y",0

; ---- 점프(선택) 테이블: [선택 문자(1바이트)][프로시저 주소(4바이트)] ----
CaseTable BYTE '1'
          DWORD Process_AND
EntrySize = ($ - CaseTable)
          BYTE '2'
          DWORD Process_OR
          BYTE '3'
          DWORD Process_NOT
          BYTE '4'
          DWORD Process_XOR
NumberOfEntries = ($ - CaseTable) / EntrySize

.code
main PROC
L1:
    mov edx,OFFSET menu
    call WriteString
    call ReadChar            ; AL = 선택 문자
    call WriteChar           ; 에코
    call Crlf
    cmp al,'5'
    je  Quit
    call ChooseProcedure
    jmp L1
Quit:
    exit
main ENDP

;---------------------------------------------------
; ChooseProcedure  (테이블 기반 선택)
; 입력: AL = 선택 문자 ('1'~'4')
;---------------------------------------------------
ChooseProcedure PROC
    push ebx
    push ecx
    mov ebx,OFFSET CaseTable
    mov ecx,NumberOfEntries
L1:
    cmp al,[ebx]             ; 테이블의 선택 문자와 비교
    jne L2
    call NEAR PTR [ebx + 1]  ; 일치 → 저장된 프로시저 호출
    jmp L3
L2:
    add ebx,EntrySize        ; 다음 항목
    loop L1
    mov edx,OFFSET msgInvalid
    call WriteString
    call Crlf
L3:
    pop ecx
    pop ebx
    ret
ChooseProcedure ENDP

;---------------------------------------------------
; 연산 이름을 표시하는 프로시저들
;---------------------------------------------------
Process_AND PROC
    mov edx,OFFSET nameAND
    call WriteString
    call Crlf
    ; (연습 6에서 여기에 call AND_op 추가)
    ret
Process_AND ENDP

Process_OR PROC
    mov edx,OFFSET nameOR
    call WriteString
    call Crlf
    ret
Process_OR ENDP

Process_NOT PROC
    mov edx,OFFSET nameNOT
    call WriteString
    call Crlf
    ret
Process_NOT ENDP

Process_XOR PROC
    mov edx,OFFSET nameXOR
    call WriteString
    call Crlf
    ret
Process_XOR ENDP
END main
```

### ★★★ 6. Boolean Calculator (2)

Continue the solution program from Exercise 5 by implementing the following procedures:

- AND_op: Prompt the user for two hexadecimal integers. AND them together and display the result in hexadecimal.
- OR_op: Prompt the user for two hexadecimal integers. OR them together and display the result in hexadecimal.
- NOT_op: Prompt the user for a hexadecimal integer. NOT the integer and display the result in hexadecimal.
- XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR them together and display the result in hexadecimal.

(The Irvine32 library is required for this solution program.)

> 답: 연습 5의 프로그램을 확장한 전체 코드.

```asm
INCLUDE Irvine32.inc

.data
menu BYTE 0Dh,0Ah,"===== Boolean Calculator =====",0Dh,0Ah,
          "1. x AND y",0Dh,0Ah,
          "2. x OR y",0Dh,0Ah,
          "3. NOT x",0Dh,0Ah,
          "4. x XOR y",0Dh,0Ah,
          "5. Exit program",0Dh,0Ah,
          "Select (1-5): ",0
msgInvalid BYTE "Invalid selection.",0
nameAND BYTE "Operation: x AND y",0
nameOR  BYTE "Operation: x OR y",0
nameNOT BYTE "Operation: NOT x",0
nameXOR BYTE "Operation: x XOR y",0
promptX   BYTE "Enter hex integer x: ",0
promptY   BYTE "Enter hex integer y: ",0
msgResult BYTE "Result (hex): ",0

CaseTable BYTE '1'
          DWORD Process_AND
EntrySize = ($ - CaseTable)
          BYTE '2'
          DWORD Process_OR
          BYTE '3'
          DWORD Process_NOT
          BYTE '4'
          DWORD Process_XOR
NumberOfEntries = ($ - CaseTable) / EntrySize

.code
main PROC
L1:
    mov edx,OFFSET menu
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf
    cmp al,'5'
    je  Quit
    call ChooseProcedure
    jmp L1
Quit:
    exit
main ENDP

ChooseProcedure PROC
    push ebx
    push ecx
    mov ebx,OFFSET CaseTable
    mov ecx,NumberOfEntries
L1:
    cmp al,[ebx]
    jne L2
    call NEAR PTR [ebx + 1]
    jmp L3
L2:
    add ebx,EntrySize
    loop L1
    mov edx,OFFSET msgInvalid
    call WriteString
    call Crlf
L3:
    pop ecx
    pop ebx
    ret
ChooseProcedure ENDP

; ---- 이름 표시 + 연산 수행 ----
Process_AND PROC
    mov edx,OFFSET nameAND
    call WriteString
    call Crlf
    call AND_op
    ret
Process_AND ENDP

Process_OR PROC
    mov edx,OFFSET nameOR
    call WriteString
    call Crlf
    call OR_op
    ret
Process_OR ENDP

Process_NOT PROC
    mov edx,OFFSET nameNOT
    call WriteString
    call Crlf
    call NOT_op
    ret
Process_NOT ENDP

Process_XOR PROC
    mov edx,OFFSET nameXOR
    call WriteString
    call Crlf
    call XOR_op
    ret
Process_XOR ENDP

; ---- 연산 프로시저 ----
AND_op PROC
    mov edx,OFFSET promptX
    call WriteString
    call ReadHex             ; EAX = x
    mov ebx,eax
    mov edx,OFFSET promptY
    call WriteString
    call ReadHex             ; EAX = y
    and eax,ebx
    mov edx,OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
AND_op ENDP

OR_op PROC
    mov edx,OFFSET promptX
    call WriteString
    call ReadHex
    mov ebx,eax
    mov edx,OFFSET promptY
    call WriteString
    call ReadHex
    or  eax,ebx
    mov edx,OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
OR_op ENDP

NOT_op PROC
    mov edx,OFFSET promptX
    call WriteString
    call ReadHex
    not eax
    mov edx,OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
NOT_op ENDP

XOR_op PROC
    mov edx,OFFSET promptX
    call WriteString
    call ReadHex
    mov ebx,eax
    mov edx,OFFSET promptY
    call WriteString
    call ReadHex
    xor eax,ebx
    mov edx,OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
XOR_op ENDP
END main
```

### ★★ 7. Probabilities and Colors

Write a program that randomly chooses among three different colors for displaying text on the screen. Use a loop to display 20 lines of text, each with a randomly chosen color. The probabilities for each color are to be as follows: white = 30%, blue = 10%, green = 60%.

Suggestion: Generate a random integer between 0 and 9. If the resulting integer falls in the range 0 to 2 (inclusive), choose white. If the integer equals 3, choose blue. If the integer falls in the range 4 to 9 (inclusive), choose green. Test your program by running it ten times, each time observing whether the distribution of line colors appears to match the required probabilities. (The Irvine32 library is required for this solution program.)

> 답:

```asm
INCLUDE Irvine32.inc

.data
msg BYTE "Probabilities and Colors",0

.code
main PROC
    call Randomize
    mov ecx,20
L1:
    mov eax,10
    call RandomRange         ; 0 ~ 9
    cmp eax,2
    jbe UseWhite             ; 0~2 (30%)
    cmp eax,3
    je  UseBlue              ; 3   (10%)
    mov eax,green            ; 4~9 (60%)
    jmp SetColor
UseWhite:
    mov eax,white
    jmp SetColor
UseBlue:
    mov eax,blue
SetColor:
    call SetTextColor
    mov edx,OFFSET msg
    call WriteString
    call Crlf
    loop L1

    mov eax,lightGray        ; 기본 색으로 복원
    call SetTextColor
    exit
main ENDP
END main
```

### ★★★ 8. Message Encryption

Revise the encryption program in Section 6.3.4 in the following manner: Create an encryption key consisting of multiple characters. Use this key to encrypt and decrypt the plaintext by XOR-ing each character of the key against a corresponding byte in the message. Repeat the key as many times as necessary until all plain text bytes are translated. Suppose, for example, the key were equal to “ABXmv#7”. This is how the key would align with the plain text bytes:

```text
Plain text  T h i s       i s     a     P l a i n t e x t       m e s s a g e (etc.)
Key         A B X m v     # 7 A B X m v # 7 A B X m v # 7 A B X m v # 7
```

(The key repeats until it equals the length of the plain text...)

> 답:

```asm
INCLUDE Irvine32.inc

BUFMAX = 128

.data
key BYTE "ABXmv#7"
keySize = ($ - key)                  ; key 바로 다음 줄에 있어야 함
hexDigits BYTE "0123456789ABCDEF"
promptPlain BYTE "Enter the plain text: ",0
msgEnc BYTE "Cipher text: ",0
msgDec BYTE "Decrypted:   ",0
buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD ?

.code
main PROC
    mov edx,OFFSET promptPlain
    call WriteString
    call InputTheString          ; 평문 입력

    call TranslateBuffer         ; 암호화
    mov edx,OFFSET msgEnc
    call WriteString
    call DisplayCipherHex

    call TranslateBuffer         ; 복호화 (같은 키로 다시 XOR)
    mov edx,OFFSET msgDec
    call WriteString
    call DisplayMessage
    exit
main ENDP

InputTheString PROC
    pushad
    mov edx,OFFSET buffer
    mov ecx,BUFMAX
    call ReadString              ; EAX = 입력 문자 수
    mov bufSize,eax
    popad
    ret
InputTheString ENDP

DisplayMessage PROC
    pushad
    mov edx,OFFSET buffer
    call WriteString
    call Crlf
    popad
    ret
DisplayMessage ENDP

;---------------------------------------------------
; DisplayCipherHex : 암호화된 버퍼를 바이트별 16진수로 출력
;---------------------------------------------------
DisplayCipherHex PROC
    pushad
    mov esi,OFFSET buffer
    mov ecx,bufSize
    jecxz CipherDone
CipherLoop:
    mov bl,[esi]
    mov al,bl
    shr al,4
    and al,0Fh
    movzx edi,al
    mov al,hexDigits[edi]
    pushad
    call WriteChar
    popad

    mov al,bl
    and al,0Fh
    movzx edi,al
    mov al,hexDigits[edi]
    pushad
    call WriteChar
    popad

    mov al,' '
    pushad
    call WriteChar
    popad
    inc esi
    loop CipherLoop
CipherDone:
    call Crlf
    popad
    ret
DisplayCipherHex ENDP

;---------------------------------------------------
; TranslateBuffer : 키를 반복하며 버퍼의 각 바이트를 XOR
;---------------------------------------------------
TranslateBuffer PROC
    pushad
    mov ecx,bufSize
    jecxz Done
    mov esi,0                    ; 버퍼 인덱스
    mov edi,0                    ; 키 인덱스
L1:
    mov al,key[edi]
    xor buffer[esi],al
    inc esi
    inc edi
    cmp edi,keySize
    jb  L2
    mov edi,0                    ; 키 끝 → 처음으로
L2:
    loop L1
Done:
    popad
    ret
TranslateBuffer ENDP
END main
```

### ★★ 9. Validating a PIN

Banks use a Personal Identification Number (PIN) to uniquely identify each customer. Let us assume that our bank has a specified range of acceptable values for each digit in its customers’ 5-digit PINs. The table shown below contains the acceptable ranges, where digits are numbered from left to right in the PIN. Then we can see that the PIN 52413 is valid. But the PIN 43534 is invalid because the first digit is out of range. Similarly, 64535 is invalid because of its last digit.

| Digit Number | Range  |
| :----------: | :----: |
|      1       | 5 to 9 |
|      2       | 2 to 5 |
|      3       | 4 to 8 |
|      4       | 1 to 4 |
|      5       | 3 to 6 |

Your task is to create a procedure named Validate_PIN that receives a pointer to an array of byte containing a 5-digit PIN. Declare two arrays to hold the minimum and maximum range values, and use these arrays to validate each digit of the PIN that was passed to the procedure. If any digit is found to be outside its valid range, immediately return the digit’s position (between 1 and 5) in the EAX register. If the entire PIN is valid, return 0 in EAX. Preserve all other register values between calls to the procedure. Write a test program that calls Validate_PIN at least four times, using both valid and invalid byte arrays. By running the program in a debugger, verify that the return value in EAX after each procedure call is valid. Or, if you prefer to use the book’s library, you can display “Valid” or “Invalid” on the console after each procedure call.

> 참고: 원문 예시 `64535`는 표의 마지막 자리 범위(3 to 6)에 포함되므로 유효하다. 테스트 코드에서는 무효한 예시로 `64537`을 사용했다.

> 답:

```asm
INCLUDE Irvine32.inc

.data
minDigit BYTE 5,2,4,1,3
maxDigit BYTE 9,5,8,4,6

pin1 BYTE 5,2,4,1,3        ; 유효                → 0
pin2 BYTE 4,3,5,3,4        ; 1번째 자리 무효     → 1
pin3 BYTE 6,4,5,3,7        ; 5번째 자리 무효     → 5
pin4 BYTE 7,3,9,2,5        ; 3번째 자리 무효     → 3
pin5 BYTE 9,5,8,4,6        ; 유효 (경계값)       → 0

msgValid   BYTE "Valid",0
msgInvalid BYTE "Invalid, wrong digit position = ",0

.code
main PROC
    mov esi,OFFSET pin1
    call Validate_PIN
    call ShowResult

    mov esi,OFFSET pin2
    call Validate_PIN
    call ShowResult

    mov esi,OFFSET pin3
    call Validate_PIN
    call ShowResult

    mov esi,OFFSET pin4
    call Validate_PIN
    call ShowResult

    mov esi,OFFSET pin5
    call Validate_PIN
    call ShowResult
    exit
main ENDP

;---------------------------------------------------
; Validate_PIN
; 입력: ESI = PIN 배열(5바이트, 각 자리는 숫자값 0~9)
; 출력: EAX = 0(유효) 또는 처음으로 범위를 벗어난 자리의 위치(1~5)
;       (EAX 외 레지스터 보존)
;---------------------------------------------------
Validate_PIN PROC
    push ecx
    push edi
    mov ecx,5
    mov edi,0                    ; 0부터 시작하는 인덱스
L1:
    mov al,[esi + edi]
    cmp al,minDigit[edi]
    jb  Invalid                  ; 최솟값보다 작음
    cmp al,maxDigit[edi]
    ja  Invalid                  ; 최댓값보다 큼
    inc edi
    loop L1
    mov eax,0                    ; 모두 유효
    jmp Done
Invalid:
    mov eax,edi
    inc eax                      ; 1부터 시작하는 위치로 변환
Done:
    pop edi
    pop ecx
    ret
Validate_PIN ENDP

;---------------------------------------------------
; ShowResult : EAX(반환값)에 따라 Valid / Invalid 출력
;---------------------------------------------------
ShowResult PROC
    cmp eax,0
    jne Bad
    mov edx,OFFSET msgValid
    call WriteString
    call Crlf
    ret
Bad:
    mov edx,OFFSET msgInvalid
    call WriteString
    call WriteDec                ; 잘못된 자리 번호 출력
    call Crlf
    ret
ShowResult ENDP
END main
```

### ★★★★ 10. Parity Checking

Data transmission systems and file subsystems often use a form of error detection that relies on calculating the parity (even or odd) of blocks of data. Your task is to create a procedure that returns True in the EAX register if the bytes in an array contain even parity, or False if the parity is odd. In other words, if you count all the bits in the entire array, their count will be even or odd. Preserve all other register values between calls to the procedure. Write a test program that calls your procedure twice, each time passing it a pointer to an array and the length of the array. The procedure’s return value in EAX should be 1 (True) or 0 (False). For test data, create two arrays containing at least 10 bytes, one having even parity, and another having odd parity.

Tip: Earlier in this chapter, we showed how you can repeatedly apply the XOR instruction to a sequence of byte values to determine their parity. So, this suggests the use of a loop. But be careful, since some machine instructions affect the Parity flag, and others do not. You can find this out by looking at the individual instructions in Appendix B. The code in your loop that checks the parity will have to carefully save and restore the state of the Parity flag to avoid having it unintentionally modified by your code.

> 답:

```asm
INCLUDE Irvine32.inc

.data
evenArr BYTE 0Fh,0F0h,01h,01h,03h,0C0h,55h,0AAh,0FFh,00h   ; 1의 개수 = 30 (짝수)
oddArr  BYTE 0Fh,0F0h,01h,01h,03h,0C0h,55h,0AAh,0FFh,01h   ; 1의 개수 = 31 (홀수)

.code
main PROC
    mov esi,OFFSET evenArr
    mov ecx,LENGTHOF evenArr
    call CheckParity             ; EAX = 1 (짝수 패리티)
    call WriteDec
    call Crlf

    mov esi,OFFSET oddArr
    mov ecx,LENGTHOF oddArr
    call CheckParity             ; EAX = 0 (홀수 패리티)
    call WriteDec
    call Crlf
    exit
main ENDP

;---------------------------------------------------
; CheckParity
; 입력: ESI = 배열 주소, ECX = 길이(바이트)
; 출력: EAX = 1 (짝수 패리티) / 0 (홀수 패리티)
;       (EAX 외 레지스터 보존)
;---------------------------------------------------
CheckParity PROC
    push ecx
    push esi
    push edx
    mov dl,0                     ; 누적 XOR 값
    jecxz Check                  ; 길이 0 → 곧바로 검사 (짝수 취급)
L1:
    xor dl,[esi]                 ; 모든 바이트를 XOR로 누적
    inc esi                      ; (INC가 PF를 바꾸므로 루프 중에는 PF를 믿지 않는다)
    loop L1
Check:
    test dl,dl                   ; 누적 값으로 PF를 다시 설정
    jpe  Even                    ; PF = 1 → 1의 개수가 짝수
    mov eax,0
    jmp Done
Even:
    mov eax,1
Done:
    pop edx
    pop esi
    pop ecx
    ret
CheckParity ENDP
END main
```
