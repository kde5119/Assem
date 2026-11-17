# 9.9 Review Questions and Exercises

## 9.9.1 Short Answer

**1.** Which Direction flag setting causes index registers to move backward through memory when executing string primitives?

> 답: 방향 플래그가 설정된 상태(DF = 1, STD 명령어)이면 ESI와 EDI가 감소하여 높은 주소에서 낮은 주소 방향으로 이동한다.

**2.** When a repeat prefix is used with STOSW, what value is added to or subtracted from the index register?

> 답: 2. STOSW는 워드(2바이트) 단위로 저장하므로 DF = 0이면 EDI에 2를 더하고 DF = 1이면 2를 뺀다.

**3.** In what way is the CMPS instruction ambiguous?

> 답: 오퍼랜드가 명시되지 않아 어느 쪽이 source이고 어느 쪽이 target인지 헷갈리기 쉽다. 실제로는 [ESI]를 [EDI]와 비교하며, CMP [esi],[edi]를 실행한 것처럼 플래그가 설정된다.

**4.** When the Direction flag is clear and SCASB has found a matching character, where does EDI point?

> 답: 일치한 문자의 바로 다음 위치(일치한 문자 + 1)를 가리킨다. 그래서 일치한 문자의 주소가 필요하면 dec edi로 되돌려야 한다.

**5.** When scanning an array for the first occurrence of a particular character, which repeat prefix would be best?

> 답: REPNE(REPNZ). 값이 같지 않은 동안 반복하다가 처음 일치하는 문자를 만나면 멈춘다.

**6.** What Direction flag setting is used in the Str_trim procedure from Section 9.3?

> 답: 방향 플래그를 설정하지 않는다. Str_trim은 문자열 기본 명령어를 쓰지 않고 dec edi로 직접 뒤로 이동한다. 뒤로 이동한다는 점에서 DF = 1(STD)과 같은 방향이다.

**7.** Why does the Str_trim procedure from Section 9.3 use the JNE instruction?

> 답: 문자열 끝에서부터 거꾸로 검사하다가 제거할 문자가 아닌 첫 문자를 만나면 반복을 멈추기 위해서이다. 그 위치(L2)로 점프하여 바로 뒤에 널 바이트를 넣는다.

**8.** What happens in the Str_ucase procedure from Section 9.3 if the target string contains a digit?

> 답: 아무 변화가 없다. 숫자의 ASCII 코드(30h~39h)는 'a'(61h)보다 작아서 JB로 변환을 건너뛴다.

**9.** If the Str_length procedure from Section 9.3 used SCASB, which repeat prefix would be most appropriate?

> 답: REPNE. AL = 0으로 두고 널 바이트와 같아질 때까지 반복한다.

**10.** If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and return the string length?

> 답: ECX를 최댓값(0FFFFFFFFh)으로 두고 널 바이트를 찾을 때까지 스캔한다. 널 바이트까지 (길이 + 1)번 스캔하므로 ECX = 0FFFFFFFEh - 길이가 되고, 길이 = 0FFFFFFFEh - ECX를 EAX로 반환한다.

```asm
mov edi,pString
mov al,0                    ; 찾을 문자: 널 바이트
mov ecx,0FFFFFFFFh          ; 최대 검색 횟수
cld
repne scasb                 ; 널 바이트를 찾을 때까지 반복
mov eax,0FFFFFFFEh
sub eax,ecx                 ; EAX = 문자열 길이
```

**11.** What is the maximum number of comparisons needed by the binary search algorithm when an array contains 1,024 elements?

> 답: 10번. 비교할 때마다 검색 범위가 절반으로 줄어들고 log2(1024) = 10이다. (교재 Table 9-6 기준)

**12.** In the FillArray procedure from the Binary Search example in Section 9.5, why must the Direction flag be cleared by the CLD instruction?

> 답: STOSD가 EDI를 DF에 따라 증가 또는 감소시키기 때문이다. DF = 0이어야 EDI가 배열의 앞에서 뒤로 증가하며 채워지고, DF = 1이면 배열 앞쪽의 메모리를 덮어쓰게 된다.

**13.** In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be removed without affecting the outcome?

> 답: L2의 cmp edx,edi는 바로 앞에서 실행한 cmp edx,edi와 같은 비교이다. 그 사이의 JGE는 플래그를 바꾸지 않으므로 이전 비교의 플래그가 그대로 남아 있어 JLE가 그 플래그를 그대로 쓸 수 있다.

**14.** In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be eliminated?

> 답: L4는 jmp L1이다. L4로 점프하던 두 jmp L4를 jmp L1로 바꾸면 L4 문장이 필요 없다.

## 9.9.2 Algorithm Workbench

**1.** Show an example of a base-index operand in 32-bit mode.

> 답: 두 레지스터를 더한 주소를 사용한다.

```asm
mov al,[ebx + esi]
```

**2.** Show an example of a base-index-displacement operand in 32-bit mode.

> 답: 배열 이름(변위)에 베이스와 인덱스 레지스터를 더한다.

```asm
mov eax,tableD[ebx + esi*TYPE tableD]
```

