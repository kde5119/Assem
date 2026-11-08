# 8.10 Review Questions and Exercises

## 8.10.1 Short Answer

**1.** Which statements belong in a procedure’s epilogue when the procedure has stack parameters and local variables?

> 답: 저장한 레지스터를 pop으로 복원하고, mov esp,ebp로 지역 변수 공간을 해제한 뒤, pop ebp로 EBP를 복원하고, ret n으로 반환하면서 매개변수를 정리한다. mov esp,ebp와 pop ebp는 LEAVE 한 줄로 대체할 수 있다.

**2.** When a C function returns a 32-bit integer, where is the return value stored?

> 답: EAX 레지스터에 저장된다.

**3.** How does a program using the STDCALL calling convention clean up the stack after a procedure call?

> 답: 호출된 프로시저가 ret n 명령어로 정리한다. n은 매개변수가 차지한 바이트 수이며, RET이 반환한 뒤 ESP에 n을 더해 매개변수를 스택에서 제거한다.

**4.** How is the LEA instruction more powerful than the OFFSET operator?

> 답: OFFSET은 어셈블 시점에 주소가 정해진 변수에만 쓸 수 있다. LEA는 런타임에 계산되는 간접 오퍼랜드의 주소를 구할 수 있어서 [ebp-30] 같은 스택 변수의 주소도 얻을 수 있다.

**5.** In the C++ example shown in Section 8.2.3, how much stack space is used by a variable of type int?

> 답: 4바이트. 스택 항목은 기본 32비트이므로 int 변수 하나는 4바이트를 차지한다.

**6.** What advantages might the C calling convention have over the STDCALL calling convention?

> 답: 호출한 쪽에서 스택을 정리하므로(add esp,n) printf처럼 인수 개수가 가변적인 함수를 만들 수 있다. STDCALL은 ret n에 상수를 써야 해서 인수 개수가 고정되어야 한다.

**7.** (True/False): When using the PROC directive, all parameters must be listed on the same line.

> 답: False. 매개변수 목록은 PROC 뒤에 쉼표를 두고 여러 줄에 나누어 쓸 수 있다.

**8.** (True/False): If you pass a variable containing the offset of an array of bytes to a procedure that expects a pointer to an array of words, the assembler will flag this as an error.

> 답: False. MASM은 포인터가 가리키는 타입을 검사하지 않으므로 오류 없이 어셈블된다. 대신 런타임에 잘못된 크기로 데이터를 읽거나 쓰게 된다.

**9.** (True/False): If you pass an immediate value to a procedure that expects a reference parameter, you can generate a general-protection fault.

> 답: True. 즉시값이 포인터로 사용되어 프로그램 데이터 영역 밖의 주소(예: 1000h)를 참조하게 되므로 일반 보호 오류가 발생할 수 있다.

## 8.10.2 Algorithm Workbench

**1.** Here is a calling sequence for a procedure named AddThree that adds three doublewords (assume that the STDCALL calling convention is used):

```asm
push 10h
push 20h
push 30h
call AddThree
```

Draw a picture of the procedure’s stack frame immediately after EBP has been pushed on the runtime stack.

> 답: 인수는 역순으로 push되므로 마지막에 push한 30h가 가장 낮은 주소에 있다. 아래 오프셋은 mov ebp,esp 이후의 EBP 기준이다.

```
높은 주소
+--------------------+
| 10h                |  [EBP + 16]
+--------------------+
| 20h                |  [EBP + 12]
+--------------------+
| 30h                |  [EBP + 8]
+--------------------+
| 반환 주소           |  [EBP + 4]
+--------------------+
| 저장된 EBP          |  [EBP]  <- ESP
+--------------------+
낮은 주소
```

**2.** Create a procedure named AddThree that receives three integer parameters and calculates and returns their sum in the EAX register.

> 답: PROC의 매개변수 목록을 사용한다. STDCALL이므로 MASM이 ret 12를 생성한다.

```asm
AddThree PROC,
    val1:DWORD,
    val2:DWORD,
    val3:DWORD
    mov eax,val1
    add eax,val2
    add eax,val3
    ret
AddThree ENDP
```

**3.** Declare a local variable named pArray that is a pointer to an array of doublewords.

> 답: LOCAL은 PROC 바로 다음 줄에 와야 한다.

