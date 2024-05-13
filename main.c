#include <stdint.h>
#include <stdio.h>

typedef struct __attribute__((packed)) {
    uint8_t a;
    uint16_t b;
    uint8_t c;
    uint32_t d;
    uint64_t e;
} T5;

// Function to create a T5 instance
T5 create_t5(uint8_t a, uint16_t b, uint8_t c, uint32_t d, uint64_t e) {
    T5 instance = {a, b, c, d, e};
    return instance;
}

// Function to print T5 values
void print_t5(T5 instance) {
    printf("a: 0x%X\n", instance.a);
    printf("b: 0x%X\n", instance.b);
    printf("c: 0x%X\n", instance.c);
    printf("d: 0x%X\n", instance.d);
    printf("e: 0x%lX\n", instance.e);
    printf("sizeof(T5): %ld\n", sizeof(T5));
}

// Exported function to be called from Julia
void display_t5() {
    T5 t5_instance = create_t5(0x12, 0x1234, 0x56, 0x12345678, 0x123456789ABCDEF0);
    print_t5(t5_instance);
}