**3.** Suppose a two-dimensional array of doublewords has three logical rows and four logical columns. Write an expression using ESI and EDI that addresses the third column in the second row. (Numbering for rows and columns starts at zero.)

> 답: ESI에는 두 번째 행의 오프셋(1 × 4열 × 4바이트 = 16), EDI에는 세 번째 열의 인덱스(2)를 넣고 [esi + edi*4]로 접근한다.

```asm
mov esi,OFFSET myArray
add esi,16                   ; 두 번째 행의 시작 주소
mov edi,2                    ; 세 번째 열의 인덱스
mov eax,[esi + edi*4]        ; 배열의 세 번째 열
```

**4.** Write instructions using CMPSW that compare two arrays of 16-bit values named sourcew and targetw.

> 답: DF를 지우고 REPE CMPSW로 값이 같은 동안 비교한다. 끝난 뒤 ZF = 1이면 두 배열이 같다.

```asm
cld
mov esi,OFFSET sourcew
mov edi,OFFSET targetw
mov ecx,LENGTHOF sourcew
repe cmpsw
```

**5.** Write instructions that use SCASW to scan for the 16-bit value 0100h in an array named wordArray, and copy the offset of the matching member into the EAX register.

> 답: REPNE SCASW로 검색한다. 일치하면 EDI가 일치한 원소의 다음 위치를 가리키므로 2를 빼서 EAX에 복사한다.

```asm
cld
mov edi,OFFSET wordArray
mov ax,0100h
mov ecx,LENGTHOF wordArray
repne scasw
jnz notFound                ; 못 찾음
sub edi,2                   ; 일치한 원소로 되돌림
mov eax,edi                 ; 일치한 원소의 오프셋
notFound:
```

**6.** Write a sequence of instructions that use the Str_compare procedure to determine the larger of two input strings and write it to the console window.

> 답: Str_compare는 CMP처럼 플래그를 설정한다. JA로 string1 > string2이면 string1을, 아니면 string2를 출력한다.

```asm
.data
string1 BYTE "Apple",0
string2 BYTE "Banana",0
.code
    INVOKE Str_compare, ADDR string1, ADDR string2
    ja L1                       ; string1 > string2
    mov edx,OFFSET string2
    jmp L2
L1: mov edx,OFFSET string1
L2: call WriteString
    call Crlf
```

**7.** Show how to call the Str_trim procedure and remove all trailing "@" characters from a string.

> 답:

```asm
INVOKE Str_trim, ADDR myString, '@'
```

**8.** Show how to modify the Str_ucase procedure from the Irvine32 library so it changes all characters to lower case.

> 답: 검사 범위를 'A'~'Z'로 바꾸고, 비트 5를 AND로 지우는 대신 OR로 1로 설정한다.

```asm
Str_lcase PROC USES eax esi,
    pString:PTR BYTE
    mov esi,pString
L1:
    mov al,[esi]
    cmp al,0                    ; 문자열 끝?
    je L3
    cmp al,'A'
    jb L2
    cmp al,'Z'
    ja L2
    or BYTE PTR [esi],00100000b ; 소문자로 변환
L2: inc esi
    jmp L1
L3: ret
Str_lcase ENDP
```

**9.** Create a 64-bit version of the Str_trim procedure.

> 답: Irvine64 방식으로 스택 매개변수 대신 레지스터를 사용한다. RCX는 문자열 주소, DL은 제거할 문자이다. Str_length(64비트)는 RCX로 주소를 받고 RAX로 길이를 반환한다.

```asm
Str_trim PROC USES rbx rdi
    mov rdi,rcx
    mov bl,dl                   ; 제거할 문자 보관s
    call Str_length             ; RAX = 문자열 길이
    cmp rax,0
    je L3                       ; 빈 문자열
    mov rcx,rax
    dec rax
    add rdi,rax                 ; 마지막 문자를 가리킴
L1:
    mov al,[rdi]
    cmp al,bl                   ; 제거할 문자인가?
    jne L2
    dec rdi
    loop L1
L2:
    mov BYTE PTR [rdi+1],0      ; 널 바이트 삽입
L3:
    ret
Str_trim ENDP
```

**10.** Show an example of a base-index operand in 64-bit mode.

> 답: 64비트 모드에서는 64비트 레지스터를 사용해야 한다.

```asm
mov rax,[rbx + rsi]
```

**11.** Assuming that EBX contains a row index into a two-dimensional array of 32-bit integers named myArray and EDI contains the index of a column, write a single statement that moves the content of the given array element into the EAX register.

> 답: 배열 이름을 변위로, EBX를 행 오프셋(행 번호 × 행 크기)으로, EDI를 열 인덱스로 사용하고 32비트 정수이므로 TYPE(4)을 곱한다.

```asm
mov eax,myArray[ebx + edi*TYPE myArray]
```

**12.** Assuming that RBX contains a row index into a two-dimensional array of 64-bit integers named myArray and RDI contains the index of a column, write a single statement that moves the content of the given array element into the RAX register.

> 답: 64비트 정수이므로 TYPE은 8이다.

```asm
mov rax,myArray[rbx + rdi*TYPE myArray]
```

---

## 9.10 Programming Exercises

