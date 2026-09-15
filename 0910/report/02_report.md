# 2.8 Review Questions

**1.** In 32-bit mode, aside from the stack pointer (ESP), what other register points to variables on
the stack?

> 답: EBP

**2.** Name at least four CPU status flags.

> 답: CF(Carry flag), OF(Overflow flag), SF(Sign flag), ZF(Zero flag)

**3.** Which flag is set when the result of an unsigned arithmetic operation is too large to fit into
the destination?

> 답: CF (Carry flag) 넘치면 캐리로 처리

**4.** Which flag is set when the result of a signed arithmetic operation is either too large or too
small to fit into the destination?

> 답: OF (Overflow flag) 부호 있는 범위를 넘었는지 체크

**5.** (True/False): When a register operand size is 32 bits and the REX prefix is used, the R8D
register is available for programs to use.

> 답: True

**6.** Which flag is set when an arithmetic or logical operation generates a negative result?

> 답: SF (Sign flag)

**7.** Which part of the CPU performs floating-point arithmetic?

> 답: FPU (Floating-Point Unit)

**8.** On a 32-bit processor, how many bits are contained in each floating-point data register?

> 답: 80비트

**9.** (True/False): The x86-64 instruction set is backward-compatible with the x86 instruction set.

> 답: True

**10.** (True/False): In current 64-bit chip implementations, all 64 bits are used for addressing.

> 답: False

**11.** (True/False): The Itanium instruction set is completely different from the x86 instruction set.

> 답: True

**12.** (True/False): Static RAM is usually less expensive than dynamic RAM.

> 답: False 주로 캐시 메모리가 SRAM으로 구성

**13.** (True/False): The 64-bit RDI register is available when the REX prefix is used.

> 답: True

**14.** (True/False): In native 64-bit mode, you can use 16-bit real mode, but not the virtual-8086
mode.

> 답: False

**15.** (True/False): The x86-64 processors have 4 more general-purpose registers than the x86
processors.

> 답: False 8개 추가 R8 ~ R15

**16.** (True/False): The 64-bit version of Microsoft Windows does not support virtual-8086 mode.

> 답: True

**17.** (True/False): DRAM can only be erased using ultraviolet light.

> 답: False DRAM은 휘발성

**18.** (True/False): In 64-bit mode, you can use up to eight floating-point registers.

> 답: True

**19.** (True/False): A bus is a plastic cable that is attached to the motherboard at both ends, but
does not sit directly on the motherboard.

> 답: False 마더보드에 직접 새겨진 선

**20.** (True/False): CMOS RAM is the same as static RAM, meaning that it holds its value without any extra power or refresh cycles.

> 답: False 값을 유지하려면 CMOS배터리가 필요

**21.** (True/False): PCI connectors are used for graphics cards and sound cards.

> 답: True

**22.** (True/False): The 8259A is a controller that handles external interrupts from hardware
devices.

> 답: True

**23.** (True/False): The acronym PCI stands for programmable component interface.

> 답: False (Peripheral Component Interconnect) 이다.

**24.** (True/False): VRAM stands for virtual random access memory.

> 답: False (video RAM) 이다.

**25.** At which level(s) can an assembly language program manipulate input/output?

> 답: High-level language functions, Operating system, BIOS

**26.** Why do game programs often send their sound output directly to the sound card’s hardware
ports?

> 답: 레벨 0 (하드웨어) 수준에서 프로그램을 사용하면 속도가 아주 빠름
