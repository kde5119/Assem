# 7.9 Review Questions and Exercises

## 7.9.1 Short Answer

**1.** In the following code sequence, show the value of AL after each shift or rotate instruction has executed:

```asm
mov al,0D4h
shr al,1                                 ; a.
mov al,0D4h
sar al,1                                 ; b.
mov al,0D4h
sar al,4                                 ; c.
mov al,0D4h
rol al,1                                 ; d.
```

> 답:
> a. 6Ah. SHR은 오른쪽으로 논리 시프트하므로 왼쪽에 0이 들어간다.
> b. EAh. SAR은 부호 비트를 유지하므로 왼쪽에 1이 들어간다.
> c. FDh. 음수인 D4h를 산술적으로 4비트 오른쪽 시프트한다.
> d. A9h. 최상위 비트가 최하위 비트로 회전한다.

**2.** In the following code sequence, show the value of AL after each shift or rotate instruction has executed:

```asm
mov al,0D4h
ror al,3                                 ; a.
mov al,0D4h
rol al,7                                 ; b.
stc
mov al,0D4h
rcl al,1                                 ; c.
stc
mov al,0D4h
rcr al,3                                 ; d.
```

> 답:
> a. 9Ah. 오른쪽으로 3비트 회전한다.
> b. 6Ah. 왼쪽으로 7비트 회전하는 것은 오른쪽으로 1비트 회전하는 것과 같다.
> c. A9h. STC로 CF=1이 되고, RCL에서 기존 CF가 AL의 최하위 비트로 들어간다.
> d. 3Ah. CF를 포함하여 오른쪽으로 3비트 회전한다.

**3.** What will be the contents of AX and DX after the following operation?

```asm
mov dx,0
mov ax,222h
mov cx,100h
mul cx
```

> 답: DX = 0002h, AX = 2200h. 222h × 100h = 22200h이고, MUL의 16비트 결과는 DX:AX에 저장된다.

**4.** What will be the contents of AX after the following operation?

```asm
mov ax,63h
mov bl,10h
div bl
```

> 답: AX = 0306h. 63h(99)를 10h(16)으로 나누면 몫은 6, 나머지는 3이다. 8비트 DIV에서 몫은 AL, 나머지는 AH에 저장된다.

**5.** What will be the contents of EAX and EDX after the following operation?

```asm
mov eax,123400h
mov edx,0
mov ebx,10h
div ebx
```

> 답: EAX = 00012340h, EDX = 00000000h. EDX:EAX를 10h로 나눈 몫이 EAX, 나머지가 EDX에 저장된다.

**6.** What will be the contents of AX and DX after the following operation?

```asm
mov ax,4000h
mov dx,500h
mov bx,10h
div bx
```

> 답: 나눗셈 오류(Divide Error)가 발생한다. DX:AX는 05004000h이고, 이를 10h로 나눈 몫은 16비트 AX에 저장할 수 있는 FFFFh보다 크다.

**7.** What will be the contents of BX after the following instructions execute?

```asm
mov bx,5
stc
mov ax,60h
adc bx,ax
```

> 답: BX = 0066h. ADC는 BX + AX + CF를 계산하므로 5 + 60h + 1 = 66h이다.

**8.** Describe the output when the following code executes in 64-bit mode:

```asm
.data
dividend_hi QWORD 00000108h
dividend_lo QWORD 33300020h
divisor     QWORD 00000100h
.code
mov rdx,dividend_hi
mov rax,dividend_lo
div divisor
```

> 답: 나눗셈 오류(Divide Error)가 발생한다. 128비트 피제수의 상위 64비트인 RDX가 108h이고 제수는 100h이다. RDX가 제수보다 크거나 같으므로 몫이 64비트 RAX에 들어가지 않는다.

**9.** The following program is supposed to subtract val2 from val1. Find and correct all logic errors (CLC clears the Carry flag):

```asm
.data
val1   QWORD 20403004362047A1h
val2   QWORD 055210304A2630B2h
result QWORD 0

.code
     mov cx,8                                ; loop counter
     mov esi,val1                            ; set index to start
     mov edi,val2
     clc                                     ; clear Carry flag
top:
     mov al,BYTE PTR[esi]                    ; get first number
     sbb al,BYTE PTR[edi]                    ; subtract second
     mov BYTE PTR[esi],al                    ; store the result
     dec esi
     dec edi
     loop top
```