The following exercises can be done in either 32-bit mode or 64-bit mode. Each string-handling procedure assumes the use of null-terminated strings. Even when not explicitly requested, write a short driver program for each exercise solution that tests your new procedure.

**1.** ★ **Improved Str_copy Procedure**

The Str_copy procedure shown in this chapter does not limit the number of characters to be copied. Create a new version (named Str_copyN) that receives an additional input parameter indicating the maximum number of characters to be copied.

> 답: 원본 길이와 최대 문자 수 중 작은 값만큼 복사하고 널 바이트를 붙인다. 대상 버퍼는 최대 문자 수 + 1바이트 이상이어야 한다. 출력 결과는 Assembly이다.

```asm
Str_copyN PROTO,
    source:PTR BYTE,
    target:PTR BYTE,
    maxChars:DWORD

.data
src BYTE "Assembly Language",0
dst BYTE 20 DUP(?)

.code
main PROC
    INVOKE Str_copyN, ADDR src, ADDR dst, 8
    mov edx,OFFSET dst
    call WriteString
    call Crlf
    exit
main ENDP

Str_copyN PROC USES eax ecx esi edi,
    source:PTR BYTE,
    target:PTR BYTE,
    maxChars:DWORD
    INVOKE Str_length, source   ; EAX = 원본 길이
    mov ecx,maxChars
    cmp eax,ecx
    jae L1                      ; 원본이 더 길면 maxChars만 복사
    mov ecx,eax                 ; 원본이 더 짧으면 원본 길이만큼
L1:
    mov esi,source
    mov edi,target
    cld
    rep movsb                   ; ECX = 0이면 복사하지 않음
    mov BYTE PTR [edi],0        ; 널 바이트 추가
    ret
Str_copyN ENDP
```

**2.** ★★ **Str_concat Procedure**

Write a procedure named Str_concat that concatenates a source string to the end of a target string. Sufficient space must exist in the target string to accommodate the new characters. Pass pointers to the source and target strings. Here is a sample call:

```asm
.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0
.code
INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
```

> 답: target의 널 바이트 위치를 구한 뒤, source를 널 바이트까지 그 위치에 복사한다. 출력 결과는 ABCDEFGH이다.

```asm
Str_concat PROTO,
    pTarget:PTR BYTE,
    pSource:PTR BYTE

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code
main PROC
    INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
    mov edx,OFFSET targetStr
    call WriteString
    call Crlf
    exit
main ENDP

Str_concat PROC USES eax ecx esi edi,
    pTarget:PTR BYTE,
    pSource:PTR BYTE
    INVOKE Str_length, pTarget
    mov edi,pTarget
    add edi,eax                 ; EDI = target의 널 바이트 위치
    INVOKE Str_length, pSource
    mov ecx,eax
    inc ecx                     ; 널 바이트까지 복사
    mov esi,pSource
    cld
    rep movsb
    ret
Str_concat ENDP
```

**3.** ★★ **Str_remove Procedure**

Write a procedure named Str_remove that removes n characters from a string. Pass a pointer to the position in the string where the characters are to be removed. Pass an integer specifying the number of characters to remove. The following code, for example, shows how to remove “xxxx” from target:

```asm
.data
target BYTE "abcxxxxdefghijklmop",0
.code
INVOKE Str_remove, ADDR [target+3], 4
```

> 답: 삭제 위치 + n부터 널 바이트까지를 삭제 위치로 앞당겨 복사한다. 남은 길이가 n 이하이면 그 위치에 널 바이트만 넣는다. 출력 결과는 abcdefghijklmop이다.

```asm
Str_remove PROTO,
    pStart:PTR BYTE,
    nChars:DWORD

.data
target BYTE "abcxxxxdefghijklmop",0

.code
main PROC
    INVOKE Str_remove, ADDR [target+3], 4
    mov edx,OFFSET target
    call WriteString
    call Crlf
    exit
main ENDP

Str_remove PROC USES eax ecx esi edi,
    pStart:PTR BYTE,
    nChars:DWORD
    INVOKE Str_length, pStart   ; EAX = 삭제 위치부터 남은 길이
    mov edi,pStart
    mov ecx,nChars
    cmp ecx,eax
    jb L1                       ; n < 남은 길이
    mov BYTE PTR [edi],0        ; 남은 문자를 모두 삭제
    jmp L2
L1:
    mov esi,edi
    add esi,ecx                 ; ESI = 삭제 구간 바로 뒤
    sub eax,ecx                 ; 남는 문자 수
    inc eax                     ; 널 바이트 포함
    mov ecx,eax
    cld
    rep movsb                   ; 앞으로 당겨 복사
L2: ret
Str_remove ENDP
```

**4.** ★★★ **Str_find Procedure**

Write a procedure named Str_find that searches for the first matching occurrence of a source string inside a target string and returns the matching position. The input parameters should be a pointer to the source string and a pointer to the target string. If a match is found, the procedure sets the Zero flag and EAX points to the matching position in the target string. Otherwise, the Zero flag is clear and EAX is undefined. The following code, for example, searches for “ABC” and returns with EAX pointing to the “A” in the target string:

