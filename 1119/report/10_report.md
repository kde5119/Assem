# 10.7 Review Questions and Exercises

## 10.7.1 Short Answer

**1.** What is the purpose of the STRUCT directive?

> 답: 논리적으로 관련된 변수(필드)들을 하나로 묶는 구조체 형식(템플릿)을 정의한다. 이후 그 형식의 변수를 선언하면 구조체 전체를 하나의 단위로 다루거나 필드별로 접근할 수 있다.

**2.** Assume that the following structure has been defined:

```asm
RentalInvoice STRUCT
    invoiceNum BYTE 5 DUP(' ')
    dailyPrice WORD ?
    daysRented WORD ?
RentalInvoice ENDS
```

State whether or not each of the following declarations is valid:

a. rentals RentalInvoice <>

b. RentalInvoice rentals <>

c. march RentalInvoice <'12345',10,0>

d. RentalInvoice <,10,0>

e. current RentalInvoice <,15,0,0>

> 답: a. 유효. b. 유효하지 않음(변수 이름이 먼저, 구조체 형식이 나중에 와야 한다). c. 유효. d. 유효(이름 없는 구조체 변수로 메모리만 할당되고, 쉼표로 invoiceNum 필드를 건너뛴다). e. 유효하지 않음(필드는 3개인데 초기값이 4개이다).

**3.** (True/False): A macro cannot contain data definitions.

> 답: False. mWrite 매크로처럼 .data 영역에 문자열 같은 데이터를 정의할 수 있다.

**4.** What is the purpose of the LOCAL directive?

> 답: 매크로 안의 레이블(코드 레이블, 데이터 레이블)을 지역으로 선언한다. 전개될 때마다 ??0000 같은 고유한 이름으로 바뀌므로 매크로를 여러 번 호출해도 레이블이 중복되지 않는다.

**5.** Which directive displays a message on the console during the assembly step?

> 답: ECHO

**6.** Which directive marks the end of a conditional block of statements?

> 답: ENDIF

**7.** List all the relational operators that can be used in constant boolean expressions.

> 답: LT(작다), GT(크다), EQ(같다), NE(같지 않다), LE(작거나 같다), GE(크거나 같다)

**8.** What is the purpose of the & operator in a macro definition?

> 답: 치환 연산자로, 매크로 인수의 값을 문자열 리터럴 같은 텍스트 안에 삽입한다. 예를 들어 "&varName"에서 varName이 인수 값으로 바뀐다.

**9.** What is the purpose of the ! operator in a macro definition?

> 답: 리터럴 문자 연산자로, 바로 뒤의 문자가 연산자나 구분자(예: >)여도 일반 문자로 취급하게 한다.

**10.** What is the purpose of the % operator in a macro definition?

> 답: 확장 연산자로, 텍스트 매크로를 확장하거나 상수 식의 값을 계산하여 그 결과를 정수 텍스트로 바꾼다. 예를 들어 %(5 \* 10)은 50이 되어 상수 인수로 전달할 수 있다.

## 10.7.2 Algorithm Workbench

**1.** Create a structure named SampleStruct containing two fields: field1, a single 16-bit WORD, and field2, an array of 20 32-bit DWORDs. The initial values of the fields may be left undefined.

> 답: 배열 필드는 DUP 연산자로 선언한다.

```asm
SampleStruct STRUCT
    field1 WORD ?
    field2 DWORD 20 DUP(?)
SampleStruct ENDS
```

**2.** Write a statement that retrieves the wHour field of a SYSTEMTIME structure.

> 답: 구조체 변수를 선언하고 GetLocalTime으로 채운 뒤 wHour 필드를 읽는다.

```asm
.data
sysTime SYSTEMTIME <>
.code
INVOKE GetLocalTime, ADDR sysTime
movzx eax,sysTime.wHour
```

**3.** Using the following Triangle structure, declare a structure variable and initialize its vertices to (0,0), (5, 0), and (7,6):

```asm
Triangle STRUCT
    Vertex1 COORD <>
    Vertex2 COORD <>
    Vertex3 COORD <>
Triangle ENDS
```

> 답: 중첩된 COORD 초기값을 꺾쇠괄호로 겹쳐서 쓴다.

```asm
tri1 Triangle <<0,0>, <5,0>, <7,6>>
```

**4.** Declare an array of Triangle structures. Write a loop that initializes Vertex1 of each triangle to random coordinates in the range (0...10, 0...10).