> 답: mov esi,val1과 mov edi,val2는 주소가 아니라 변수의 값을 가져오므로 OFFSET을 사용해야 한다. 반복 횟수는 ECX에 넣고, 결과는 val1이 아닌 result에 저장해야 한다. 바이트 배열은 낮은 주소부터 처리하고 포인터를 증가시킨다. INC는 CF를 변경하지 않으므로 SBB의 빌림값을 유지할 수 있다.

```asm
mov ecx,8
mov esi,OFFSET val1
mov edi,OFFSET val2
mov ebx,OFFSET result
clc
top:
    mov al,[esi]
    sbb al,[edi]
    mov [ebx],al
    inc esi
    inc edi
    inc ebx
    loop top
```

**10.** What will be the hexadecimal contents of RAX after the following instructions execute in 64-bit mode?

```asm
.data
multiplicand QWORD 0001020304050000h
.code
imul rax,multiplicand,4
```

> 답: RAX = 0004080C10140000h. 0001020304050000h에 4를 곱한 결과이다.

## 7.9.2 Algorithm Workbench

**1.** Write a sequence of shift instructions that cause AX to be sign-extended into EAX. In other words, the sign bit of AX is copied into the upper 16 bits of EAX. Do not use the CWD instruction.

> 답: 먼저 EAX를 왼쪽으로 16비트 이동하여 AX를 상위 16비트로 옮긴 뒤, 산술 오른쪽 시프트로 부호를 확장한다.

```asm
shl eax,16
sar eax,16
```

**2.** Suppose the instruction set contained no rotate instructions. Show how you would use SHR and a conditional jump instruction to rotate the contents of the AL register 1 bit to the right.

> 답: SHR로 최하위 비트를 CF에 옮긴다. CF가 1이면 OR로 최상위 비트를 1로 만든다.

```asm
shr al,1
jnc L1
or al,80h
L1:
```

**3.** Write a logical shift instruction that multiplies the contents of EAX by 16.

> 답:

```asm
shl eax,4
```

**4.** Write a logical shift instruction that divides EBX by 4.

> 답:

```asm
shr ebx,2
```

**5.** Write a single rotate instruction that exchanges the high and low halves of the DL register.

> 답: 4비트 회전하면 상위 4비트와 하위 4비트가 서로 바뀐다.

```asm
rol dl,4
```

**6.** Write a single SHLD instruction that shifts the highest bit of the AX register into the lowest bit position of DX and shifts DX one bit to the left.

> 답:

```asm
shld dx,ax,1
```

**7.** Write a sequence of instructions that shift three memory bytes to the right by 1 bit position. Use the following test data:

```asm
byteArray BYTE 81h,20h,33h
```

> 답: 가장 높은 바이트부터 SHR을 수행하고, 아래 바이트로 CF를 전달하기 위해 RCR을 사용한다.

```asm
shr BYTE PTR byteArray+2,1
rcr BYTE PTR byteArray+1,1
rcr BYTE PTR byteArray,1
```

**8.** Write a sequence of instructions that shift three memory words to the left by 1 bit position. Use the following test data:

```asm
wordArray WORD 810Dh,0C064h,93ABh
```

> 답: 가장 낮은 워드부터 SHL을 수행하고, CF를 다음 워드로 전달하기 위해 RCL을 사용한다.

```asm
shl WORD PTR wordArray,1
rcl WORD PTR wordArray+2,1
rcl WORD PTR wordArray+4,1
```

**9.** Write instructions that multiply -5 by 3 and store the result in a 16-bit variable val1.

> 답: IMUL은 부호 있는 곱셈을 수행한다. AX와 BX의 곱은 DX:AX에 저장되며, 결과의 하위 16비트를 val1에 저장한다.

```asm
mov ax,-5
mov bx,3
imul bx
mov val1,ax
```

**10.** Write instructions that divide -276 by 10 and store the result in a 16-bit variable val1.

> 답: CWD로 AX의 부호를 DX까지 확장한 뒤 IDIV를 수행한다. 몫 -27을 저장한다.

```asm
mov ax,-276
cwd
mov bx,10
idiv bx
mov val1,ax
```

**11.** Implement the following C++ expression in assembly language, using 32-bit unsigned operands:

```cpp
val1 = (val2 * val3) / (val4 - 3)
```

> 답: MUL의 64비트 결과는 EDX:EAX에 저장된다. DIV는 이 값을 val4-3으로 나눈다.

```asm
mov eax,val2
mul val3
mov ebx,val4
sub ebx,3
div ebx
mov val1,eax
```