```asm
.data
target BYTE "123ABC342432",0
source BYTE "ABC",0
pos    DWORD ?
.code
INVOKE Str_find, ADDR source, ADDR target
jnz notFound
mov pos,eax                  ; store the position value
```

> 답: target의 각 시작 위치(0부터 target 길이 - source 길이까지)에서 REPE CMPSB로 source 길이만큼 비교한다. 일치하면 EAX에 그 위치를 넣고 ZF를 1로, 못 찾으면 ZF를 0으로 만든다. source는 빈 문자열이 아니라고 가정한다. 출력 결과는 ABC342432이다.

```asm
Str_find PROTO,
    pSource:PTR BYTE,
    pTarget:PTR BYTE

.data
target BYTE "123ABC342432",0
source BYTE "ABC",0
pos    DWORD ?

.code
main PROC
    INVOKE Str_find, ADDR source, ADDR target
    jnz notFound
    mov pos,eax                 ; 일치 위치 (target + 3)
    mov edx,eax
    call WriteString
    call Crlf
notFound:
    exit
main ENDP

Str_find PROC USES ebx ecx edx esi edi,
    pSource:PTR BYTE,
    pTarget:PTR BYTE
    INVOKE Str_length, pSource
    mov edx,eax                 ; EDX = source 길이
    INVOKE Str_length, pTarget
    sub eax,edx                 ; 마지막 시작 위치 = target 길이 - source 길이
    jb NotFound                 ; source가 더 길면 실패
    inc eax                     ; EAX = 시작 가능한 위치 수
    mov ebx,pTarget             ; EBX = 현재 비교 시작 위치
L1:
    mov esi,pSource
    mov edi,ebx
    mov ecx,edx                 ; source 길이만큼 비교
    cld
    repe cmpsb
    je Found                    ; 모두 일치 (ZF = 1)
    inc ebx                     ; 다음 위치
    dec eax
    jnz L1
NotFound:
    or eax,1                    ; ZF = 0
    ret
Found:
    mov eax,ebx                 ; 일치한 위치
    cmp eax,eax                 ; ZF = 1 보장
    ret
Str_find ENDP
```

**5.** ★★ **Str_nextWord Procedure**

Write a procedure called Str_nextWord that scans a string for the first occurrence of a certain delimiter character and replaces the delimiter with a null byte. There are two input parameters: a pointer to the string and the delimiter character. After the call, if the delimiter was found, the Zero flag is set and EAX contains the offset of the next character beyond the delimiter. Otherwise, the Zero flag is clear and EAX is undefined. The following example code passes the address of target and a comma as the delimiter:

```asm
.data
target BYTE "Johnson,Calvin",0
.code
INVOKE Str_nextWord, ADDR target, ','
jnz notFound
```

In Figure 9-5, after calling Str_nextWord, EAX points to the character following the position where the comma was found (and replaced).

> 답: 문자열을 앞에서부터 검사하여 구분 문자를 만나면 널 바이트로 바꾸고, 다음 문자의 주소를 EAX에 넣고 ZF = 1로 반환한다. 널 바이트까지 못 찾으면 ZF = 0으로 반환한다. 출력 결과는 Johnson, Calvin이다.

```asm
Str_nextWord PROTO,
    pString:PTR BYTE,
    delimiter:BYTE

.data
target BYTE "Johnson,Calvin",0

.code
main PROC
    INVOKE Str_nextWord, ADDR target, ','
    jnz notFound
    mov edx,OFFSET target
    call WriteString            ; Johnson
    call Crlf
    mov edx,eax
    call WriteString            ; Calvin
    call Crlf
notFound:
    exit
main ENDP

Str_nextWord PROC USES ebx esi,
    pString:PTR BYTE,
    delimiter:BYTE
    mov esi,pString
    mov bl,delimiter
L1:
    mov al,[esi]
    cmp al,0
    je NotFound                 ; 문자열 끝: 구분 문자 없음
    cmp al,bl
    je Found
    inc esi
    jmp L1
Found:
    mov BYTE PTR [esi],0        ; 구분 문자를 널 바이트로 교체
    lea eax,[esi+1]             ; 다음 문자의 주소
    cmp eax,eax                 ; ZF = 1
    ret
NotFound:
    or eax,1                    ; ZF = 0
    ret
Str_nextWord ENDP
```

**6.** ★★ **Constructing a Frequency Table**

Write a procedure named Get_frequencies that constructs a character frequency table. Input to the procedure should be a pointer to a string and a pointer to an array of 256 doublewords initialized to all zeros. Each array position is indexed by its corresponding ASCII code. When the procedure returns, each entry in the array contains a count of how many times the corresponding character occurred in the string. For example,

```asm
.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
.code
INVOKE Get_frequencies, ADDR target, ADDR freqTable
```

> 답: 각 문자의 ASCII 코드를 인덱스로 하여 freqTable의 해당 DWORD를 1씩 증가시킨다. A~F의 개수를 출력하면 2 3 2 1 1 1이다.

