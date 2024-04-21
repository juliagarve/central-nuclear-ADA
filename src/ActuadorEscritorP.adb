package body ActuadorEscritorP is
     protected body ActuadorEscritor is
      procedure iniciar is
      begin
         --null;
         --he comentado en el main esperar los 260ms
         flagEscribir:=False;
         flagPuertaAbierta:=False;
         nextTime:=Clock+salidaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
      end iniciar;

      entry escribir(r: access Reactor;  entrada:access SensorLector)
         when flagEscribir is
      begin
         flagEscribir:=False;
         -- entrada.leerTempMuestreada
         dato:= r.leerTemp;
         if dato < 1500 then
            if flagPuertaAbierta = True then
               flagPuertaAbierta:=False;
            end if;
         else
            if flagPuertaAbierta = False then
               flagPuertaAbierta:= True;
            end if;
            r.escribir(-50);
         end if;
         nextTime:=jitter+nextTime;
      end escribir;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         flagEscribir:=True;
         nextTime:=nextTime+salidaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
      end Timer;
   end ActuadorEscritor;

end ActuadorEscritorP;