**12.** Implement the following C++ expression in assembly language, using 32-bit signed operands:

```cpp
val1 = (val2 / val3) * (val1 + val2)
```

> 답: IDIV로 나눈 몫을 EBX에 보관하고, val1+val2를 계산한 뒤 IMUL로 곱한다.

```asm
mov eax,val2
cdq
idiv val3
mov ebx,eax
mov eax,val1
add eax,val2
imul ebx
mov val1,eax
```

**13.** Write a procedure that displays an unsigned 8-bit binary value in decimal format. Pass the binary value in AL. The input range is limited to 0 to 99, decimal. The only procedure you can call from the book’s link library is WriteChar. The procedure should contain approximately eight instructions. Here is a sample call:

```asm
mov al,65                        ; range limit: 0 to 99
call showDecimal8
```

> 답: 10으로 나누어 몫은 십의 자리, 나머지는 일의 자리로 사용한다. 아래 코드는 두 자리를 출력하며 한 자리 수는 앞에 0이 붙는다.

```asm
showDecimal8 PROC
    mov ah,0
    mov bl,10
    div bl
    mov dl,ah
    add al,'0'
    call WriteChar
    mov al,dl
    add al,'0'
    call WriteChar
    ret
showDecimal8 ENDP
```

**14.** Challenge: Suppose AX contains 0072h and the Auxiliary Carry flag is set as a result of adding two unknown ASCII decimal digits. Use the Intel 64 and IA-32 Instruction Set Reference to determine what output the AAA instruction would produce. Explain your answer.

> 답: AX = 0108h. AF가 1이므로 AAA는 AL에 6을 더하고 AH에 1을 더한다. AL은 72h에서 78h가 된 뒤 하위 4비트만 남겨 08h가 된다. 따라서 AH=01h, AL=08h이다.

**15.** Challenge: Using only SUB, MOV, and AND instructions, show how to calculate x = n mod y, assuming that you are given the values of n and y. You can assume that n is any 32-bit unsigned integer, and y is a power of 2.

> 답: y가 2의 거듭제곱이면 n mod y는 n AND (y-1)로 계산할 수 있다.

```asm
mov eax,y
sub eax,1
and eax,n
mov x,eax
```

**16.** Challenge: Using only SAR, ADD, and XOR instructions (but no conditional jumps), write code that calculates the absolute value of the signed integer in the EAX register. Hints: A number can be negated by adding -1 to it and then forming its one’s complement. Also, if you XOR an integer with all 1s, its 1s are reversed. On the other hand, if you XOR an integer with all zeros, the integer is unchanged.

> 답: EAX의 부호 비트를 SAR로 확장하여 마스크를 만든다. 양수이면 마스크가 0이므로 값이 유지되고, 음수이면 -1이므로 1을 빼고 XOR하여 2의 보수 절댓값을 만든다.

```asm
mov edx,eax
sar edx,31
add eax,edx
xor eax,edx
```

참고: 가장 작은 32비트 정수인 -2147483648은 양수로 표현할 수 없으므로 비트 패턴 80000000h가 그대로 남는다.

---

## 7.10 Programming Exercises

**1.** ★ **Display ASCII Decimal**

Write a procedure named WriteScaled that outputs a decimal ASCII number with an implied decimal point. Suppose the following number were defined as follows, where DECIMAL_OFFSET indicates that the decimal point must be inserted five positions from the right side of the number:

```asm
DECIMAL_OFFSET = 5
.data
decimal_one BYTE "100123456789765"
```

WriteScaled would display the number like this:

```
1001234567.89765
```

When calling WriteScaled, pass the number’s offset in EDX, the number length in ECX, and the decimal offset in EBX. Write a test program that passes three numbers of different sizes to the WriteScaled procedure.

> 답: 오른쪽에서 EBX번째 위치 앞에 소수점을 출력한다. ECX는 문자열 길이이며, EDX는 문자열의 시작 주소이다.