```asm
Get_frequencies PROTO,
    pString:PTR BYTE,
    pFreqTable:PTR DWORD

.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)

.code
main PROC
    INVOKE Get_frequencies, ADDR target, ADDR freqTable
    mov esi,OFFSET freqTable + 41h * 4   ; 'A'(41h)의 항목
    mov ecx,6                            ; A~F
L1:
    mov eax,[esi]
    call WriteDec
    mov al,' '
    call WriteChar
    add esi,4
    loop L1
    call Crlf
    exit
main ENDP

Get_frequencies PROC USES eax ebx esi,
    pString:PTR BYTE,
    pFreqTable:PTR DWORD
    mov esi,pString
    mov ebx,pFreqTable
L1:
    movzx eax,BYTE PTR [esi]    ; 문자의 ASCII 코드
    cmp eax,0
    je L2                       ; 문자열 끝
    inc DWORD PTR [ebx + eax*4] ; 해당 문자의 횟수 증가
    inc esi
    jmp L1
L2: ret
Get_frequencies ENDP
```

**7.** ★★★ **Sieve of Eratosthenes**

The Sieve of Eratosthenes, invented by the Greek mathematician of the same name, provides a quick way to find all prime numbers within a given range. The algorithm involves creating an array of bytes in which positions are “marked” by inserting 1s in the following manner: Beginning with position 2 (which is a prime number), insert a 1 in each array position that is a multiple of 2. Then do the same thing for multiples of 3, the next prime number. Find the next prime number after 3, which is 5, and mark all positions that are multiples of 5. Proceed in this manner until all multiples of primes have been found. The remaining positions of the array that are unmarked indicate which numbers are prime. For this program, create a 65,000-element array and display all primes between 2 and 65,000. Declare the array in an uninitialized data segment (see Section 3.4.11) and use STOSB to fill it with zeros.

> 답: .data?에 배열을 선언하고 REP STOSB로 0으로 채운다. 소수 p마다 p × p부터 p씩 증가하며 1로 표시한다(p × p가 65000을 넘으면 표시 끝). 마지막에 값이 0인 인덱스를 출력한다.

```asm
MAX_NUM = 65000

.data?
sieve BYTE MAX_NUM + 1 DUP(?)

.code
main PROC
    mov edi,OFFSET sieve
    mov ecx,MAX_NUM + 1
    mov al,0
    cld
    rep stosb                   ; 배열을 0으로 채움

    mov ebx,2                   ; 소수 후보 p
L1:
    mov eax,ebx
    imul eax,ebx                ; p * p
    cmp eax,MAX_NUM
    ja Print                    ; p * p > MAX_NUM: 표시 끝
    cmp sieve[ebx],0
    jne Next                    ; 이미 합성수
    mov esi,eax                 ; 첫 배수는 p * p
Mark:
    mov sieve[esi],1            ; 배수 표시
    add esi,ebx
    cmp esi,MAX_NUM
    jbe Mark
Next:
    inc ebx
    jmp L1

Print:
    mov ebx,2
L2:
    cmp sieve[ebx],0
    jne Skip                    ; 표시된 수는 건너뜀
    mov eax,ebx
    call WriteDec               ; 소수 출력
    mov al,' '
    call WriteChar
Skip:
    inc ebx
    cmp ebx,MAX_NUM
    jbe L2
    call Crlf
    exit
main ENDP
```

**8.** ★ **Bubble Sort**

Add a variable to the BubbleSort procedure in Section 9.5.1 that is set to 1 whenever a pair of values is exchanged within the inner loop. Use this variable to exit the sort before its normal completion if you discover that no exchanges took place during a complete pass through the array. (This variable is commonly known as an exchange flag.)

> 답: LOCAL 변수 swapped를 매 패스 시작 때 0으로 두고 교환할 때 1로 바꾼다. 패스가 끝났을 때 0이면 정렬이 끝난 것이므로 바로 종료한다. 같은 값은 교환하지 않도록 jg 대신 jge를 사용했다. 출력 결과는 +1 +2 +3 +4 +5 +6이다.

```asm
BubbleSort PROTO,
    pArray:PTR DWORD,
    Count:DWORD

.data
array DWORD 3,1,2,4,5,6         ; 두 번째 패스에서 교환이 없어 조기 종료됨

.code
main PROC
    INVOKE BubbleSort, ADDR array, LENGTHOF array
    mov esi,OFFSET array
    mov ecx,LENGTHOF array
L1:
    mov eax,[esi]
    call WriteInt
    mov al,' '
    call WriteChar
    add esi,4
    loop L1
    call Crlf
    exit
main ENDP

BubbleSort PROC USES eax ecx esi,
    pArray:PTR DWORD,
    Count:DWORD
    LOCAL swapped:BYTE          ; 교환 플래그
    mov ecx,Count
    dec ecx                     ; 바깥 루프 횟수 = Count - 1
L1: push ecx                    ; 바깥 루프 횟수 저장
    mov swapped,0               ; 이번 패스의 플래그 초기화
    mov esi,pArray
L2: mov eax,[esi]
    cmp [esi+4],eax
    jge L3                      ; 순서가 맞으면 교환하지 않음
    xchg eax,[esi+4]
    mov [esi],eax
    mov swapped,1               ; 교환 발생
L3: add esi,4
    loop L2                     ; 안쪽 루프
    pop ecx
    cmp swapped,0
    je L4                       ; 교환이 없었으면 조기 종료
    loop L1
L4: ret
BubbleSort ENDP
```