> 답: DUP으로 배열을 선언하고 ESI로 각 구조체를 가리킨다. RandomRange(11)은 0~10을 반환한다.

```asm
NumTriangles = 5

.data
triangles Triangle NumTriangles DUP(<>)

.code
    call Randomize
    mov esi,OFFSET triangles
    mov ecx,NumTriangles
L1:
    mov eax,11
    call RandomRange            ; 0 ~ 10
    mov (Triangle PTR [esi]).Vertex1.X,ax
    mov eax,11
    call RandomRange
    mov (Triangle PTR [esi]).Vertex1.Y,ax
    add esi,TYPE Triangle       ; 다음 삼각형
    loop L1
```

**5.** Write a macro named mPrintChar that displays a single character on the screen. It should have two parameters: this first specifies the character to be displayed and the second specifies how many times the character should be repeated. Here is a sample call:

```asm
mPrintChar 'X',20
```

> 답: 반복 횟수를 ECX에 넣고 WriteChar를 반복 호출한다. 레이블은 LOCAL로 선언한다. 사용하는 레지스터는 push/pop으로 보존한다.

```asm
mPrintChar MACRO char:REQ, count:REQ
    LOCAL L1, L2
    push eax
    push ecx
    mov al,char
    mov ecx,count
    jecxz L2                    ;; 횟수가 0이면 건너뜀
L1: call WriteChar
    loop L1
L2: pop ecx
    pop eax
ENDM
```

**6.** Write a macro named mGenRandom that generates a random integer between 0 and n – 1. Let n be the only parameter.

> 답: RandomRange는 0 ~ (EAX - 1) 범위의 난수를 EAX에 반환한다. 결과는 EAX에 들어 있다.

```asm
mGenRandom MACRO n:REQ
    mov eax,n
    call RandomRange            ;; EAX = 0 ~ n-1
ENDM
```

**7.** Write a macro named mPromptInteger that displays a prompt and inputs an integer from the user. Pass it a string literal and the name of a doubleword variable. Sample call:

```asm
.data
minVal DWORD ?
.code
mPromptInteger "Enter the minimum value", minVal
```

> 답: Macros.inc의 mWrite로 프롬프트를 출력하고 ReadInt의 결과(EAX)를 변수에 저장한다. 인수로 EAX를 전달하면 안 된다.

```asm
mPromptInteger MACRO prompt:REQ, intVal:REQ
    push eax
    mWrite prompt
    call ReadInt
    mov intVal,eax
    pop eax
ENDM
```

**8.** Write a macro named mWriteAt that locates the cursor and writes a string literal to the console window. Suggestion: Invoke the mGotoxy and mWrite macros from the book’s macro library.

> 답: 중첩 매크로로 mGotoxy와 mWrite를 차례로 호출한다. 인수로 DH, DL을 전달하면 안 된다.

```asm
mWriteAt MACRO x:REQ, y:REQ, text:REQ
    mGotoxy x,y
    mWrite text
ENDM
```

**9.** Show the expanded code produced by the following statement that invokes the mWriteString macro from Section 10.2.5:

```asm
mWriteStr namePrompt
```

> 답: EDX를 저장하고, 문자열의 오프셋을 넣어 WriteString을 호출한 뒤 EDX를 복원한다.

```asm
push edx
mov edx,OFFSET namePrompt
call WriteString
pop edx
```

**10.** Show the expanded code produced by the following statement that invokes the mReadString macro from Section 10.2.5:

```asm
mReadStr customerName
```

> 답: ECX와 EDX를 저장하고, EDX에 버퍼 오프셋, ECX에 버퍼 크기를 넣어 ReadString을 호출한 뒤 복원한다.

```asm
push ecx
push edx
mov edx,OFFSET customerName
mov ecx,SIZEOF customerName
call ReadString
pop edx
pop ecx
```

**11.** Write a macro named mDumpMemx that receives a single parameter, the name of a variable. Your macro must call the mDumpMem macro from the book’s library, passing it the variable’s offset, number of units, and unit size. Demonstrate a call to the mDumpMemx macro.

> 답: 변수 이름 하나로 OFFSET, LENGTHOF, TYPE을 구해 mDumpMem에 전달한다.

```asm
mDumpMemx MACRO varName:REQ
    mDumpMem OFFSET varName, LENGTHOF varName, TYPE varName
ENDM

.data
array DWORD 1000h,2000h,3000h,4000h
.code
mDumpMemx array
```