```asm
LOCAL pArray:PTR DWORD
```

**4.** Declare a local variable named buffer that is an array of 20 bytes.

> 답:

```asm
LOCAL buffer[20]:BYTE
```

**5.** Declare a local variable named pwArray that points to a 16-bit unsigned integer.

> 답:

```asm
LOCAL pwArray:PTR WORD
```

**6.** Declare a local variable named myByte that holds an 8-bit signed integer.

> 답:

```asm
LOCAL myByte:SBYTE
```

**7.** Declare a local variable named myArray that is an array of 20 doublewords.

> 답:

```asm
LOCAL myArray[20]:DWORD
```

**8.** Create a procedure named SetColor that receives two stack parameters: forecolor and backcolor, and calls the SetTextColor procedure from the Irvine32 library.

> 답: SetTextColor는 EAX에 foreground + (background \* 16)을 넣어 호출한다.

```asm
SetColor PROC USES eax,
    forecolor:DWORD,
    backcolor:DWORD
    mov eax,backcolor
    shl eax,4               ; 배경색은 상위 4비트
    add eax,forecolor
    call SetTextColor
    ret
SetColor ENDP
```

**9.** Create a procedure named WriteColorChar that receives three stack parameters: char, forecolor, and backcolor. It displays a single character, using the color attributes specified in forecolor and backcolor.

> 답: 색상을 설정한 뒤 AL에 문자를 넣고 WriteChar를 호출한다. char 매개변수의 이름은 charVal로 썼다.

```asm
WriteColorChar PROC USES eax,
    charVal:BYTE,
    forecolor:DWORD,
    backcolor:DWORD
    mov eax,backcolor
    shl eax,4
    add eax,forecolor
    call SetTextColor
    mov al,charVal
    call WriteChar
    ret
WriteColorChar ENDP
```

**10.** Write a procedure named DumpMemory that encapsulates the DumpMem procedure in the Irvine32 library. Use declared parameters and the USES directive. The following is an example of how it should be called: INVOKE DumpMemory, OFFSET array, LENGTHOF array, TYPE array.

> 답: DumpMem은 ESI에 시작 주소, ECX에 단위 개수, EBX에 단위 크기를 받는다. 매개변수를 이 레지스터에 옮긴 뒤 호출한다.

```asm
DumpMemory PROC USES ebx ecx esi,
    startAddr:DWORD,
    unitCount:DWORD,
    unitSize:DWORD
    mov esi,startAddr
    mov ecx,unitCount
    mov ebx,unitSize
    call DumpMem
    ret
DumpMemory ENDP
```

**11.** Declare a procedure named MultArray that receives two pointers to arrays of doublewords, and a third parameter indicating the number of array elements. Also, create a PROTO declaration for this procedure.

> 답: PROTO는 PROC 선언에서 PROC을 PROTO로 바꾸고 USES를 제거하여 만든다.

```asm
MultArray PROTO,
    pArray1:PTR DWORD,
    pArray2:PTR DWORD,
    arraySize:DWORD

MultArray PROC,
    pArray1:PTR DWORD,
    pArray2:PTR DWORD,
    arraySize:DWORD
    ; (본문 생략)
    ret
MultArray ENDP
```

---

## 8.11 Programming Exercises

**1.** ★ **FindLargest Procedure**

Create a procedure named FindLargest that receives two parameters: a pointer to a signed doubleword array, and a count of the array’s length. The procedure must return the value of the largest array member in EAX. Use the PROC directive with a parameter list when declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure. Write a test program that calls FindLargest and passes three different arrays of different lengths. Be sure to include negative values in your arrays. Create a PROTO declaration for FindLargest.

> 답: 첫 원소를 최댓값으로 두고 부호 있는 비교(JGE)로 갱신한다. 출력 결과는 -1, 45, -2이다.