**9.** ★★ **Binary Search**

Rewrite the binary search procedure shown in this chapter by using registers for mid, first, and last. Add comments to clarify the registers’ usage.

> 답: LOCAL 변수 대신 first는 ESI, last는 EDI, mid는 EAX를 사용한다. 출력 결과는 +3, -1이다.

```asm
BinarySearch PROTO,
    pArray:PTR DWORD,
    Count:DWORD,
    searchVal:DWORD

.data
array DWORD 10,20,30,40,50,60

.code
main PROC
    INVOKE BinarySearch, ADDR array, LENGTHOF array, 40
    call WriteInt               ; +3
    call Crlf
    INVOKE BinarySearch, ADDR array, LENGTHOF array, 35
    call WriteInt               ; -1
    call Crlf
    exit
main ENDP

; 레지스터 사용
;   EBX = 배열 시작 주소      EDX = searchVal (찾는 값)
;   ESI = first               EDI = last
;   EAX = mid (반환값)        ECX = values[mid]
BinarySearch PROC USES ebx ecx edx esi edi,
    pArray:PTR DWORD,
    Count:DWORD,
    searchVal:DWORD
    mov ebx,pArray
    mov edx,searchVal
    mov esi,0                   ; first = 0
    mov edi,Count
    dec edi                     ; last = Count - 1
L1:
    cmp esi,edi
    jg NotFound                 ; first > last: 실패
    lea eax,[esi + edi]
    shr eax,1                   ; mid = (first + last) / 2
    mov ecx,[ebx + eax*4]       ; ECX = values[mid]
    cmp ecx,edx
    jl GoRight                  ; values[mid] < searchVal
    jg GoLeft                   ; values[mid] > searchVal
    jmp Done                    ; 같음: EAX = mid
GoRight:
    lea esi,[eax+1]             ; first = mid + 1
    jmp L1
GoLeft:
    lea edi,[eax-1]             ; last = mid - 1
    jmp L1
NotFound:
    mov eax,-1
Done:
    ret
BinarySearch ENDP
```

**10.** ★★★ **Letter Matrix**

Create a procedure that generates a four-by-four matrix of randomly chosen capital letters. When choosing the letters, there must be a 50% probability that the chosen letter is a vowel. Write a test program with a loop that calls your procedure five times and displays each matrix in the console window. Following is sample output for the first three matrices:

```
D W A L
S I V W
U I O L
L A I I

K X S V
N U U O
O R Q O
A U U T

P O A Z
A E A U
G K A E
I A G D
```

> 답: RandomRange(2)가 0이면 모음("AEIOU") 중에서, 1이면 자음(나머지 21글자) 중에서 하나를 무작위로 고른다. 이렇게 하면 모음이 될 확률이 50%이다. MakeMatrix가 16칸을 채우고 ShowMatrix가 4 × 4로 출력한다.

```asm
MakeMatrix PROTO, pMatrix:PTR BYTE
ShowMatrix PROTO, pMatrix:PTR BYTE

.data
vowels     BYTE "AEIOU"
consonants BYTE "BCDFGHJKLMNPQRSTVWXYZ"
matrix     BYTE 16 DUP(?)

.code
main PROC
    call Randomize
    mov ecx,5                   ; 5번 반복
L1:
    INVOKE MakeMatrix, ADDR matrix
    INVOKE ShowMatrix, ADDR matrix
    call Crlf
    loop L1
    exit
main ENDP

MakeMatrix PROC USES eax ebx ecx esi,
    pMatrix:PTR BYTE
    mov esi,pMatrix
    mov ecx,16
L1:
    mov eax,2
    call RandomRange            ; 0 또는 1 (각 50%)
    cmp eax,0
    jne Cons
    mov eax,LENGTHOF vowels     ; 5
    call RandomRange
    mov bl,vowels[eax]          ; 모음
    jmp Store
Cons:
    mov eax,LENGTHOF consonants ; 21
    call RandomRange
    mov bl,consonants[eax]      ; 자음
Store:
    mov [esi],bl
    inc esi
    loop L1
    ret
MakeMatrix ENDP

ShowMatrix PROC USES eax ebx ecx esi,
    pMatrix:PTR BYTE
    mov esi,pMatrix
    mov ebx,4                   ; 행 수
L1:
    mov ecx,4                   ; 열 수
L2:
    mov al,[esi]
    call WriteChar
    mov al,' '
    call WriteChar
    inc esi
    loop L2
    call Crlf
    dec ebx
    jnz L1
    ret
ShowMatrix ENDP
```

**11.** ★★★★ **Letter Matrix/Sets with Vowels**

Use the letter matrix generated in the previous programming exercise as a starting point for this program. Generate a single random four-by-four letter matrix in which each letter has a 50% probability of being a vowel. Traverse each matrix row, column, and diagonal, generating sets of letters. Display only four-letter sets containing exactly two vowels. Suppose, for example, the following matrix was generated:

```
P O A Z
A E A U
G K A E
I A G D
```

Then the four-letter sets displayed by the program would be POAZ, GKAE, IAGD, PAGI, ZUED, PEAD, and ZAKI. The order of letters within each set is unimportant.

> 답: 10번의 MakeMatrix, ShowMatrix, 데이터를 그대로 사용한다. 4글자 집합은 (시작 인덱스, 간격)으로 정한다: 행은 (4행, 1), 열은 (열, 4), 주대각선은 (0, 5), 반대 대각선은 (3, 3)이다. CheckSet이 4글자를 모으면서 모음 개수를 세고, 정확히 2개일 때만 출력한다.

```asm
CheckSet PROTO,
    pMatrix:PTR BYTE,
    startIdx:DWORD,
    stepIdx:DWORD

.code
main PROC
    call Randomize
    INVOKE MakeMatrix, ADDR matrix
    INVOKE ShowMatrix, ADDR matrix
    call Crlf

    mov ebx,0                   ; 행 4개
Rows:
    imul eax,ebx,4
    INVOKE CheckSet, ADDR matrix, eax, 1
    inc ebx
    cmp ebx,4
    jb Rows

    mov ebx,0                   ; 열 4개
Cols:
    INVOKE CheckSet, ADDR matrix, ebx, 4
    inc ebx
    cmp ebx,4
    jb Cols

    INVOKE CheckSet, ADDR matrix, 0, 5   ; 주대각선
    INVOKE CheckSet, ADDR matrix, 3, 3   ; 반대 대각선
    call Crlf
    exit
main ENDP

CheckSet PROC USES eax ebx ecx edx esi edi,
    pMatrix:PTR BYTE,
    startIdx:DWORD,
    stepIdx:DWORD
    LOCAL setBuf[5]:BYTE        ; 4글자 + 널
    lea edi,setBuf
    mov esi,pMatrix
    add esi,startIdx            ; 첫 글자 위치
    mov ecx,4
    mov ebx,0                   ; 모음 개수
L1:
    mov al,[esi]
    mov [edi],al                ; 집합에 글자 추가
    inc edi
    cmp al,'A'
    je V
    cmp al,'E'
    je V
    cmp al,'I'
    je V
    cmp al,'O'
    je V
    cmp al,'U'
    jne NotV
V:  inc ebx
NotV:
    add esi,stepIdx             ; 다음 글자
    loop L1
    cmp ebx,2
    jne Done                    ; 모음이 정확히 2개가 아니면 출력 안 함
    mov BYTE PTR [edi],0
    lea edx,setBuf
    call WriteString
    mov al,' '
    call WriteChar
Done:
    ret
CheckSet ENDP
```

**12.** ★★★★ **Calculating the Sum of an Array Row**

Write a procedure named calc_row_sum that calculates the sum of a single row in a two-dimensional array of bytes, words, or doublewords. The procedure should have the following stack parameters: array offset, row size, array type, row index. It must return the sum in EAX. Use explicit stack parameters, not INVOKE or extended PROC. Write a program that tests your procedure with arrays of byte, word, and doubleword. Prompt the user for the row index, and display the sum of the selected row.

> 답: 매개변수를 배열 오프셋, 행 크기(바이트), 배열 타입(1, 2, 4), 행 인덱스 순서로 push한다. 따라서 [ebp+20] = 배열 오프셋, [ebp+16] = 행 크기, [ebp+12] = 타입, [ebp+8] = 행 인덱스이다. 행 시작 주소 = 오프셋 + 행 인덱스 × 행 크기이고, 한 행의 원소 수 = 행 크기 / 타입이다. 행 인덱스 1을 입력하면 합은 26, 2600, 26000이다.

