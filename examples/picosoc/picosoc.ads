with Interfaces; use Interfaces;
with System;

package PicoSOC is

   ---------------
   -- Registers --
   ---------------

   SPICTRL : Unsigned_32
     with Volatile, Address => System'To_address (16#02000000#);

   UART_CLKDIV : Unsigned_32
     with Volatile, Address => System'To_address (16#02000004#);

   UART_Data : Unsigned_32
     with Volatile, Address => System'To_address (16#02000008#);

   Leds : Unsigned_32
     with Volatile, Address => System'To_address (16#03000000#);

end PicoSOC;