```asm
FindLargest PROTO,
    ptrArray:PTR SDWORD,
    szArray:DWORD

.data
array1 SDWORD -5,-20,-1,-9
array2 SDWORD 10,-3,45,0,22,-100
array3 SDWORD -7,-8,-2

.code
main PROC
    INVOKE FindLargest, ADDR array1, LENGTHOF array1
    call WriteInt
    call Crlf
    INVOKE FindLargest, ADDR array2, LENGTHOF array2
    call WriteInt
    call Crlf
    INVOKE FindLargest, ADDR array3, LENGTHOF array3
    call WriteInt
    call Crlf
    exit
main ENDP

FindLargest PROC USES ecx esi,
    ptrArray:PTR SDWORD,
    szArray:DWORD
    mov esi,ptrArray
    mov ecx,szArray
    mov eax,[esi]           ; 첫 원소를 최댓값으로 가정
L1:
    cmp eax,[esi]
    jge L2                  ; 부호 있는 비교
    mov eax,[esi]
L2:
    add esi,4
    loop L1
    ret
FindLargest ENDP
```

**2.** ★ **Chess Board**

Write a program that draws an 8 × 8 chess board, with alternating gray and white squares. You can use the SetTextColor and Gotoxy procedures from the Irvine32 library. Avoid the use of global variables, and use declared parameters in all procedures. Use short procedures that are focused on a single task.

> 답: DrawSquare(한 칸), DrawRow(한 줄), DrawBoard(전체)로 나누어 모두 매개변수만 사용한다. 한 칸은 공백 문자를 배경색으로 칠하여 가로 4, 세로 2로 그린다.

```asm
SQ_W = 4                    ; 한 칸의 가로 길이
SQ_H = 2                    ; 한 칸의 세로 길이
BOARD_SIZE = 8

DrawSquare PROTO, x:DWORD, y:DWORD, color:DWORD
DrawRow    PROTO, y:DWORD, colorA:DWORD, colorB:DWORD
DrawBoard  PROTO, colorA:DWORD, colorB:DWORD

.code
main PROC
    INVOKE DrawBoard, gray, white
    mov dl,0
    mov dh,BOARD_SIZE * SQ_H
    call Gotoxy             ; 커서를 보드 아래로 이동
    mov eax,lightGray
    call SetTextColor       ; 기본 색 복원
    exit
main ENDP

; 한 칸을 그린다
DrawSquare PROC USES eax ebx ecx edx,
    x:DWORD,
    y:DWORD,
    color:DWORD
    mov eax,color
    shl eax,4               ; 배경색 설정
    call SetTextColor
    mov ebx,0               ; 줄 번호
L1:
    mov dl,BYTE PTR x
    mov dh,BYTE PTR y
    add dh,bl
    call Gotoxy
    mov ecx,SQ_W
L2:
    mov al,' '
    call WriteChar
    loop L2
    inc ebx
    cmp ebx,SQ_H
    jb L1
    ret
DrawSquare ENDP

; 한 줄(8칸)을 그린다
DrawRow PROC USES eax ebx ecx,
    y:DWORD,
    colorA:DWORD,
    colorB:DWORD
    mov ebx,0               ; 열 번호
L1:
    mov eax,colorA
    test ebx,1
    jz L2
    mov eax,colorB          ; 홀수 열은 다른 색
L2:
    imul ecx,ebx,SQ_W       ; x 좌표
    INVOKE DrawSquare, ecx, y, eax
    inc ebx
    cmp ebx,BOARD_SIZE
    jb L1
    ret
DrawRow ENDP

; 보드 전체(8줄)를 그린다
DrawBoard PROC USES ebx ecx,
    colorA:DWORD,
    colorB:DWORD
    mov ebx,0               ; 행 번호
L1:
    imul ecx,ebx,SQ_H       ; y 좌표
    test ebx,1
    jnz L2
    INVOKE DrawRow, ecx, colorA, colorB
    jmp L3
L2:
    INVOKE DrawRow, ecx, colorB, colorA   ; 홀수 행은 색 순서를 바꿈
L3:
    inc ebx
    cmp ebx,BOARD_SIZE
    jb L1
    ret
DrawBoard ENDP
```

**3.** ★★★ **Chess Board with Alternating Colors**

This exercise extends Exercise 2. Every 500 milliseconds, change the color of the colored squares and redisplay the board. Continue until you have shown the board 16 times, using all possible 4-bit background colors. (The white squares remain white throughout.)

> 답: 2번의 프로시저를 그대로 사용하고 main만 바꾼다. 색 번호 0~15를 DrawBoard의 첫 번째 색으로 넘기고 두 번째 색은 white로 고정한다. 매번 Delay로 500ms 대기한다.

