# 5.8 Review Questions and Exercises

## 5.8.1 Short Answer

**1.** Which instruction pushes all of the 32-bit general-purpose registers on the stack?

> 답: PUSHAD

**2.** Which instruction pushes the 32-bit EFLAGS register on the stack?

> 답: PUSHFD

**3.** Which instruction pops the stack into the EFLAGS register?

> 답: POPFD

**4.** Challenge: Another assembler (called NASM) permits the PUSH instruction to list multiple specific registers. Why might this approach be better than the PUSHAD instruction in MASM? Here is a NASM example:

```nasm
PUSH EAX EBX ECX
```

> 답: 필요한 레지스터를 골라서 저장하거나 복원할 수 있다.

**5.** Challenge: Suppose there were no PUSH instruction. Write a sequence of two other instructions that would accomplish the same as `push eax`.

> 답:

```asm
sub esp, 4
mov DWORD PTR [esp], eax
```

**6.** (True/False): The RET instruction pops the top of the stack into the instruction pointer.

> 답: True.

**7.** (True/False): Nested procedure calls are not permitted by the Microsoft assembler unless the NESTED operator is used in the procedure definition.

> 답: False.

**8.** (True/False): In protected mode, each procedure call uses a minimum of 4 bytes of stack space.

> 답: True.

**9.** (True/False): The ESI and EDI registers cannot be used when passing 32-bit parameters to procedures.

> 답: False.

**10.** (True/False): The ArraySum procedure (Section 5.2.5) receives a pointer to any array of doublewords.

> 답: True.

**11.** (True/False): The USES operator lets you name all registers that are modified within a procedure.

> 답: True.

**12.** (True/False): The USES operator only generates PUSH instructions, so you must code POP instructions yourself.

> 답: False. POP도 생성함.

**13.** (True/False): The register list in the USES directive must use commas to separate the register names.

> 답: False. 공백이나 탭 사용.

**14.** Which statement(s) in the ArraySum procedure (Section 5.2.5) would have to be modified so it could accumulate an array of 16-bit words? Create such a version of ArraySum and test it.

> 답:

```asm
ArraySum PROC USES esi ecx edx
    mov eax, 0

L1:
    movzx edx, WORD PTR [esi]
    add eax, edx
    add esi, TYPE WORD
    loop L1

    ret
ArraySum ENDP
```

**15.** What will be the final value in EAX after these instructions execute?

```nasm
push 5
push 6
pop eax
pop eax
```

> 답: 5

**16.** Which statement is true about what will happen when the example code runs?

```nasm
 1: main PROC
 2: push 10
 3: push 20
 4: call Ex2Sub
 5: pop eax
 6: INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex2Sub PROC
10: pop eax
11: ret
12: Ex2Sub ENDP
```

- a. EAX will equal 10 on line 6
- b. The program will halt with a runtime error on Line 10
- c. EAX will equal 20 on line 6
- d. The program will halt with a runtime error on Line 11

> 답: b.

**17.** Which statement is true about what will happen when the example code runs?

```nasm
 1: main PROC
 2: mov eax,30
 3: push eax
 4: push 40
 5: call Ex3Sub
 6: INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex3Sub PROC
10: pusha
11: mov eax,80
12: popa
13: ret
14: Ex3Sub ENDP
```

- a. EAX will equal 40 on line 6
- b. The program will halt with a runtime error on Line 6
- c. EAX will equal 30 on line 6
- d. The program will halt with a runtime error on Line 13

> 답: c.

**18.** Which statement is true about what will happen when the example code runs?

```nasm
 1: main PROC
 2: mov eax,40
 3: push offset Here
 4: jmp Ex4Sub
 5: Here:
 6: mov eax,30
 7: INVOKE ExitProcess,0
 8: main ENDP
 9:
10: Ex4Sub PROC
11: ret
12: Ex4Sub ENDP
```

- a. EAX will equal 30 on line 7
- b. The program will halt with a runtime error on Line 4
- c. EAX will equal 30 on line 6
- d. The program will halt with a runtime error on Line 11

> 답: c.

**19.** Which statement is true about what will happen when the example code runs?

```nasm
 1: main PROC
 2: mov edx,0
 3: mov eax,40
 4: push eax
 5: call Ex5Sub
 6: INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex5Sub PROC
10: pop eax
11: pop edx
12: push eax
13: ret
14: Ex5Sub ENDP
```

