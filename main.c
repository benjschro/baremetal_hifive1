#include <stdint.h>
#include <stdbool.h>

#define UART0_BASE 0x10013000
#define UART_TXDATA_OFFSET 0x00
#define UART_TXCTRL_OFFSET 0x08

#define UART0_TXDATA (volatile uint32_t *)(UART0_BASE + UART_TXDATA_OFFSET)
#define UART0_TXCTRL (volatile uint32_t *)(UART0_BASE + UART_TXCTRL_OFFSET)


void enableUART0() {
    *UART0_TXCTRL |= 0x01;
}

void writeToUART0(void *data, uint32_t dataLen) {
    for (int i = 0; i < dataLen; i++) {
        while (*UART0_TXDATA < 0);
        *UART0_TXDATA = *(((uint8_t *)data) + i);
    }
}

char helloMessage[] = "Hello!";

void main() {
    enableUART0();
    writeToUART0(helloMessage, 7);
    for(;;);
}