```asm
main PROC
    mov ebx,0               ; 배경색 0~15
L1:
    INVOKE DrawBoard, ebx, white
    mov eax,500
    call Delay
    inc ebx
    cmp ebx,16
    jb L1
    mov dl,0
    mov dh,BOARD_SIZE * SQ_H
    call Gotoxy
    mov eax,lightGray
    call SetTextColor
    exit
main ENDP
```

**4.** ★★ **FindThrees Procedure**

Create a procedure named FindThrees that returns 1 if an array has three consecutive values of 3 somewhere in the array. Otherwise, return 0. The procedure’s input parameter list contains a pointer to the array and the array’s size. Use the PROC directive with a parameter list when declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure. Write a test program that calls FindThrees several times with different arrays.

> 답: 시작 위치마다 연속된 DWORD 3개가 모두 3인지 검사한다. 시작 가능한 위치는 (크기 - 2)개이다. 출력 결과는 1, 0, 0, 1이다.

```asm
FindThrees PROTO,
    ptrArray:PTR DWORD,
    szArray:DWORD

.data
arr1 DWORD 1,3,3,3,5
arr2 DWORD 3,3,1,3,3
arr3 DWORD 3,3
arr4 DWORD 7,3,3,3

.code
main PROC
    INVOKE FindThrees, ADDR arr1, LENGTHOF arr1
    call WriteDec
    call Crlf
    INVOKE FindThrees, ADDR arr2, LENGTHOF arr2
    call WriteDec
    call Crlf
    INVOKE FindThrees, ADDR arr3, LENGTHOF arr3
    call WriteDec
    call Crlf
    INVOKE FindThrees, ADDR arr4, LENGTHOF arr4
    call WriteDec
    call Crlf
    exit
main ENDP

FindThrees PROC USES ecx esi,
    ptrArray:PTR DWORD,
    szArray:DWORD
    mov esi,ptrArray
    mov ecx,szArray
    sub ecx,2               ; 시작 가능한 위치 수
    jbe NotFound            ; 크기가 2 이하이면 불가능
L1:
    cmp DWORD PTR [esi],3
    jne Next
    cmp DWORD PTR [esi+4],3
    jne Next
    cmp DWORD PTR [esi+8],3
    je Found
Next:
    add esi,4
    loop L1
NotFound:
    mov eax,0
    ret
Found:
    mov eax,1
    ret
FindThrees ENDP
```

**5.** ★★ **DifferentInputs Procedure**

Write a procedure named DifferentInputs that returns EAX = 1 if the values of its three input parameters are all different; otherwise, return with EAX = 0. Use the PROC directive with a parameter list when declaring the procedure. Create a PROTO declaration for your procedure, and call it five times from a test program that passes different inputs.

> 답: 세 쌍(1-2, 1-3, 2-3)을 모두 비교하여 하나라도 같으면 0, 모두 다르면 1을 반환한다. 출력 결과는 1, 0, 0, 0, 1이다.

```asm
DifferentInputs PROTO,
    val1:DWORD,
    val2:DWORD,
    val3:DWORD

.code
main PROC
    INVOKE DifferentInputs, 1, 2, 3
    call WriteDec
    call Crlf
    INVOKE DifferentInputs, 1, 1, 3
    call WriteDec
    call Crlf
    INVOKE DifferentInputs, 1, 2, 1
    call WriteDec
    call Crlf
    INVOKE DifferentInputs, 4, 5, 5
    call WriteDec
    call Crlf
    INVOKE DifferentInputs, 10, 20, 30
    call WriteDec
    call Crlf
    exit
main ENDP

DifferentInputs PROC,
    val1:DWORD,
    val2:DWORD,
    val3:DWORD
    mov eax,val1
    cmp eax,val2
    je Same
    cmp eax,val3
    je Same
    mov eax,val2
    cmp eax,val3
    je Same
    mov eax,1
    ret
Same:
    mov eax,0
    ret
DifferentInputs ENDP
```

**6.** ★★ **Exchanging Integers**

Create an array of randomly ordered integers. Using the Swap procedure from Section 8.4.6 as a tool, write a loop that exchanges each consecutive pair of integers in the array.

> 답: ESI가 각 쌍의 첫 원소를 가리키게 하고, LEA로 두 번째 원소의 주소를 구해 Swap을 호출한다. ADDR은 레지스터 기반 주소에 쓸 수 없으므로 LEA를 사용한다. 쌍의 개수는 LENGTHOF array / 2이다.

