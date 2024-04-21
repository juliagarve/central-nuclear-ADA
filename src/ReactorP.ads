with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
package ReactorP is
   protected type Reactor is
      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure escribir(dato:Integer);
      function leerTemp return Integer;
   private
      temperatura:Integer:=1450;
   end Reactor;
end ReactorP;