**12.** Show an example of a macro parameter having a default argument initializer.

> 답: 매개변수 뒤에 :=<기본값>을 붙인다. 인수 없이 호출하면 기본값(공백 한 칸)이 사용된다.

```asm
mWriteln MACRO text:=<" ">
    mWrite text
    call Crlf
ENDM
```

**13.** Write a short example that uses the IF, ELSE, and ENDIF directives.

> 답: 어셈블 시점에 상수 식을 평가하여 버퍼 크기를 100 이하로 제한한다.

```asm
BufSize = 80

.data
IF BufSize LE 100
    buffer BYTE BufSize DUP(?)
ELSE
    buffer BYTE 100 DUP(?)
ENDIF
```

**14.** Write a statement using the IF directive that checks the value of the constant macro parameter Z; if Z is less than zero, display a message during assembly indicating that Z is invalid.

> 답: IF로 Z를 검사하고 ECHO로 어셈블 중에 메시지를 출력한다.

```asm
IF Z LT 0
    ECHO Error: Z is invalid
ENDIF
```

**15.** Write a short macro that demonstrates the use of the & operator when the macro parameter is embedded in a literal string.

> 답: 문자열 리터럴 안에서 매개변수 이름 앞에 &를 붙이면 인수 값이 문자열에 삽입된다. mSayHello Joe를 호출하면 "Hello, Joe!"가 출력된다.

```asm
mSayHello MACRO name
    mWrite "Hello, &name!"
ENDM

mSayHello Joe
```

**16.** Assume the following mLocate macro definition:

```asm
mLocate MACRO xval,yval
    IF xval LT 0        ;; xval < 0?
        EXITM           ;; if so, exit
    ENDIF
    IF yval LT 0        ;; yval < 0?
        EXITM           ;; if so, exit
    ENDIF
    mov bx,0            ;; video page 0
    mov ah,2            ;; locate cursor
    mov dh,yval
    mov dl,xval
    int 10h             ;; call the BIOS
ENDM
```

Show the source code generated by the preprocessor when the macro is expanded by each of the following statements:

```asm
.data
row BYTE 15
col BYTE 60
.code
mLocate -2,20
mLocate 10,20
mLocate col,row
```

> 답: mLocate -2,20은 xval이 0보다 작아 EXITM으로 종료되므로 아무 코드도 생성되지 않는다. mLocate 10,20은 아래 코드로 전개된다. mLocate col,row는 col, row가 변수라서 IF의 상수 식에 쓸 수 없으므로 어셈블 오류가 난다. (오류가 나지 않는다고 가정하면 mov dh,row와 mov dl,col을 쓰는 같은 형태로 전개된다.)

```asm
; mLocate -2,20  → 생성되는 코드 없음

; mLocate 10,20
mov bx,0
mov ah,2
mov dh,20
mov dl,10
int 10h

; mLocate col,row  → IF col LT 0 에서 어셈블 오류
```

---

## 10.8 Programming Exercises

**1.** ★ **mReadkey Macro**

Create a macro that waits for a keystroke and returns the key that was pressed. The macro should include parameters for the ASCII code and keyboard scan code. Hint: Call ReadChar from the book’s link library. Write a program that tests your macro. For example, the following code waits for a key; when it returns, the two arguments contain the ASCII code and scan code:

```asm
.data
ascii BYTE ?
scan BYTE ?
.code
mReadkey ascii, scan
```

> 답: ReadChar는 AL에 ASCII 코드를 반환하고, 방향키나 기능키 같은 확장 키는 AL = 0이면서 AH에 스캔 코드를 반환한다. 매크로에서 AL, AH를 두 인수에 저장하고 EAX는 복원한다. 일반 키를 누르면 AH의 값은 의미가 없으므로 확장 키로 테스트하면 스캔 코드를 확인할 수 있다.

```asm
INCLUDE Macros.inc

mReadkey MACRO asciiCode:REQ, scanCode:REQ
    push eax
    call ReadChar               ;; AL = ASCII, AH = 스캔 코드(확장 키)
    mov asciiCode,al
    mov scanCode,ah
    pop eax
ENDM

.data
ascii BYTE ?
scan  BYTE ?

.code
main PROC
    mWrite "Press a key: "
    mReadkey ascii, scan
    call Crlf
    mWrite "ASCII code: "
    movzx eax,ascii
    call WriteHex
    call Crlf
    mWrite "Scan code: "
    movzx eax,scan
    call WriteHex
    call Crlf
    exit
main ENDP
```

