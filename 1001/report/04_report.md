# 4.9 Review Questions and Exercises

## 4.9.1 Short Answer

**1.** What will be the value in EDX after each of the lines marked (a) and (b) execute?

```asm
.data
one WORD 8002h
two WORD 4321h
.code
mov edx,21348041h
movsx edx,one ; (a)
movsx edx,two ; (b)
```

> 답: a줄 실행되면 FFFF8002h, b줄 실행되면 00004321h이다.
> movsx가 부호 확장.

**2.** What will be the value in EAX after the following lines execute?

```asm
mov eax,1002FFFFh
inc ax
```

> 답: 10020000h. inc ax는 ax부분만 연산. FFFF에만 연산이 수행되어
> 캐리는 버리고 0000으로.

**3.** What will be the value in EAX after the following lines execute?

```asm
mov eax,30020000h
dec ax
```

> 답: 3002FFFFh. 위와 같음.

**4.** What will be the value in EAX after the following lines execute?

```asm
mov eax,1002FFFFh
neg ax
```

> 답: 10020001h. neg는 2의 보수를 취하니, ax인 FFFFh에 적용하면, 0001h

**5.** What will be the value of the Parity flag after the following lines execute?

```asm
mov al,1
add al,3
```

> 답: al은 04h가 되고 0000 0100, 1이 홀수이니 Parity flag는 0이 된다.

**6.** What will be the value of EAX and the Sign flag after the following lines execute?

```asm
mov eax,5
sub eax,6
```

> 답: eax는 FFFFFFFFh, Sign flag는 1

**7.** In the following code, the value in AL is intended to be a signed byte. Explain how the Overflow flag helps, or does not help you, to determine whether the final value in AL falls within a valid signed range.

```asm
mov al,-1
add al,130
```

> 답: 아니다. 의도한 계산은 129일테지만 130 = 82h = 1000 0010라서 AL = 81h이고 OF = 0이라 OF만 보고 판단할 수 있지 않다.

**8.** What value will RAX contain after the following instruction executes?

```asm
mov rax,44445555h
```

> 답: 0000000044445555h. 상위비트 0으로 채워짐

**9.** What value will RAX contain after the following instructions execute?

```asm
.data
dwordVal DWORD 84326732h
.code
mov rax,0FFFFFFFF00000000h
mov rax,dwordVal
```

> 답: 0000000084326732h. rax에 dwordVal넣을때 상위비트 0으로 채워져 기존 0FFFFFFFF00000000h는 그냥 덮어씌워짐

**10.** What value will EAX contain after the following instructions execute?

```asm
.data
dVal DWORD 12345678h
.code
mov ax,3
mov WORD PTR dVal+2,ax
mov eax,dVal
```

> 답: 00035678h. dVal이 메모리에 78 56 34 12순서로 저장되고, dVal+2는 34부터 읽으니 1234h를 읽은 것이고, 여기 0003h가 덮어씌여진다.

**11.** What will EAX contain after the following instructions execute?

```asm
.data
dVal DWORD ?
.code
mov dVal,12345678h
mov ax,WORD PTR dVal+2
add ax,3
mov WORD PTR dVal,ax
mov eax,dVal
```

> 답: 12341237h. add ax,3이후 1237h가 dVAl에 넣으면 12341237h

**12.** (Yes/No): Is it possible to set the Overflow flag if you add a positive integer to a negative integer?

> 답: No. 부호가 다르면 결국 절댓값은 각각의 값보다 커질 수가 없다.

**13.** (Yes/No): Will the Overflow flag be set if you add a negative integer to a negative integer and produce a positive result?

> 답: Yes. OF는 두 수의 부호가 같은데 결과 부호가 다르면 세트됨.

**14.** (Yes/No): Is it possible for the NEG instruction to set the Overflow flag?

> 답: Yes.

**15.** (Yes/No): Is it possible for both the Sign and Zero flags to be set at the same time?

> 답: No. ZF가 1이면 결과가 0이라는 건데, 0의 부호 비트는 0이라 SF가 세트되지 않는다.

**16~19.**
Use the following variable definitions for Questions 16–19:

```asm
.data
var1 SBYTE -4,-2,3,1
var2 WORD 1000h,2000h,3000h,4000h
var3 SWORD -16,-42
var4 DWORD 1,2,3,4,5
```

**16.** For each of the following statements, state whether or not the instruction is valid:

```asm
a. mov ax,var1
b. mov ax,var2
c. mov eax,var3
d. mov var2,var3
e. movzx ax,var2
f. movzx var2,al
g. mov ds,ax
h. mov ds,1000h
```

> 답:  
> a. 무효. 크기가 맞지 않음
> b. 유효.
> c. 무효. 크기가 맞지 않음
> d. 무효. 메모리에서 메모리 불가능
> e. 무효. ax가 var2보다 커야 하는데 둘다 16비트.
> f. 무효. movzx의 목적지는 레지스터여야 하는데 var2는 메모리
> g. 유효. 레지스터에서 세그먼트 레지스터로 이동하는 것은 허용
> h. 무효. 세그먼트 레지스터에 immediate value를 넣을 수 없음

**17.** What will be the hexadecimal value of the destination operand after each of the following instructions execute in sequence?

```asm
mov al,var1      ; a.
mov ah,[var1+3]  ; b.
```

> 답:  
> a. FCh
> b. 01h

**18.** What will be the value of the destination operand after each of the following instructions execute in sequence?

```asm
mov ax,var2      ; a.
mov ax,[var2+4]  ; b.
mov ax,var3      ; c.
mov ax,[var3-2]  ; d.
```

> 답:  
> a. 1000h.
> b. 3000h.
> c. FFF0h.
> d. 4000h.

**19.** What will be the value of the destination operand after each of the following instructions execute in sequence?

```asm
mov edx,var4      ; a.
movzx edx,var2    ; b.
mov edx,[var4+4]  ; c.
movsx edx,var1    ; d.
```

> 답:  
> a. 00000001h.
> b. 00001000h.
> c. 00000002h.
> d. FFFFFFFCh.

---

### 4.9.2 Algorithm Workbench

**1.** Write a sequence of MOV instructions that will exchange the upper and lower words in a doubleword variable named `three`.

> 답:

```asm
mov ax,WORD PTR three
mov bx,WORD PTR three+2
mov WORD PTR three,bx
mov WORD PTR three+2,ax
```

**2.** Using the XCHG instruction no more than three times, reorder the values in four 8-bit registers from the order A,B,C,D to B,C,D,A.

> 답: (a1, b1, cl, dl)에 각각 A, B, C, D가 들어 있다고 가정

```asm
xchg al,bl
xchg bl,cl
xchg cl,dl
```

**3.** Transmitted messages often include a parity bit whose value is combined with a data byte to produce an even number of 1 bits. Suppose a message byte in the AL register contains `01110101`. Show how you could use the Parity flag combined with an arithmetic instruction to determine if this message byte has even or odd parity.

> 답: add al,0을 수행하면 al은 그대로지만 Parity Flag가 계산되서 확인할 수 있다.

```asm
mov al,01110101b
add al,0
```

**4.** Write code using byte operands that adds two negative integers and causes the Overflow flag to be set.

> 답: -128은 80h로 저장되고, FFh와 더하면 7Fh만 남으니 음수 덧셈인데 결과는 양수, 즉 OF가 1로 세트됨

```asm
mov al,-128
add al,-1
```

**5.** Write a sequence of two instructions that use addition to set the Zero and Carry flags at the same time.

> 답:

```asm
mov al,0FFh
add al,1
```

**6.** Write a sequence of two instructions that set the Carry flag using subtraction.

> 답:

```asm
mov al,1
sub al,2
```

**7.** Implement the following arithmetic expression in assembly language: `EAX = –val2 + 7 – val3 + val1`. Assume that val1, val2, and val3 are 32-bit integer variables.

> 답:

```asm
mov eax,val2
neg eax
add eax,7
sub eax,val3
add eax,val1
```

**8.** Write a loop that iterates through a doubleword array and calculates the sum of its elements using a scale factor with indexed addressing.

> 답:

```asm
.data
arr DWORD 10,20,30,40
.code
    mov eax,0              ; 합
    mov esi,0              ; 인덱스
    mov ecx,LENGTHOF arr   ; 반복 횟수
L1:
    add eax,arr[esi*4]     ; 스케일 팩터 4
    inc esi
    loop L1
```

