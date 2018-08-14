with Interfaces; use Interfaces;

with PicoSOC;      use PicoSOC;
with PicoSOC.UART; use PicoSOC.UART;

procedure Firmware is

   Led_Timer : Unsigned_32 := 0;
begin

   --  Switch to dual IO mode
   SPICTRL := (SPICTRL and (not 16#007F0000#)) or 16#00400000#;

   Set_Baud_Rate (115200);

   --  Blink the user LED
   loop
      Leds := Shift_Right (Led_Timer, 14);
      Led_Timer := Led_Timer + 1;
      New_Line;
      Put_Line ("Hello from PicoSOC on TinyFPGA-BX!");
      Put_Line ("Make with Ada!");
      New_Line;
   end loop;
end Firmware;