```asm
Swap PROTO, pValX:PTR DWORD, pValY:PTR DWORD

.data
array DWORD 7,2,9,4,1,8,3,6,5,10

.code
main PROC
    mov esi,OFFSET array
    mov ecx,LENGTHOF array
    mov ebx,TYPE array
    call DumpMem            ; 교환 전

    mov esi,OFFSET array
    mov ecx,LENGTHOF array / 2     ; 쌍의 개수
L1:
    lea ebx,[esi+4]         ; 두 번째 원소의 주소
    INVOKE Swap, esi, ebx
    add esi,8               ; 다음 쌍
    loop L1

    mov esi,OFFSET array
    mov ecx,LENGTHOF array
    mov ebx,TYPE array
    call DumpMem            ; 교환 후
    exit
main ENDP

Swap PROC USES eax esi edi,
    pValX:PTR DWORD,
    pValY:PTR DWORD
    mov esi,pValX
    mov edi,pValY
    mov eax,[esi]
    xchg eax,[edi]
    mov [esi],eax
    ret
Swap ENDP
```

**7.** ★★ **Greatest Common Divisor**

Write a recursive implementation of Euclid’s algorithm for finding the greatest common divisor (GCD) of two integers. Descriptions of this algorithm are available in algebra books and on the Web. Write a test program that calls your GCD procedure five times, using the following pairs of integers: (5,20), (24,18), (11,7), (432,226), (26,13). After each procedure call, display the GCD.

> 답: y가 0이면 x가 최대공약수이고, 아니면 GCD(y, x mod y)를 재귀 호출한다. 출력 결과는 5, 6, 1, 2, 13이다.

```asm
GCD PROTO, x:DWORD, y:DWORD

.code
main PROC
    INVOKE GCD, 5, 20
    call WriteDec
    call Crlf
    INVOKE GCD, 24, 18
    call WriteDec
    call Crlf
    INVOKE GCD, 11, 7
    call WriteDec
    call Crlf
    INVOKE GCD, 432, 226
    call WriteDec
    call Crlf
    INVOKE GCD, 26, 13
    call WriteDec
    call Crlf
    exit
main ENDP

GCD PROC USES edx,
    x:DWORD,
    y:DWORD
    cmp y,0
    jne Recurse
    mov eax,x               ; y = 0 이면 x가 GCD
    ret
Recurse:
    mov eax,x
    mov edx,0
    div y                   ; EDX = x mod y
    INVOKE GCD, y, edx      ; GCD(y, x mod y)
    ret
GCD ENDP
```

**8.** ★★ **Counting Matching Elements**

Write a procedure named CountMatches that receives points to two arrays of signed doublewords, and a third parameter that indicates the length of the two arrays. For each element xi in the first array, if the corresponding yi in the second array is equal, increment a count. At the end, return a count of the number of matching array elements in EAX. Write a test program that calls your procedure and passes pointers to two different pairs of arrays. Use the INVOKE statement to call your procedure and pass stack parameters. Create a PROTO declaration for CountMatches. Save and restore any registers (other than EAX) changed by your procedure.

> 답: 같은 위치의 원소끼리 비교하여 같으면 EAX를 증가시킨다. EAX를 제외하고 변경하는 레지스터는 USES로 저장한다. 출력 결과는 3, 2이다.

```asm
CountMatches PROTO,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD

.data
arrayA SDWORD 1,2,3,4,5
arrayB SDWORD 1,0,3,0,5
arrayC SDWORD -1,-2,-3
arrayD SDWORD -1,2,-3

.code
main PROC
    INVOKE CountMatches, ADDR arrayA, ADDR arrayB, LENGTHOF arrayA
    call WriteDec
    call Crlf
    INVOKE CountMatches, ADDR arrayC, ADDR arrayD, LENGTHOF arrayC
    call WriteDec
    call Crlf
    exit
main ENDP

CountMatches PROC USES ebx ecx esi edi,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD
    mov esi,pArray1
    mov edi,pArray2
    mov ecx,arraySize
    mov eax,0               ; 일치 개수
    cmp ecx,0
    je Done
L1:
    mov ebx,[esi]
    cmp ebx,[edi]
    jne Next
    inc eax
Next:
    add esi,4
    add edi,4
    loop L1
Done:
    ret
CountMatches ENDP
```