**9.** Implement the following expression in assembly language: `AX = (val2 + BX) – val4`. Assume that val2 and val4 are 16-bit integer variables.

> 답:

```asm
mov ax,val2
add ax,bx
sub ax,val4
```

**10.** Write a sequence of two instructions that set both the Carry and Overflow flags at the same time.

> 답:

```asm
mov al,-128
add al,-128
```

**11.** Write a sequence of instructions showing how the Zero flag could be used to indicate unsigned overflow after executing INC and DEC instructions.

> 답: dec 실행 후 ZF만으로 unsigned underflow를 확인하기 힘듬.
> (00...00 → FF...FF) 에서 ZF = 0

```asm
mov al,0FFh
inc al
```

**12~18**

Use the following data definitions for Questions 12–18:

```asm
.data
myBytes BYTE 10h,20h,30h,40h
myWords WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

**12.** Insert a directive in the given data that aligns `myBytes` to an even-numbered address.

> 답:

```asm
ALIGN 2
myBytes BYTE ...
```

**13.** What will be the value of EAX after each of the following instructions execute?

```asm
mov eax,TYPE myBytes      ; a.
mov eax,LENGTHOF myBytes  ; b.
mov eax,SIZEOF myBytes    ; c.
mov eax,TYPE myWords      ; d.
mov eax,LENGTHOF myWords  ; e.
mov eax,SIZEOF myWords    ; f.
mov eax,SIZEOF myString   ; g.
```

> 답:  
> a. 1
> b. 4
> c. 4
> d. 2
> e. 4
> f. 8
> g. 5

**14.** Write a single instruction that moves the first two bytes in `myBytes` to the DX register. The resulting value will be `2010h`.

> 답:

```asm
mov dx,WORD PTR myBytes
```

**15.** Write an instruction that moves the second byte in `myWords` to the AL register.

> 답:

```asm
mov al,BYTE PTR myWords+1
```

**16.** Write an instruction that moves all four bytes in `myBytes` to the EAX register.

> 답:

```asm
mov eax,DWORD PTR myBytes
```

**17.** Insert a LABEL directive in the given data that permits `myWords` to be moved directly to a 32-bit register.

> 답:

```asm
myWordsD LABEL DWORD
myWords WORD 3 DUP(?),2000h
```

**18.** Insert a LABEL directive in the given data that permits `myBytes` to be moved directly to a 16-bit register.

> 답:

```asm
myBytesW LABEL WORD
myBytes BYTE 10h,20h,30h,40h
```

---

## 4.10 Programming Exercises

The following exercises may be completed in either 32-bit mode or 64-bit mode.

**1.** ★ **Converting from Big Endian to Little Endian**

Write a program that uses the variables below and MOV instructions to copy the value from `bigEndian` to `littleEndian`, reversing the order of the bytes. The number's 32-bit value is understood to be 12345678 hexadecimal.

```asm
.data
bigEndian BYTE 12h,34h,56h,78h
littleEndian DWORD ?
```

> 답:

```asm
.data
bigEndian BYTE 12h,34h,56h,78h
littleEndian DWORD ?
.code
    mov al,[bigEndian]
    mov BYTE PTR [littleEndian+3],al
    mov al,[bigEndian+1]
    mov BYTE PTR [littleEndian+2],al
    mov al,[bigEndian+2]
    mov BYTE PTR [littleEndian+1],al
    mov al,[bigEndian+3]
    mov BYTE PTR [littleEndian],al
```

**2.** ★★ **Exchanging Pairs of Array Values**

Write a program with a loop and indexed addressing that exchanges every pair of values in an array with an even number of elements. Therefore, item i will exchange with item i+1, and item i+2 will exchange with item i+3, and so on.

> 답:

```asm
.data
arr DWORD 1,2,3,4,5,6
.code
    mov esi,0
    mov ecx,LENGTHOF arr / 2
L1:
    mov eax,arr[esi*4]
    xchg eax,arr[esi*4+4]
    mov arr[esi*4],eax
    add esi,2
    loop L1
