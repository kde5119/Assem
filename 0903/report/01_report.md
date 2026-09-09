# 1.7 Review Questions and Exercises

## 1.7.1 Short Answer

**1.** In an 8-bit binary number, which is the most significant bit (MSB)?

> 답: 가장 왼쪽 비트

**2.** What is the decimal representation of each of the following unsigned binary integers?

- a. 00110101
- b. 10010110
- c. 11001100

> 답 a: 1+4+16+32 = 53

> 답 b: 2+4+16+128 = 150

> 답 c: 4+8+64+128 = 204

**3.** What is the sum of each pair of binary integers?

- a. 10101111 + 11011011
- b. 10010111 + 11111111
- c. 01110101 + 10101100

> 답 a: 110001010

> 답 b: 110010110

> 답 c: 100100001

**4.** Calculate binary 00001101 minus 00000111.

> 답: 00000110 (6)

**5.** How many bits are used by each of the following data types?

- a. word
- b. doubleword
- c. quadword
- d. double quadword

> 답 a: 16비트

> 답 b: 32비트

> 답 c: 64비트

> 답 d: 128비트

**6.** What is the minimum number of binary bits needed to represent each of the following unsigned decimal integers?

- a. 4095
- b. 65534
- c. 42319

> 답 a: $2^{12}$ - 1 = 4095이니 12비트

> 답 b: $2^{16}$ - 1 > 65534이니 16비트

> 답 c: $2^{15}$ - 1 < 42319 < 65535이니 16비트

**7.** What is the hexadecimal representation of each of the following binary numbers?

- a. 0011 0101 1101 1010
- b. 1100 1110 1010 0011
- c. 1111 1110 1101 1011

> 답 a: 3 5 D A -> 35DA

> 답 b: C E A 3 -> CEA3

> 답 c: F E D B -> FEDB

**8.** What is the binary representation of the following hexadecimal numbers?

- a. 0126F9D4
- b. 6ACDFA95
- c. F69BDC2A

> 답 a: 0000 0001 0010 0110 1111 1001 1101 0100

> 답 b: 0110 1010 1100 1101 1111 1010 1001 0101

> 답 c: 1111 0110 1001 1011 1101 1100 0010 1010

**9.** What is the unsigned decimal representation of each of the following hexadecimal integers?

- a. 3A
- b. 1BF
- c. 1001

> 답 a: 3 x 16 + 10 = 58

> 답 b: 1 x 256 + 11 x 16 + 15 = 447

> 답 c: 1 x 4096 + 1 = 4097

**10.** What is the unsigned decimal representation of each of the following hexadecimal integers?

- a. 62
- b. 4B3
- c. 29F

> 답 a: 6 x 16 + 2 = 98

> 답 b: 4 x 256 + 11 x 16 + 3 = 1203

> 답 c: 2 x 256 + 9 x 16 + 15 = 671

**11.** What is the 16-bit hexadecimal representation of each of the following signed decimal integers?

- a. –24
- b. –331

> 답 a: (24) 0000 0000 0001 1000을 비트반전 후 +1하면 1111 1111 1110 1000 이니 FFE8

> 답 b: (331) 0000 0001 0100 1011을 비트반전 후 +1하면 1111 1110 1011 0101 이니 FEB5

**12.** What is the 16-bit hexadecimal representation of each of the following signed decimal integers?

- a. –21
- b. –45

> 답 a: (21) 0000 0000 0001 0101을 비트반전 후 +1하면 1111 1111 1110 1011 이니 FFEB

> 답 b: (45) 0000 0000 0010 1101을 비트반전 후 +1하면 1111 1111 1101 0011 이니 FFD3

**13.** The following 16-bit hexadecimal numbers represent signed integers. Convert each to decimal.

- a. 6BF9
- b. C123

> 답 a: 0110 1011 1111 1001이고, 최상위비트가 0이니 양수. 그대로 계산하면 27641

> 답 b: 1100 0001 0010 0011이고, 최상위비트가 1이니 음수. 비트반전 후 +1하면 0011 1110 1101 1101 계산하면 -16093