**9.** ★★★ **Counting Nearly Matching Elements**

Write a procedure named CountNearMatches that receives pointers to two arrays of signed doublewords, a parameter that indicates the length of the two arrays, and a parameter that indicates the maximum allowed difference (called diff) between any two matching elements. For each element xi in the first array, if the difference between it and the corresponding yi in the second array is less than or equal to diff, increment a count. At the end, return a count of the number of nearly matching array elements in EAX. Write a test program that calls CountNearMatches and passes pointers to two different pairs of arrays. Use the INVOKE statement to call your procedure and pass stack parameters. Create a PROTO declaration for CountMatches. Save and restore any registers (other than EAX) changed by your procedure.

> 답: x - y의 절댓값을 구해 diff 이하이면 EAX를 증가시킨다. 문제의 PROTO는 CountMatches라고 되어 있지만 CountNearMatches에 대한 PROTO를 작성한다. 출력 결과는 3, 1이다.

```asm
CountNearMatches PROC USES ebx ecx edx esi edi,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD,
    diff:DWORD

    mov esi,pArray1
    mov edi,pArray2
    mov ecx,arraySize
    mov eax,0
    cmp ecx,0
    je Done

L1:
    mov ebx,[esi]
    mov edx,[edi]

    cmp ebx,edx
    jge L2
    sub edx,ebx
    cmp edx,diff
    ja Next
    inc eax
    jmp Next

L2:
    sub ebx,edx
    cmp ebx,diff
    ja Next
    inc eax

Next:
    add esi,4
    add edi,4
    loop L1

Done:
    ret
CountNearMatches ENDP
```

**10.** ★★★★ **Show Procedure Parameters**

Write a procedure named ShowParams that displays the address and hexadecimal value of the 32-bit parameters on the runtime stack of the procedure that called it. The parameters are to be displayed in order from the lowest address to the highest. Input to the procedure will be a single integer that indicates the number of parameters to display. For example, suppose the following statement in main calls MySample, passing three arguments:

```asm
INVOKE MySample, 1234h, 5000h, 6543h
```

Next, inside MySample, you should be able to call ShowParams, passing the number of parameters you want to display:

```asm
MySample PROC first:DWORD, second:DWORD, third:DWORD
paramCount = 3
call ShowParams, paramCount
```

ShowParams should display output in the following format:

```
Stack parameters:
---------------------------
Address 0012FF80 = 00001234
Address 0012FF84 = 00005000
Address 0012FF88 = 00006543
```

> 답: ShowParams의 [ebp]에는 호출자(MySample)의 EBP가 저장되어 있다. 호출자의 첫 번째 매개변수는 호출자 EBP + 8에 있으므로, 거기서부터 4바이트씩 올라가며 주소(WriteHex)와 값을 출력한다. 문제의 call 대신 INVOKE를 사용한다.

```asm
ShowParams PROTO, paramCount:DWORD
MySample   PROTO, first:DWORD, second:DWORD, third:DWORD

.data
headerText BYTE "Stack parameters:",0Dh,0Ah
           BYTE "---------------------------",0Dh,0Ah,0
addrText   BYTE "Address ",0
equalText  BYTE " = ",0

.code
main PROC
    INVOKE MySample, 1234h, 5000h, 6543h
    exit
main ENDP

MySample PROC,
    first:DWORD,
    second:DWORD,
    third:DWORD
    paramCount = 3
    INVOKE ShowParams, paramCount
    ret
MySample ENDP

ShowParams PROC USES eax ecx edx esi,
    paramCount:DWORD
    mov edx,OFFSET headerText
    call WriteString
    mov esi,[ebp]           ; 호출자(MySample)의 EBP
    add esi,8               ; 호출자의 첫 번째 매개변수 주소
    mov ecx,paramCount
    jecxz Done              ; 개수가 0이면 종료
L1:
    mov edx,OFFSET addrText
    call WriteString
    mov eax,esi
    call WriteHex           ; 주소
    mov edx,OFFSET equalText
    call WriteString
    mov eax,[esi]
    call WriteHex           ; 값
    call Crlf
    add esi,4               ; 높은 주소 방향으로 이동
    loop L1
Done:
    ret
ShowParams ENDP
```