```asm
.data
byteTable BYTE 1,2,3,4
ByteRowSize = ($ - byteTable)
          BYTE 5,6,7,8
          BYTE 9,10,11,12

wordTable WORD 100,200,300,400
WordRowSize = ($ - wordTable)
          WORD 500,600,700,800
          WORD 900,1000,1100,1200

dwordTable DWORD 1000,2000,3000,4000
DwordRowSize = ($ - dwordTable)
           DWORD 5000,6000,7000,8000
           DWORD 9000,10000,11000,12000

prompt  BYTE "Row index (0-2): ",0
msgByte  BYTE "Byte row sum: ",0
msgWord  BYTE "Word row sum: ",0
msgDword BYTE "Doubleword row sum: ",0

.code
main PROC
    mov edx,OFFSET prompt
    call WriteString
    call ReadDec                ; EAX = 행 인덱스
    mov ebx,eax

    mov edx,OFFSET msgByte
    call WriteString
    push OFFSET byteTable       ; 배열 오프셋
    push ByteRowSize            ; 행 크기(바이트)
    push TYPE byteTable         ; 배열 타입
    push ebx                    ; 행 인덱스
    call calc_row_sum
    call WriteDec
    call Crlf

    mov edx,OFFSET msgWord
    call WriteString
    push OFFSET wordTable
    push WordRowSize
    push TYPE wordTable
    push ebx
    call calc_row_sum
    call WriteDec
    call Crlf

    mov edx,OFFSET msgDword
    call WriteString
    push OFFSET dwordTable
    push DwordRowSize
    push TYPE dwordTable
    push ebx
    call calc_row_sum
    call WriteDec
    call Crlf
    exit
main ENDP

calc_row_sum PROC
    push ebp
    mov ebp,esp
    push ebx
    push ecx
    push edx
    push esi
    mov ebx,[ebp+20]            ; 배열 오프셋
    mov eax,[ebp+8]             ; 행 인덱스
    mul DWORD PTR [ebp+16]      ; EAX = 행 인덱스 * 행 크기
    add ebx,eax                 ; EBX = 선택한 행의 시작 주소
    mov eax,[ebp+16]
    mov edx,0
    div DWORD PTR [ebp+12]      ; EAX = 행 크기 / 타입 = 원소 수
    mov ecx,eax                 ; 반복 횟수
    mov esi,0                   ; 열 인덱스
    mov eax,0                   ; 합계
    cmp DWORD PTR [ebp+12],1
    je ByteLoop
    cmp DWORD PTR [ebp+12],2
    je WordLoop
DwordLoop:
    add eax,[ebx + esi*4]
    inc esi
    loop DwordLoop
    jmp Done
WordLoop:
    movzx edx,WORD PTR [ebx + esi*2]
    add eax,edx
    inc esi
    loop WordLoop
    jmp Done
ByteLoop:
    movzx edx,BYTE PTR [ebx + esi]
    add eax,edx
    inc esi
    loop ByteLoop
Done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret 16                      ; 매개변수 4개(16바이트) 정리
calc_row_sum ENDP
```

**13.** ★★★ **Trimming Leading Characters**

Create a variant of the Str_trim procedure that lets the caller remove all instances of a leading character from a string. For example, if you were to call it with a pointer to the string “###ABC” and pass it the # character, the resulting string would be “ABC.”

> 답: 제거할 문자가 아닌 첫 문자의 위치를 찾은 뒤, 거기서부터 널 바이트까지를 문자열 시작으로 앞당겨 복사한다. 제거할 문자가 문자열 전체이면 널 바이트에서 멈추므로 빈 문자열이 된다. 출력 결과는 ABC이다.

```asm
Str_trimLeading PROTO,
    pString:PTR BYTE,
    char:BYTE

.data
str1 BYTE "###ABC",0

.code
main PROC
    INVOKE Str_trimLeading, ADDR str1, '#'
    mov edx,OFFSET str1
    call WriteString
    call Crlf
    exit
main ENDP

Str_trimLeading PROC USES eax ecx esi edi,
    pString:PTR BYTE,
    char:BYTE
    mov esi,pString
    mov al,char
L1:
    cmp BYTE PTR [esi],al
    jne L2                      ; 제거할 문자가 아닌 첫 문자
    inc esi
    jmp L1
L2:
    mov edi,pString
    cmp esi,edi
    je Done                     ; 앞에 제거할 문자가 없음
    INVOKE Str_length, esi      ; EAX = 남은 길이
    mov ecx,eax
    inc ecx                     ; 널 바이트 포함
    cld
    rep movsb                   ; 남은 부분을 앞으로 복사
Done:
    ret
Str_trimLeading ENDP
```

**14.** ★★★ **Trimming a Set of Characters**

Create a variant of the Str_trim procedure that lets the caller remove all instances of a set of characters from the end of a string. For example, if you were to call it with a pointer to the string “ABC#$&” and pass it a pointer to an array of filter characters containing “%#!;$&\*”, the resulting string would be “ABC”.

> 답: 문자열의 마지막 문자가 필터 문자열에 있는지 REPNE SCASB로 검사한다. 있으면 길이를 1 줄이고 반복하며, 없으면 멈춘다. 마지막으로 남은 길이 위치에 널 바이트를 넣는다. 출력 결과는 ABC이다.

```asm
Str_trimSet PROTO,
    pString:PTR BYTE,
    pFilter:PTR BYTE

.data
str1   BYTE "ABC#$&",0
filter BYTE "%#!;$&*",0

.code
main PROC
    INVOKE Str_trimSet, ADDR str1, ADDR filter
    mov edx,OFFSET str1
    call WriteString
    call Crlf
    exit
main ENDP

Str_trimSet PROC USES eax ebx ecx edx esi edi,
    pString:PTR BYTE,
    pFilter:PTR BYTE
    INVOKE Str_length, pFilter
    mov edx,eax                 ; EDX = 필터 길이
    INVOKE Str_length, pString
    mov ebx,eax                 ; EBX = 현재 문자열 길이
    mov esi,pString
L1:
    cmp ebx,0
    je L2                       ; 모두 제거됨: 빈 문자열
    mov al,[esi+ebx-1]          ; 마지막 문자
    mov edi,pFilter
    mov ecx,edx
    cld
    repne scasb                 ; 필터에 있는지 검색
    jne L2                      ; 없으면 중단
    dec ebx                     ; 있으면 한 글자 제거
    jmp L1
L2:
    mov BYTE PTR [esi+ebx],0    ; 널 바이트 삽입
    ret
Str_trimSet ENDP
```