**2.** ★ **mWritestringAttr Macro**

(Requires reading ahead to Section 11.1.11.) Create a macro that writes a null-terminated string to the console with a given text color. The macro parameters should include the string name and the color. Hint: Call SetTextColor from the book’s link library. Write a program that tests your macro with several strings in different colors. Sample call:

```asm
.data
myString db "Here is my string",0
.code
mWritestring myString, white
```

> 답: SetTextColor로 색을 설정한 뒤 WriteString으로 출력한다. 마지막에 기본 색(lightGray)으로 되돌린다. 인수로 EAX, EDX를 전달하면 안 된다.

```asm
mWritestringAttr MACRO buffer:REQ, color:REQ
    push eax
    push edx
    mov eax,color
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    pop edx
    pop eax
ENDM

.data
str1 BYTE "Here is my string",0
str2 BYTE "Another string",0
str3 BYTE "Third string",0

.code
main PROC
    mWritestringAttr str1, white
    call Crlf
    mWritestringAttr str2, yellow
    call Crlf
    mWritestringAttr str3, lightRed
    call Crlf
    mov eax,lightGray
    call SetTextColor           ; 기본 색 복원
    exit
main ENDP
```

**3.** ★ **mMove32 Macro**

Write a macro named mMove32 that receives two 32-bit memory operands. The macro should move the source operand to the destination operand. Write a program that tests your macro.

> 답: 메모리에서 메모리로 직접 MOV할 수 없으므로 EAX를 거쳐 옮기고 EAX는 복원한다. 매개변수 순서는 (목적지, 원본)이다. 출력 결과는 12345678이다.

```asm
mMove32 MACRO dest:REQ, src:REQ
    push eax
    mov eax,src
    mov dest,eax
    pop eax
ENDM

.data
val1 DWORD 12345678h
val2 DWORD 0

.code
main PROC
    mMove32 val2, val1
    mov eax,val2
    call WriteHex               ; 12345678
    call Crlf
    exit
main ENDP
```

**4.** ★ **mMult32 Macro**

Create a macro named mMult32 that multiplies two 32-bit memory operands and produces a 32-bit product. Write a program that tests your macro.

> 답: 두 오퍼랜드와 결과를 저장할 변수를 매개변수로 받는다. 2피연산자 IMUL을 쓰면 EDX를 건드리지 않고 하위 32비트 곱을 얻는다. 출력 결과는 42이다.

```asm
mMult32 MACRO op1:REQ, op2:REQ, product:REQ
    push eax
    mov eax,op1
    imul eax,op2                ;; 32비트 곱
    mov product,eax
    pop eax
ENDM

.data
num1 DWORD 6
num2 DWORD 7
prod DWORD ?

.code
main PROC
    mMult32 num1, num2, prod
    mov eax,prod
    call WriteDec               ; 42
    call Crlf
    exit
main ENDP
```

**5.** ★★ **mReadInt Macro**

Create a macro named mReadInt that reads a 16- or 32-bit signed integer from standard input and returns the value in an argument. Use conditional operators to allow the macro to adapt to the size of the desired result. Write a program that tests the macro, passing it operands of various sizes.

> 답: ReadInt가 EAX에 읽은 값을 IF로 인수의 크기(TYPE)에 따라 AX 또는 EAX로 저장한다. WORD, DWORD가 아니면 ECHO로 오류를 출력하고 종료한다.

```asm
INCLUDE Macros.inc

mReadInt MACRO intVal:REQ
    IF ((TYPE intVal) NE 2) AND ((TYPE intVal) NE 4)
        ECHO Error: mReadInt supports only WORD and DWORD
        EXITM
    ENDIF
    push eax
    call ReadInt                ;; EAX = 입력한 부호 있는 정수
    IF (TYPE intVal) EQ 2
        mov intVal,ax           ;; 16비트
    ELSE
        mov intVal,eax          ;; 32비트
    ENDIF
    pop eax
ENDM

.data
val16 SWORD ?
val32 SDWORD ?

.code
main PROC
    mWrite "Enter a 16-bit integer: "
    mReadInt val16
    mWrite "Enter a 32-bit integer: "
    mReadInt val32
    movsx eax,val16
    call WriteInt
    call Crlf
    mov eax,val32
    call WriteInt
    call Crlf
    exit
main ENDP
```