**14.** The following 16-bit hexadecimal numbers represent signed integers. Convert each to decimal.

- a. 4CD2
- b. 8230

> 답 a: 0100 1100 1101 0010이고, 최상위비트가 0이니 양수. 그대로 계산하면 19666

> 답 b: 1000 0010 0011 0000이고, 최상위비트가 1이니 음수. 비트반전 후 +1하면 0111 1101 1101 0000 계산하면 -32208

**15.** What is the decimal representation of each of the following signed binary numbers?

- a. 10110101
- b. 00101010
- c. 11110000

> 답 a: 최상위비트가 1이니 음수, 비트반전 후 +1하면 01001011 -> -75

> 답 b: 최상위비트가 0이니 양수, 42

> 답 c: 최상위비트가 1이니 음수, 비트반전 후 +1하면 00010000 -> -16

**16.** What is the decimal representation of each of the following signed binary numbers?

- a. 10000000
- b. 11001100
- c. 10110111

> 답 a: 최상위비트가 1이니 음수, 비트반전 후 +1하면 10000000 -> -128

> 답 b: 최상위비트가 1이니 음수, 비트반전 후 +1하면 00110100 -> –52

> 답 c: 최상위비트가 1이니 음수, 비트반전 후 +1하면 01001001 -> –73

**17.** What is the 8-bit binary (two's-complement) representation of each of the following signed decimal integers?

- a. –5
- b. –42
- c. –16

> 답 a: (5) 00000101에서 비트반전 후 +1하면 1111 1011

> 답 b: (42) 00101010에서 비트반전 후 +1하면 1101 0110

> 답 c: (16) 00010000에서 비트반전 후 +1하면 1111 0000

**18.** What is the 8-bit binary (two's-complement) representation of each of the following signed decimal integers?

- a. –72
- b. –98
- c. –26

> 답 a: (72) 01001000에서 비트반전 후 +1하면 1011 1000

> 답 b: (98) 01100010에서 비트반전 후 +1하면 1001 1110

> 답 c: (26) 00011010에서 비트반전 후 +1하면 1110 0110

**19.** What is the sum of each pair of hexadecimal integers?

- a. 6B4 + 3FE
- b. A49 + 6BD

> 답 a: 4+E -> 올림1 + 2, B+F+1 -> 올림1 + B, 6+3+1 -> A 이므로 AB2

> 답 b: 9+D -> 올림1 + 6, 4+B+1 -> 올림1 + 0, A+6+1 -> 올림1 + 1 이므로 1106

**20.** What is the sum of each pair of hexadecimal integers?

- a. 7C4 + 3BE
- b. B69 + 7AD

> 답 a: 4+E -> 올림1 + 2, C+B+1 -> 올림1 + 8, 7+3+1 -> B 이므로 B82

> 답 b: 9+D -> 올림1 + 6, 6+A+1 -> 올림1 + 1, B+7+1 -> 올림1 + 3 이므로 1316

**21.** What are the hexadecimal and decimal representations of the ASCII character capital B?

> 답: 10진수로는 66, 16진수로는 42

**22.** What are the hexadecimal and decimal representations of the ASCII character capital G?

> 답: 10진수로는 71, 16진수로는 47

**23. (Challenge)** What is the largest decimal value you can represent, using a 129-bit unsigned integer?

> 답: $2^{n}$ - 1이니 $2^{129}$ - 1이다.

**24. (Challenge)** What is the largest decimal value you can represent, using a 86-bit signed integer?

> 답: 부호 있는 정수 최댓값은 $2^{85}$ - 1

**25.** Create a truth table to show all possible inputs and outputs for the boolean function described by ¬(A ∨ B).

> 답:

| A   | B   | A ∨ B | ¬(A ∨ B) |
| --- | --- | ----- | -------- |
| 0   | 0   | 0     | 1        |
| 0   | 1   | 1     | 0        |
| 1   | 0   | 1     | 0        |
| 1   | 1   | 1     | 0        |

**26.** Create a truth table to show all possible inputs and outputs for the boolean function described by (¬A ∧ ¬B). How would you describe the rightmost column of this table in relation to the table from question number 25? Have you heard of De Morgan's Theorem?

> 답: 드모르간의 법칙 : OR의 부정은 각 항을 부정한 AND와 같다.

| A   | B   | A ∨ B | ¬(A ∨ B) | ¬A ∧ ¬B |
| --- | --- | ----- | -------- | ------- |
| 0   | 0   | 0     | 1        | 1       |
| 0   | 1   | 1     | 0        | 0       |
| 1   | 0   | 1     | 0        | 0       |
| 1   | 1   | 1     | 0        | 0       |

**27.** If a boolean function has four inputs, how many rows are required for its truth table?

> 답: 입력이 4개면 $2^4$ 16행

**28.** How many selector bits are required for a four-input multiplexer?

> 답: 4개 중 선택하는 것이므로 최소 2비트 필요.

---

## 1.7.2 Algorithm Workbench

Use any high-level programming language you wish for the following programming exercises. Do not call built-in library functions that accomplish these tasks automatically. (Examples are sprintf and sscanf from the Standard C library.)

**1.** Write a function that receives a string containing a 16-bit binary integer. The function must return the string's integer value.

> 답(코드/설명): 왼쪽부터 하나씩 읽으면서 자릿값을 x2해서 누적함.

```java
static int toInt(String s) {
        int value = 0;
        for (int i = 0; i < s.length(); i++) {
            value = value << 1;
            if (s.charAt(i) == '1') value++;
        }
        return value;
    }
```

**2.** Write a function that receives a string containing a 32-bit hexadecimal integer. The function must return the string's integer value.

> 답(코드/설명): 16진수이므로 자릿값을 x16해서 누적

```java
static int toIntHex(String s) {
    int value = 0;
    for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        int d;
        if (c >= '0' && c <= '9') d = c - '0';
        else if (c >= 'A' && c <= 'F') d = c - 'A' + 10;
        else d = c - 'a' + 10;
        value = value * 16 + d;
    }
    return value;
}
```

**3.** Write a function that receives an integer. The function must return a string containing the binary representation of the integer.

> 답(코드/설명): 2로 정수나누기 하면서 나머지 저장.

```java
static String toBin(int n) {
    if (n == 0) return "0";
    boolean neg = (n < 0);
    long v = neg ? -(long) n : n;

    StringBuilder sb = new StringBuilder();
    while (v > 0) {
        sb.append((char) ('0' + (v % 2)));
        v /= 2;
    }
    if (neg) sb.append('-');
    sb.reverse();
    return sb.toString();
}
```

**4.** Write a function that receives an integer. The function must return a string containing the hexadecimal representation of the integer.

> 답(코드/설명): 16으로 나눈 나머지로.

```java
static String toHex(int n) {
    if (n == 0) return "0";
    boolean neg = (n < 0);
    long v = neg ? -(long) n : n;

    StringBuilder sb = new StringBuilder();
    while (v > 0) {
        int d = (int) (v % 16);
        sb.append((d < 10) ? (char) ('0' + d) : (char) ('A' + d - 10));
        v /= 16;
    }
    if (neg) sb.append('-');
    sb.reverse();
    return sb.toString();
}
```

**5.** Write a function that adds two digit strings in base b, where 2 ≤ b ≤ 10. Each string may contain as many as 1,000 digits. Return the sum in a string that uses the same number base.

> 답(코드/설명): 1의 자리부터 덧셈, 올림 발생하면 carry 넘기기.

```java
static String addBase(String a, String b, int base) {
    StringBuilder sb = new StringBuilder();
    int i = a.length() - 1;
    int j = b.length() - 1;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int da = (i >= 0) ? (a.charAt(i) - '0') : 0;
        int db = (j >= 0) ? (b.charAt(j) - '0') : 0;
        int sum = da + db + carry;

        sb.append((char) ('0' + (sum % base)));
        carry = sum / base;
        i--;
        j--;
    }

    sb.reverse();
    return sb.toString();
}
```

**6.** Write a function that adds two hexadecimal strings, each as long as 1,000 digits. Return a hexadecimal string that represents the sum of the inputs.

> 답(코드/설명): 5번과 같음 16진법

```java
static String addHex(String a, String b) {
    StringBuilder sb = new StringBuilder();
    int i = a.length() - 1;
    int j = b.length() - 1;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int da = (i >= 0) ? CharToNumber(a.charAt(i)) : 0;
        int db = (j >= 0) ? CharToNumber(b.charAt(j)) : 0;
        int sum = da + db + carry;

        sb.append(NumberToChar(sum % 16));
        carry = sum / 16;
        i--;
        j--;
    }

    sb.reverse();
    return sb.toString();
}

static int CharToNumber(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return c - 'a' + 10;
}

static char NumberToChar(int v) {
    return (v < 10) ? (char) ('0' + v) : (char) ('A' + v - 10);
}
```

**7.** Write a function that multiplies a single hexadecimal digit by a hexadecimal digit string as long as 1,000 digits. Return a hexadecimal string that represents the product.

> 답(코드/설명): 5번과 비슷하게 1의 자리부터 곱셈.

```java
static String multiplyHex(char digit, String s) {
    int d = CharToNumber(digit);
    StringBuilder result = new StringBuilder();
    int carry = 0;

    for (int i = s.length() - 1; i >= 0; i--) {
        int val = CharToNumber(s.charAt(i));
        int p = val * d + carry;

        result.append(NumberToChar(p % 16));
        carry = p / 16;
    }

    while (carry > 0) {
        result.append(NumberToChar(carry % 16));
        carry = carry / 16;
    }

    return result.reverse().toString();
}
static int CharToNumber(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return c - 'a' + 10;
}

static char NumberToChar(int v) {
    return (v < 10) ? (char) ('0' + v) : (char) ('A' + v - 10);
}
```

**8.** Write a Java program that contains the calculation shown below. Then, use the `javap –c` command to disassemble your code. Add comments to each line that provide your best guess as to its purpose.

```java
int Y;
int X = (Y + 4) * 3;
```

> 답: 실행결과 확인

```java
public class a {
    public static void main(String[] args) {
        int Y;
        Y = 1;
        int X = (Y + 4) * 3;
        System.out.println(X);
    }
}
```

```
public static void main(java.lang.String[]);
  Code:
       0: iconst_1          // 정수 1을 스택에 넣음
       1: istore_1          // 1을 Y에 저장
       2: iload_1           // Y의 값을 스택에 넣음
       3: iconst_4          // 정수 4를 스택에 넣음
       4: iadd              // Y + 4를 계산
       5: iconst_3          // 정수 3을 스택에 넣음
       6: imul              // Y + 4되어있던 내용과 3을 곱함
       7: istore_2          // 계산 결과를 X에 저장
       8: getstatic #7       // System.out을 가져옴
      11: iload_2            // X의 값을 가져옴
      12: invokevirtual #13  // X를 출력
      15: return             // 종료
```

**9.** Devise a way of subtracting unsigned binary integers. Test your technique by subtracting binary 00000101 from binary 10001000, producing 10000011. Test your technique with at least two other sets of integers, in which a smaller value is always subtracted from a larger one.

> 답: diff가 음수가 되면 빌려야 하는 상황. 빌리면 다음 diff에서 뺌.

```java
static String subtractBinary(String a, String b) {
    int len = a.length();
    char[] result = new char[len];
    int borrow = 0;

    for (int i = len - 1; i >= 0; i--) {
        int bitA = a.charAt(i) - '0';
        int bitB = b.charAt(i) - '0';

        int diff = bitA - bitB - borrow;
        if (diff < 0) {
            diff += 2;
            borrow = 1;
        } else {
            borrow = 0;
        }
        result[i] = (char) ('0' + diff);
    }

    return new String(result);
}
```