```

**3.** ★★ **Summing the Gaps between Array Values**

Write a program with a loop and indexed addressing that calculates the sum of all the gaps between successive array elements. The array elements are doublewords, sequenced in nondecreasing order. So, for example, the array {0, 2, 5, 9, 10} has gaps of 2, 3, 4, and 1, whose sum equals 10.

> 답:

```asm
.data
arr DWORD 0,2,5,9,10
.code
    mov eax,0                   ; 합
    mov esi,0
    mov ecx,LENGTHOF arr - 1    ; 간격은 원소 수 - 1개
L1:
    mov ebx,arr[esi*4+4]
    sub ebx,arr[esi*4]          ; 다음 값 - 현재 값
    add eax,ebx
    inc esi
    loop L1
```

**4.** ★★ **Copying a Word Array to a DoubleWord Array**

Write a program that uses a loop to copy all the elements from an unsigned Word (16-bit) array into an unsigned doubleword (32-bit) array.

> 답:

```asm
.data
wordArr WORD 1,2,3,4
dwordArr DWORD LENGTHOF wordArr DUP(?)
.code
    mov esi,0
    mov ecx,LENGTHOF wordArr
L1:
    movzx eax,wordArr[esi*2]
    mov dwordArr[esi*4],eax
    inc esi
    loop L1
```

**5.** ★★ **Fibonacci Numbers**

Write a program that uses a loop to calculate the first seven values of the Fibonacci number sequence, described by the following formula: Fib(1) = 1, Fib(2) = 1, Fib(n) = Fib(n – 1) + Fib(n – 2).

> 답:

```asm
.data
fib DWORD 7 DUP(?)
.code
    mov fib,1
    mov fib[4],1
    mov esi,2
    mov ecx,5                   ; 나머지 5개 계산
L1:
    mov eax,fib[esi*4-4]
    add eax,fib[esi*4-8]
    mov fib[esi*4],eax
    inc esi
    loop L1
```

**6.** ★★★ **Reverse an Array**

Use a loop with indirect or indexed addressing to reverse the elements of an integer array in place. Do not copy the elements to any other array. Use the SIZEOF, TYPE, and LENGTHOF operators to make the program as flexible as possible if the array size and type should be changed in the future.

> 답:

```asm
.data
arr DWORD 1,2,3,4,5
.code
    mov esi,OFFSET arr                              ; 앞 포인터
    mov edi,OFFSET arr + SIZEOF arr - TYPE arr      ; 뒤 포인터
    mov ecx,LENGTHOF arr / 2
L1:
    mov eax,[esi]
    mov ebx,[edi]
    mov [esi],ebx
    mov [edi],eax
    add esi,TYPE arr
    sub edi,TYPE arr
    loop L1
```

**7.** ★★★ **Copy a String in Reverse Order**

Write a program with a loop and indirect addressing that copies a string from source to target, reversing the character order in the process. Use the following variables:

```asm
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')
```

> 답:

```asm
.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')
.code
    mov esi,OFFSET source + SIZEOF source - 2   ; 널 바로 앞 마지막 문자
    mov edi,OFFSET target
    mov ecx,SIZEOF source - 1                   ; 널 제외한 문자 수
L1:
    mov al,[esi]
    mov [edi],al
    dec esi
    inc edi
    loop L1
    mov BYTE PTR [edi],0                        ; 널 종료 문자
```

**8.** ★★★ **Shifting the Elements in an Array**

Using a loop and indexed addressing, write code that rotates the members of a 32-bit integer array forward one position. The value at the end of the array must wrap around to the first position. For example, the array [10,20,30,40] would be transformed into [40,10,20,30].

> 답:

```asm
.data
arr DWORD 10,20,30,40
.code
    mov eax,arr[(LENGTHOF arr - 1) * TYPE arr]   ; 마지막 값 보관
    mov esi,LENGTHOF arr - 1
    mov ecx,LENGTHOF arr - 1
L1:
    mov ebx,arr[esi*4-4]                         ; 앞 원소를
    mov arr[esi*4],ebx                           ; 뒤로 이동
    dec esi
    loop L1
    mov arr,eax                                  ; 보관해 둔 값을 첫 위치에
```