```asm
.data
decimal_one   BYTE "100123456789765"
decimal_two   BYTE "12345"
decimal_three BYTE "9876"

.code
main PROC
    mov edx,OFFSET decimal_one
    mov ecx,LENGTHOF decimal_one
    mov ebx,5
    call WriteScaled
    call Crlf

    mov edx,OFFSET decimal_two
    mov ecx,LENGTHOF decimal_two
    mov ebx,2
    call WriteScaled
    call Crlf

    mov edx,OFFSET decimal_three
    mov ecx,LENGTHOF decimal_three
    mov ebx,1
    call WriteScaled
    call Crlf
    exit
main ENDP

WriteScaled PROC USES esi edi ebp
    mov esi,edx             ; 문자열 주소
    mov edi,ecx             ; 남은 문자 수
    mov ebp,ebx             ; 소수점 위치
L1:
    cmp edi,ebp
    jne L2
    mov al,'.'
    call WriteChar
L2:
    mov al,[esi]
    call WriteChar
    inc esi
    dec edi
    jnz L1
    ret
WriteScaled ENDP
```

**2.** ★★ **Extended Subtraction Procedure**

Create a procedure named Extended_Sub that subtracts two binary integers of arbitrary size. The storage size of the two integers must be the same, and their size must be a multiple of 32 bits. Write a test program that passes several pairs of integers, each at least 10 bytes long.

> 답: 낮은 주소의 DWORD부터 SBB로 빼면 CF를 통해 이전 DWORD에서 발생한 빌림값이 다음 DWORD 계산으로 전달된다. ESI는 첫 번째 수, EDI는 두 번째 수, EDX는 결과 주소, ECX는 DWORD 개수로 사용한다.

```asm
.data
num1    BYTE 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch
num2    BYTE 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h
result1 BYTE 12 DUP(?)
num3    BYTE 10h,20h,30h,40h,50h,60h,70h,80h,90h,0A0h,0B0h,0C0h
num4    BYTE 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch
result2 BYTE 12 DUP(?)

.code
main PROC
    mov esi,OFFSET num1
    mov edi,OFFSET num2
    mov edx,OFFSET result1
    mov ecx,3               ; 12바이트 = DWORD 3개
    call Extended_Sub

    mov esi,OFFSET num3
    mov edi,OFFSET num4
    mov edx,OFFSET result2
    mov ecx,3
    call Extended_Sub
    exit
main ENDP

Extended_Sub PROC
    clc
L1:
    mov eax,[esi]
    sbb eax,[edi]
    mov [edx],eax
    lea esi,[esi+4]
    lea edi,[edi+4]
    lea edx,[edx+4]
    loop L1
    ret
Extended_Sub ENDP
```

**3.** ★★ **Packed Decimal Conversion**

Write a procedure named PackedToAsc that converts a 4-byte packed decimal integer to a string of ASCII decimal digits. Pass the packed integer and the address of a buffer holding the ASCII digits to the procedure. Write a short test program that passes at least 5 packed decimal integers to your procedure.

> 답: 4바이트 packed decimal에는 10진수 8자리가 저장된다. packed 정수는 EAX로, 버퍼 주소는 EDI로 전달한다. EAX를 4비트씩 왼쪽으로 회전(ROL)하면 최상위 니블이 하위 4비트로 오므로, 이를 ASCII 문자로 변환하여 앞 자리부터 버퍼에 저장한다. 8번 반복한 뒤 널 문자를 붙인다.

```asm
.data
packed1 DWORD 12345678h
packed2 DWORD 87654321h
packed3 DWORD 00000012h
packed4 DWORD 99999999h
packed5 DWORD 00012345h
buffer  BYTE 9 DUP(0)

.code
main PROC
    mov eax,packed1
    mov edi,OFFSET buffer
    call PackedToAsc
    mov edx,OFFSET buffer
    call WriteString
    call Crlf

    mov eax,packed2
    mov edi,OFFSET buffer
    call PackedToAsc
    mov edx,OFFSET buffer
    call WriteString
    call Crlf

    mov eax,packed3
    mov edi,OFFSET buffer
    call PackedToAsc
    mov edx,OFFSET buffer
    call WriteString
    call Crlf

    mov eax,packed4
    mov edi,OFFSET buffer
    call PackedToAsc
    mov edx,OFFSET buffer
    call WriteString
    call Crlf

    mov eax,packed5
    mov edi,OFFSET buffer
    call PackedToAsc
    mov edx,OFFSET buffer
    call WriteString
    call Crlf
    exit
main ENDP

PackedToAsc PROC USES eax ecx edi
    mov ecx,8
L1:
    rol eax,4               ; 최상위 니블을 AL 하위 4비트로
    push eax
    and al,0Fh
    add al,'0'
    mov [edi],al
    pop eax
    inc edi
    loop L1
    mov BYTE PTR [edi],0
    ret
PackedToAsc ENDP
```

**4.** ★★ **Encryption Using Rotate Operations**