- a. EDX will equal 40 on line 6
- b. The program will halt with a runtime error on Line 13
- c. EDX will equal 0 on line 6
- d. The program will halt with a runtime error on Line 11

> 답: a

**20.** What values will be written to the array when the following code executes?

```nasm
.data
array DWORD 4 DUP(0)
.code
main PROC
    mov eax,10
    mov esi,0
    call proc_1
    add esi,4
    add eax,10
    mov array[esi],eax
    INVOKE ExitProcess,0
main ENDP

proc_1 PROC
    call proc_2
    add esi,4
    add eax,10
    mov array[esi],eax
    ret
proc_1 ENDP

proc_2 PROC
    call proc_3
    add esi,4
    add eax,10
    mov array[esi],eax
    ret
proc_2 ENDP

proc_3 PROC
    mov array[esi],eax
    ret
proc_3 ENDP
```

> 답: array = 10, 20, 30, 40

---

## 5.8.2 Algorithm Workbench

_The following exercises can be solved using either 32-bit or 64-bit code._

**1.** Write a sequence of statements that use only PUSH and POP instructions to exchange the values in the EAX and EBX registers (or RAX and RBX in 64-bit mode).

> 답:

```asm
push eax
push ebx
pop eax
pop ebx
```

**2.** Suppose you wanted a subroutine to return to an address that was 3 bytes higher in memory than the return address currently on the stack. Write a sequence of instructions that would be inserted just before the subroutine's RET instruction that accomplish this task.

> 답:

```asm
pop eax
add eax, 3
push eax
ret
```

**3.** Functions in high-level languages often declare local variables just below the return address on the stack. Write an instruction that you could put at the beginning of an assembly language subroutine that would reserve space for two integer doubleword variables. Then, assign the values 1000h and 2000h to the two local variables.

> 답:

```asm
sub esp, 8
mov DWORD PTR [esp], 1000h
mov DWORD PTR [esp+4], 2000h
```

**4.** Write a sequence of statements using indexed addressing that copies an element in a doubleword array to the previous position in the same array.

> 답: 이전 위치로 복사이니 esi 가 1 이상이라고 가정.

```asm
mov eax, array[esi*4]
mov array[esi*4-4], eax
```

**5.** Write a sequence of statements that display a subroutine's return address. Be sure that whatever modifications you make to the stack do not prevent the subroutine from returning to its caller.

> 답: irvine

```asm
mov eax, DWORD PTR [esp]
call WriteHex
ret
```

---

# 5.9 Programming Exercises

_When you write programs to solve the programming exercises, use multiple procedures when possible. Follow the style and naming conventions used in this book, unless instructed otherwise by your instructor. Use explanatory comments in your programs at the beginning of each procedure and next to nontrivial statements._

**1. Draw Text Colors**

Write a program that displays the same string in four different colors, using a loop. Call the SetTextColor procedure from the book's link library. Any colors may be chosen, but you may find it easiest to change the foreground color.

> 답:

```asm
.data
msg BYTE "Hello, Color!",0
.code
    mov ebx,1                 ; 시작 색 (파랑)
    mov ecx,4                 ; 4번 반복
L1:
    mov eax,ebx
    call SetTextColor         ; EAX = 색
    mov edx,OFFSET msg
    call WriteString
    call Crlf
    inc ebx                   ; 다음 색
    loop L1
```

**2. Linking Array Items**

Suppose you are given three data items that indicate a starting index in a list, an array of characters, and an array of link index. You are to write a program that traverses the links and locates the characters in their correct sequence. For each character you locate, copy it to a new array. Suppose you used the following sample data, and assumed the arrays use zero-based indexes:

```

start = 1
chars: HACEBDFG
links: 04562370

```

Then the values copied (in order) to the output array would be A,B,C,D,E,F,G,H. Declare the character array as type BYTE, and to make the problem more interesting, declare the links array type DWORD.

> 답:

```asm
.data
start  DWORD 1
chars  BYTE "HACEBDFG"
links  DWORD 0,4,5,6,2,3,7,0
outArr BYTE LENGTHOF chars DUP(?)
.code
    mov ecx,LENGTHOF chars
    mov esi,start              ; 현재 인덱스
    mov edi,0                  ; 출력 배열 인덱스
L1:
    mov al,chars[esi]          ; 문자 복사
    mov outArr[edi],al
    inc edi
    mov esi,links[esi*4]       ; 링크 따라 다음 인덱스로 (DWORD이므로 ×4)
    loop L1
```