**6.** ★★ **mWriteInt Macro**

Create a macro named mWriteInt that writes a signed integer to standard output by calling the WriteInt library procedure. The argument passed to the macro can be a byte, word, or doubleword. Use conditional operators in the macro so it adapts to the size of the argument. Write a program that tests the macro, passing it arguments of different sizes.

> 답: 인수가 DWORD이면 MOV, BYTE나 WORD이면 MOVSX로 EAX에 부호 확장한 뒤 WriteInt를 호출한다. 출력 결과는 -5, -300, +100000이다.

```asm
mWriteInt MACRO value:REQ
    IF ((TYPE value) NE 1) AND ((TYPE value) NE 2) AND ((TYPE value) NE 4)
        ECHO Error: mWriteInt supports only BYTE, WORD, and DWORD
        EXITM
    ENDIF
    push eax
    IF (TYPE value) EQ 4
        mov eax,value
    ELSE
        movsx eax,value         ;; 바이트/워드는 부호 확장
    ENDIF
    call WriteInt
    pop eax
ENDM

.data
byteVal  SBYTE -5
wordVal  SWORD -300
dwordVal SDWORD 100000

.code
main PROC
    mWriteInt byteVal
    call Crlf
    mWriteInt wordVal
    call Crlf
    mWriteInt dwordVal
    call Crlf
    exit
main ENDP
```

**7.** ★★★ **The Professsor’s Lost Phone**

When the professor took the drunkard's walk around campus in Section 10.1.6, we discovered that he lost his cell phone somewhere along the path. When you simulate the drunken walk, your program must drop the phone wherever the professor is standing at some random time interval. Each time you run the program, the cell phone will be lost at a different time interval (and location).

> 답: Walk.asm에서 main에 Randomize를 추가하고, TakeDrunkenWalk에서 루프 시작 전에 RandomRange(WalkMax)로 휴대폰을 잃어버릴 걸음 번호를 정한다. 루프에서 현재 걸음 번호와 같아지면 메시지를 출력하고 그 위치가 휴대폰을 잃어버린 위치가 된다. 나머지(구조체 정의, DisplayPosition 등)는 교재 코드와 같다.

```asm
.data
aWalk    DrunkardWalk <>
phoneMsg BYTE "Phone lost at: ",0

.code
main PROC
    call Randomize              ; 실행할 때마다 다른 난수
    mov esi,OFFSET aWalk
    call TakeDrunkenWalk
    exit
main ENDP

TakeDrunkenWalk PROC
    LOCAL currX:WORD, currY:WORD, phoneStep:DWORD, stepNum:DWORD
    pushad
    mov edi,esi
    add edi,OFFSET DrunkardWalk.path
    mov ecx,WalkMax
    mov currX,StartX
    mov currY,StartY
    mov eax,WalkMax
    call RandomRange            ; 휴대폰을 잃어버릴 걸음 (0 ~ WalkMax-1)
    mov phoneStep,eax
    mov stepNum,0               ; 현재 걸음 번호
Again:
    mov ax,currX
    mov (COORD PTR [edi]).X,ax
    mov ax,currY
    mov (COORD PTR [edi]).Y,ax
    mov eax,stepNum
    cmp eax,phoneStep
    jne Show
    mov edx,OFFSET phoneMsg
    call WriteString            ; "Phone lost at: " 뒤에 위치가 이어서 출력됨
Show:
    INVOKE DisplayPosition, currX, currY
    mov eax,4                   ; 방향 선택 (0-3)
    call RandomRange
    .IF eax == 0                ; 북
        dec currY
    .ELSEIF eax == 1            ; 남
        inc currY
    .ELSEIF eax == 2            ; 서
        dec currX
    .ELSE                       ; 동
        inc currX
    .ENDIF
    add edi,TYPE COORD
    inc stepNum
    loop Again
    mov (DrunkardWalk PTR [esi]).pathsUsed,WalkMax
    popad
    ret
TakeDrunkenWalk ENDP
```

**8.** ★★★ **Drunkard’s Walk with Probabilities**

When testing the DrunkardWalk program, you may have noticed that the professor doesn’t seem to wander very far from the starting point. This is no doubt caused by an equal probability of the professor moving in any direction. Modify the program so there is a 50% probability the professor will continue to walk in the same direction as he or she did when taking the previous step. There should be a 10% probability that he or she will reverse direction and a 20% probability that he or she will turn either right or left. Assign a default starting direction before the loop begins.

