package body SensorLectorP is
   protected body SensorLector is
      procedure iniciar is
      begin
         datoDisponible:=False;
         nextTime:=Clock+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end iniciar;

      entry leer(dato:out Integer; r: access Reactor)
        when datoDisponible is
      begin
         dato:= r.leerTemp;
         temperaturaMuestrada:=dato;
         datoDisponible:=False;
         if dato > 1750 then
            Text_IO.Put_Line("La temperatura es superior a 1750");
         end if;
         nextTime:=jitter+nextTime;
      end leer;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --obtener el dato y cargarlo en leyendo
         datoDisponible:=True;
         nextTime:=nextTime+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

      function leerTempMuestreada return Integer is
      begin
         return temperaturaMuestrada;
      end leerTempMuestreada;

   end SensorLector;
end SensorLectorP;