**3. Simple Addition (1)**

Write a program that clears the screen, locates the cursor near the middle of the screen, prompts the user for two integers, adds the integers, and displays their sum.

> 답:

```asm
.data
msg1   BYTE "First integer : ",0
msg2   BYTE "Second integer: ",0
msgSum BYTE "Sum = ",0
.code
    call Clrscr
    mov dh,12                ; 행 (가운데 근처)
    mov dl,25                ; 열
    call Gotoxy
    mov edx,OFFSET msg1
    call WriteString
    call ReadInt             ; EAX = 입력값
    mov ebx,eax
    mov edx,OFFSET msg2
    call WriteString
    call ReadInt
    add eax,ebx              ; 합
    mov edx,OFFSET msgSum
    call WriteString
    call WriteInt
    call Crlf
```

**4. Simple Addition (2)**

Use the solution program from the preceding exercise as a starting point. Let this new program repeat the same steps three times, using a loop. Clear the screen after each loop iteration.

> 답:

```asm
    mov ecx,3
L1:
    call Clrscr
    ; ... 3번 문제의 Gotoxy ~ WriteInt 부분 ...
    call Crlf
    call WaitMsg             ; 아무 키나 누를 때까지 대기
    loop L1
```

**5. BetterRandomRange Procedure**

The RandomRange procedure from the Irvine32 library generates a pseudorandom integer between 0 and N − 1. Your task is to create an improved version that generates an integer between M and N − 1. Let the caller pass M in EBX and N in EAX. If we call the procedure BetterRandomRange, the following code is a sample test:

```nasm
mov ebx,-300    ; lower bound
mov eax,100     ; upper bound
call BetterRandomRange
```

Write a short test program that calls BetterRandomRange from a loop that repeats 50 times. Display each randomly generated value.

> 답:

```asm
BetterRandomRange PROC USES ebx
    sub eax,ebx              ; 범위 크기 = N - M
    call RandomRange         ; 0 ~ (N-M-1)
    add eax,ebx              ; + M → M ~ N-1
    ret
BetterRandomRange ENDP

main PROC
    call Randomize
    mov ecx,50
L1:
    mov ebx,-300
    mov eax,100
    call BetterRandomRange
    call WriteInt
    call Crlf
    loop L1
```

**6. Random Strings**

Create a procedure that generates a random string of length L, containing all capital letters. When calling the procedure, pass the value of L in EAX, and pass a pointer to an array of byte that will hold the random string. Write a test program that calls your procedure 20 times and displays the strings in the console window.

> 답:

```.data
str1 BYTE 11 DUP(?)          ; 길이 10 + 널 문자
.code
Random_String PROC USES eax ecx esi
    ; 입력: EAX = L, ESI = 배열 주소
    mov ecx,eax
L1:
    mov eax,26
    call RandomRange         ; 0 ~ 25
    add eax,'A'              ; 'A' ~ 'Z'
    mov [esi],al
    inc esi
    loop L1
    mov BYTE PTR [esi],0     ; 널 종료
    ret
Random_String ENDP

main PROC
    call Randomize
    mov ecx,20
L2:
    mov eax,10
    mov esi,OFFSET str1
    call Random_String
    mov edx,OFFSET str1
    call WriteString
    call Crlf
    loop L2
```

**7. Random Screen Locations**

Write a program that displays a single character at 100 random screen locations, using a timing delay of 100 milliseconds. Hint: Use the GetMaxXY procedure to determine the current size of the console window.

> 답:

```asm
.data
maxRow BYTE ?
maxCol BYTE ?
.code
    call Randomize
    call GetMaxXY            ; AX = 행 수, DX = 열 수
    mov maxRow,al
    mov maxCol,dl
    mov ecx,100
L1:
    movzx eax,maxRow
    call RandomRange         ; 임의의 행
    mov dh,al
    movzx eax,maxCol
    call RandomRange         ; 임의의 열
    mov dl,al
    call Gotoxy              ; DH = 행, DL = 열
    mov al,'*'
    call WriteChar
    mov eax,100
    call Delay               ; 100ms 지연
    loop L1
```

**8. Color Matrix**

Write a program that displays a single character in all possible combinations of foreground and background colors (16 × 16 = 256). The colors are numbered from 0 to 15, so you can use a nested loop to generate all possible combinations.

