with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time.Timing_Events;
with Ada.Calendar;
use Ada.Calendar;
with Text_IO;
with ReactorP;
use ReactorP;

package SensorLectorP is
   protected type SensorLector is


      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry leer(dato:out Integer; r: access Reactor);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);
      function leerTempMuestreada return Integer;
   private
      nextTime:Ada.Real_Time.Time;
      nextTime2:Ada.Real_Time.Time;
      leyendo:Integer;
      datoDisponible:Boolean:=True;

     entradaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     --2000ms -100ms del input jitter
      entradaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1900);
      jitter:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(100);
      temperaturaMuestrada:Integer;
   end SensorLector;
end SensorLectorP;