Write a procedure that performs simple encryption by rotating each plaintext byte a varying number of positions in different directions. For example, in the following array that represents the encryption key, a negative value indicates a rotation to the left and a positive value indicates a rotation to the right. The integer in each position indicates the magnitude of the rotation:

```asm
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
```

Your procedure should loop through a plaintext message and align the key to the first 10 bytes of the message. Rotate each plaintext byte by the amount indicated by its matching key array value. Then, align the key to the next 10 bytes of the message and repeat the process. Write a program that tests your encryption procedure by calling it twice, with different data sets.

> 답: key 값이 음수이면 왼쪽 회전, 양수이면 오른쪽 회전을 수행한다. CL에는 회전 횟수를 넣고, 10개 키를 모두 사용하면 다시 처음 키로 돌아간다.

```asm
.data
key BYTE -2,4,1,0,-3,5,2,-4,-4,6
message1 BYTE "Assembly language",0
message2 BYTE "Integer arithmetic",0

.code
main PROC
    mov esi,OFFSET message1
    mov ecx,LENGTHOF message1 - 1
    call RotateEncrypt

    mov esi,OFFSET message2
    mov ecx,LENGTHOF message2 - 1
    call RotateEncrypt
    exit
main ENDP

RotateEncrypt PROC USES ebp edi
    mov ebp,ecx             ; 처리할 문자 수
    mov edi,0               ; key 인덱스
L1:
    mov cl,key[edi]
    test cl,80h
    jz L2
    neg cl
    rol BYTE PTR [esi],cl
    jmp L3
L2:
    ror BYTE PTR [esi],cl
L3:
    inc esi
    inc edi
    cmp edi,10
    jne L4
    mov edi,0
L4:
    dec ebp
    jnz L1
    ret
RotateEncrypt ENDP
```

**5.** ★★★ **Prime Numbers**

Write a program that generates all prime numbers between 2 and 1000, using the Sieve of Eratosthenes method. You can find many articles that describe the method for finding primes in this manner on the Internet. Display all the prime values.

> 답: sieve 배열의 값을 처음에는 모두 1로 설정한다. 0과 1은 소수가 아니므로 0으로 바꾸고, 각 소수의 배수를 0으로 표시한다. 마지막에 값이 1인 인덱스만 출력한다.

```asm
.data
sieve BYTE 1001 DUP(1)

.code
main PROC
    mov sieve[0],0
    mov sieve[1],0
    mov ebx,2
OuterLoop:
    cmp ebx,31              ; sqrt(1000) 이하만 검사
    ja DoneMarking
    cmp sieve[ebx],1
    jne NextPrime
    mov eax,ebx
    imul eax,eax            ; 첫 배수는 p*p
    mov edi,eax
MarkLoop:
    cmp edi,1000
    ja NextPrime
    mov sieve[edi],0
    add edi,ebx
    jmp MarkLoop
NextPrime:
    inc ebx
    jmp OuterLoop
DoneMarking:
    mov ebx,2
PrintLoop:
    cmp ebx,1000
    ja Finished
    cmp sieve[ebx],1
    jne SkipPrint
    mov eax,ebx
    call WriteDec
    call Crlf
SkipPrint:
    inc ebx
    jmp PrintLoop
Finished:
    exit
main ENDP
```

**6.** ★★★ **Greatest Common Divisor (GCD)**

The greatest common divisor (GCD) of two integers is the largest integer that will evenly divide both integers. The GCD algorithm involves integer division in a loop, described by the following pseudocode:

```cpp
int GCD(int x, int y)
{
    x = abs(x)                              // absolute value
    y = abs(y)
    do {
        int n = x % y
        x = y
        y = n
    } while (y > 0)
    return x
}
```

Implement this function in assembly language and write a test program that calls the function several times, passing it different values. Display all results on the screen.

> 답: 유클리드 알고리즘을 사용한다. EAX와 EBX의 절댓값을 만든 뒤, EAX를 EBX로 나눈 나머지를 다음 반복의 EBX로 사용한다. EBX가 0이 되면 EAX가 최대공약수이다. 입력의 두 번째 값은 0이 아니어야 한다.