> 답:

```asm
    mov ebx,0                ; 배경색
    mov ecx,16               ; 바깥 루프
OuterL:
    push ecx                 ; 바깥 카운터 저장
    mov esi,0                ; 전경색
    mov ecx,16               ; 안쪽 루프
InnerL:
    mov eax,ebx
    shl eax,4                ; 배경 × 16
    add eax,esi              ; + 전경
    call SetTextColor
    mov al,'A'
    call WriteChar
    inc esi
    loop InnerL
    call Crlf
    inc ebx
    pop ecx                  ; 바깥 카운터 복구
    loop OuterL
    mov eax,7                ; 기본 색으로 복구
    call SetTextColor
```

**9. Recursive Procedure**

Direct recursion is the term we use when a procedure calls itself. Of course, you never want to let a procedure keep calling itself forever, because the runtime stack would fill up. Instead, you must limit the recursion in some way. Write a program that calls a recursive procedure. Inside this procedure, add 1 to a counter so you can verify the number of times it executes. Run your program with a debugger, and at the end of the program, check the counter's value. Put a number in ECX that specifies the number of times you want to allow the recursion to continue. Using only the LOOP instruction (and no other conditional statements from later chapters), find a way for the recursive procedure to call itself a fixed number of times.

> 답:

```asm
.data
counter DWORD 0
.code
Recurse PROC
    inc counter
    loop Again               ; ECX-1 ≠ 0 이면 Again으로
    ret                      ; ECX = 0 → 재귀 종료
Again:
    call Recurse             ; 자기 자신 호출
    ret
Recurse ENDP

main PROC
    mov ecx,5                ; 5번 실행
    call Recurse             ; 종료 후 counter = 5
```

**10. Fibonacci Generator**

Write a procedure that produces N values in the Fibonacci number series and stores them in an array of doubleword. Input parameters should be a pointer to an array of doubleword, a counter of the number of values to generate. Write a test program that calls your procedure, passing N = 47. The first value in the array will be 1, and the last value will be 2,971,215,073. Use the Visual Studio debugger to open and inspect the array contents.

> 답:

```asm
.data
fibArray DWORD 47 DUP(?)
.code
Fibonacci PROC USES eax ebx ecx esi
    ; 입력: ESI = 배열 주소, ECX = 생성할 개수 N
    mov eax,0                ; 이전 값
    mov ebx,1                ; 현재 값
L1:
    mov [esi],ebx            ; 현재 값 저장
    add esi,TYPE DWORD
    add eax,ebx              ; 이전 + 현재 = 다음 값
    xchg eax,ebx             ; EAX = 현재, EBX = 다음 값
    loop L1
    ret
Fibonacci ENDP

main PROC
    mov esi,OFFSET fibArray
    mov ecx,LENGTHOF fibArray    ; N = 47
    call Fibonacci
```

**11. Finding Multiples of K**

In a byte array of size N, write a procedure that finds all multiples of K that are less than N. Initialize the array to all zeros at the beginning of the program, and then whenever a multiple is found, set the corresponding array element to 1. Your procedure must save and restore any registers it modifies. Call your procedure twice, with K = 2, and again with K = 3. Let N equal to 50. Run your program in the debugger and verify that the array values were set correctly. Note: This procedure can be a useful tool when finding prime integers. An efficient algorithm for finding prime numbers is known as the Sieve of Eratosthenes. You will be able to implement this algorithm when conditional statements are covered in Chapter 6.

> 답:

```asm
.data
arr BYTE 50 DUP(0)
.code
Mark_Multiples PROC USES eax ebx ecx edx esi
    ; 입력: ESI = 배열 주소, EBX = K, ECX = N
    mov eax,ecx
    dec eax                  ; N - 1
    mov edx,0
    div ebx                  ; EAX = (N-1)/K = 배수 개수
    mov ecx,eax
    mov eax,0                ; 현재 인덱스
L1:
    add eax,ebx              ; 다음 배수 (K, 2K, ...)
    mov BYTE PTR [esi+eax],1
    loop L1
    ret
Mark_Multiples ENDP

main PROC
    mov esi,OFFSET arr
    mov ebx,2                ; K = 2
    mov ecx,50               ; N = 50
    call Mark_Multiples
    mov ebx,3                ; K = 3
    mov ecx,50
    call Mark_Multiples
```