> 답: 방향을 시계 방향 순서(0 = 북, 1 = 동, 2 = 남, 3 = 서)로 정하면 방향 변화를 더하기로 표현할 수 있다. 0~9 난수로 0~4는 유지(+0, 50%), 5는 반대(+2, 10%), 6~7은 오른쪽 회전(+1, 20%), 8~9는 왼쪽 회전(+3, 20%)을 선택하고, and 3으로 0~3 범위를 유지한다. 시작 방향은 동쪽으로 정했다. main과 DisplayPosition은 7번(또는 교재)과 같고 TakeDrunkenWalk만 바뀐다.

```asm
TakeDrunkenWalk PROC
    LOCAL currX:WORD, currY:WORD, dir:DWORD
    pushad
    mov edi,esi
    add edi,OFFSET DrunkardWalk.path
    mov ecx,WalkMax
    mov currX,StartX
    mov currY,StartY
    mov dir,1                   ; 기본 시작 방향: 동쪽
Again:
    mov ax,currX
    mov (COORD PTR [edi]).X,ax
    mov ax,currY
    mov (COORD PTR [edi]).Y,ax
    INVOKE DisplayPosition, currX, currY
    ; 현재 방향으로 한 걸음 이동
    mov eax,dir
    .IF eax == 0                ; 북
        dec currY
    .ELSEIF eax == 1            ; 동
        inc currX
    .ELSEIF eax == 2            ; 남
        inc currY
    .ELSE                       ; 서
        dec currX
    .ENDIF
    ; 다음 걸음의 방향 결정
    mov eax,10
    call RandomRange            ; 0 ~ 9
    .IF eax <= 4                ; 50%: 같은 방향 유지
        mov eax,0
    .ELSEIF eax == 5            ; 10%: 반대 방향
        mov eax,2
    .ELSEIF eax <= 7            ; 20%: 오른쪽으로 회전
        mov eax,1
    .ELSE                       ; 20%: 왼쪽으로 회전
        mov eax,3
    .ENDIF
    add dir,eax
    and dir,3                   ; 0 ~ 3 범위 유지
    add edi,TYPE COORD
    loop Again
    mov (DrunkardWalk PTR [esi]).pathsUsed,WalkMax
    popad
    ret
TakeDrunkenWalk ENDP
```

**9.** ★★★★ **Shifting Multiple Doublewords**

Create a macro that shifts an array of 32-bit integers a variable number of bits in either direction, using the SHRD and SHLD instructions. Write a test program that tests your macro by shifting the same array in both directions and displaying the resulting values. You can assume that the array is in little-endian order. Here is a sample macro declaration:

```asm
mShiftDoublewords MACRO arrayName, direction, numberOfBits
```

Parameters:

```
arrayName      Name of the array
direction      Right (R) or Left (L)
numberOfBits   Number of bit positions to shift
```

> 답: 배열 전체를 하나의 큰 정수로 보고, 오른쪽 이동은 낮은 원소부터 SHRD(위쪽 원소의 하위 비트를 채움)를 적용하고 마지막 원소는 SHR을 적용한다. 왼쪽 이동은 높은 원소부터 SHLD(아래쪽 원소의 상위 비트를 채움)를 적용하고 첫 원소는 SHL을 적용한다. 이동 비트 수는 CL에 넣으므로 1~31이어야 한다. 방향은 IFIDNI로 판별한다. 11111111h, 22222222h, 33333333h를 4비트 오른쪽 이동하면 21111111h, 32222222h, 03333333h가 되고, 다시 4비트 왼쪽 이동하면 11111110h, 22222222h, 33333333h가 된다.