```asm
.code
main PROC
    mov eax,48
    mov ebx,18
    call GCD
    call WriteDec
    call Crlf

    mov eax,100
    mov ebx,25
    call GCD
    call WriteDec
    call Crlf

    mov eax,-84
    mov ebx,30
    call GCD
    call WriteDec
    call Crlf
    exit
main ENDP

GCD PROC
    cmp eax,0
    jge L1
    neg eax
L1:
    cmp ebx,0
    jge L2
    neg ebx
L2:
    mov edx,0
    div ebx
    mov eax,ebx
    mov ebx,edx
    cmp ebx,0
    jne L2
    ret
GCD ENDP
```

**7.** ★★★ **Bitwise Multiplication**

Write a procedure named BitwiseMultiply that multiplies any unsigned 32-bit integer by EAX, using only shifting and addition. Pass the integer to the procedure in the EBX register, and return the product in the EAX register. Write a short test program that calls the procedure and displays the product. (We will assume that the product is never larger than 32 bits.) This is a fairly challenging program to write. One possible approach is to use a loop to shift the multiplier to the right, keeping track of the number of shifts that occur before the Carry flag is set. The resulting shift count can then be applied to the SHL instruction, using the multiplicand as the destination operand. Then, the same process must be repeated until you find the last 1 bit in the multiplier.

> 답: EAX의 최하위 비트를 SHR로 CF에 이동한다. CF가 1이면 현재 EBX 값을 결과에 더한다. 이후 EBX를 왼쪽으로 한 비트 이동하고 다음 비트를 검사한다.

```asm
.code
main PROC
    mov eax,13              ; multiplier
    mov ebx,7               ; 곱할 정수
    call BitwiseMultiply
    call WriteDec
    call Crlf
    exit
main ENDP

BitwiseMultiply PROC
    mov edx,0               ; 누적 결과
    mov ecx,32
L1:
    shr eax,1               ; multiplier의 다음 비트를 CF로
    jnc L2
    add edx,ebx
L2:
    shl ebx,1               ; multiplicand를 다음 자리로
    loop L1
    mov eax,edx
    ret
BitwiseMultiply ENDP
```

호출할 때 EAX에는 multiplier, EBX에는 곱할 정수를 넣는다. 문제의 조건처럼 최종 곱이 32비트 범위에 들어간다고 가정한다.

**8.** ★★★ **Add Packed Integers**

Extend the AddPacked procedure from Section 7.6.1 so that it adds two packed decimal integers of arbitrary size (both lengths must be the same). Write a test program that passes AddPacked several pairs of integers: 4-byte, 8-byte, and 16-byte. We suggest that you use the following registers to pass information to the procedure:

```
ESI - pointer to the first number
EDI - pointer to the second number
EDX - pointer to the sum
ECX - number of bytes to add
```

> 답: packed decimal은 한 바이트에 10진수 두 자리를 저장한다. 낮은 자리 바이트부터 ADC로 더하고 DAA로 packed decimal 형태를 보정한다. DAA가 만든 CF는 다음 바이트의 ADC로 전달된다. 결과 버퍼는 최종 자리올림을 저장할 수 있도록 입력보다 1바이트 크게 준비한다.

```asm
.data
packedA    BYTE 78h,56h,34h,12h
packedB    BYTE 22h,11h,00h,01h
packedSum  BYTE 5 DUP(?)
packedA8   BYTE 99h,99h,99h,99h,99h,99h,99h,99h
packedB8   BYTE 01h,00h,00h,00h,00h,00h,00h,00h
packedSum8 BYTE 9 DUP(?)
packedA16  BYTE 16 DUP(11h)
packedB16  BYTE 16 DUP(22h)
packedSum16 BYTE 17 DUP(?)

.code
main PROC
    mov esi,OFFSET packedA
    mov edi,OFFSET packedB
    mov edx,OFFSET packedSum
    mov ecx,4
    call AddPacked

    mov esi,OFFSET packedA8
    mov edi,OFFSET packedB8
    mov edx,OFFSET packedSum8
    mov ecx,8
    call AddPacked

    mov esi,OFFSET packedA16
    mov edi,OFFSET packedB16
    mov edx,OFFSET packedSum16
    mov ecx,16
    call AddPacked
    exit
main ENDP

AddPacked PROC
    clc
L1:
    mov al,[esi]
    adc al,[edi]
    daa
    mov [edx],al
    inc esi
    inc edi
    inc edx
    loop L1
    mov al,0
    adc al,0               ; 마지막 carry 저장
    mov [edx],al
    ret
AddPacked ENDP
```

호출 시 ESI는 첫 번째 수, EDI는 두 번째 수, EDX는 결과 버퍼, ECX는 더할 바이트 수를 가리킨다.
