with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
with ReactorP;
use ReactorP;
with SensorLectorP;
use SensorLectorP;

package ActuadorEscritorP is
   protected type ActuadorEscritor is

      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry escribir(r: access Reactor;  entrada:access SensorLector);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);
   private
      dato:Integer;
      nextTime:Ada.Real_Time.Time;
      salidaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     --1000ms -100 ms del output jitter
      salidaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(900);
      jitter:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(100);
      flagPuertaAbierta: Boolean;
      flagEscribir: Boolean;

   end ActuadorEscritor;
end ActuadorEscritorP;