```asm
INCLUDE Macros.inc

mShiftDoublewords MACRO arrayName:REQ, direction:REQ, numberOfBits:REQ
    LOCAL L1, L2
    push eax
    push ebx
    push ecx
    push esi
    mov cl,numberOfBits         ;; 이동할 비트 수
    mov ebx,LENGTHOF arrayName - 1   ;; 이웃한 원소 쌍의 수
    IFIDNI <direction>,<R>
        mov esi,0               ;; 오른쪽 이동: 낮은 원소부터
    L1: cmp ebx,0
        je L2
        mov eax,arrayName[esi*4+4]   ;; 위쪽 원소 (채워 넣을 비트 공급)
        shrd arrayName[esi*4],eax,cl
        inc esi
        dec ebx
        jmp L1
    L2: shr arrayName[esi*4],cl      ;; 마지막 원소
    ELSE
        IFIDNI <direction>,<L>
            mov esi,LENGTHOF arrayName - 1   ;; 왼쪽 이동: 높은 원소부터
        L1: cmp ebx,0
            je L2
            mov eax,arrayName[esi*4-4]       ;; 아래쪽 원소 (채워 넣을 비트 공급)
            shld arrayName[esi*4],eax,cl
            dec esi
            dec ebx
            jmp L1
        L2: shl arrayName[esi*4],cl          ;; 첫 번째 원소
        ELSE
            ECHO Error: direction must be R or L
        ENDIF
    ENDIF
    pop esi
    pop ecx
    pop ebx
    pop eax
ENDM

.data
array DWORD 11111111h,22222222h,33333333h    ; 리틀 엔디언: 첫 원소가 가장 낮은 자리

.code
main PROC
    mShiftDoublewords array, R, 4
    mDumpMem OFFSET array, LENGTHOF array, TYPE array   ; 21111111 32222222 03333333
    mShiftDoublewords array, L, 4
    mDumpMem OFFSET array, LENGTHOF array, TYPE array   ; 11111110 22222222 33333333
    exit
main ENDP
```

**10.** ★★★ **Three-Operand Instructions**

Some computer instruction sets permit arithmetic instructions with three operands. Such operations sometimes appear in simple virtual assemblers used to introduce students to the concept of assembly language or using intermediate language in compilers. In the following macros, assume EAX is reserved for macro operations and is not preserved. Other registers modified by the macro must be preserved. All parameters are signed memory doublewords. Write macros that simulate the following operations:

a. add3 destination, source1, source2

b. sub3 destination, source1, source2 (destination = source1 – source2)

c. mul3 destination, source1, source2

d. div3 destination, source1, source2 (destination = source1 / source2)

For example, the following macro calls implement the expression x = (w + y) \* z:

```asm
.data
temp DWORD ?
.code
add3 temp, w, y         ; temp = w + y
mul3 x, temp, z         ; x = temp * z
```

Write a program that tests your macros by implementing four arithmetic expressions, each involving multiple operations.

> 답: 모두 EAX를 거쳐 계산한다. mul3은 2피연산자 IMUL로 EDX를 건드리지 않고, div3은 CDQ와 IDIV 때문에 EDX가 바뀌므로 push/pop으로 보존한다. w = 10, y = 4, z = 3, v = 2일 때 네 식의 결과는 +42, +26, +3, +15이다.

```asm
add3 MACRO dest:REQ, src1:REQ, src2:REQ
    mov eax,src1
    add eax,src2
    mov dest,eax
ENDM

sub3 MACRO dest:REQ, src1:REQ, src2:REQ
    mov eax,src1
    sub eax,src2
    mov dest,eax
ENDM

mul3 MACRO dest:REQ, src1:REQ, src2:REQ
    mov eax,src1
    imul eax,src2
    mov dest,eax
ENDM

div3 MACRO dest:REQ, src1:REQ, src2:REQ
    push edx                    ;; EDX는 보존
    mov eax,src1
    cdq                         ;; EDX:EAX 부호 확장
    idiv src2
    mov dest,eax                ;; 몫
    pop edx
ENDM

.data
w SDWORD 10
y SDWORD 4
z SDWORD 3
v SDWORD 2
temp SDWORD ?
r1 SDWORD ?
r2 SDWORD ?
r3 SDWORD ?
r4 SDWORD ?

.code
main PROC
    ; r1 = (w + y) * z = 42
    add3 temp, w, y
    mul3 r1, temp, z
    ; r2 = (w * z) - y = 26
    mul3 temp, w, z
    sub3 r2, temp, y
    ; r3 = (w - y) / v = 3
    sub3 temp, w, y
    div3 r3, temp, v
    ; r4 = (w * y) / z + v = 15
    mul3 temp, w, y
    div3 temp, temp, z
    add3 r4, temp, v

    mov eax,r1
    call WriteInt
    call Crlf
    mov eax,r2
    call WriteInt
    call Crlf
    mov eax,r3
    call WriteInt
    call Crlf
    mov eax,r4
    call WriteInt
    call Crlf
    exit
main ENDP
```
