with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with Ada.Calendar;
use Ada.Calendar;
with SensorLectorP;
use SensorLectorP;
with ReactorP;
use ReactorP;
with ActuadorEscritorP;
use ActuadorEscritorP;
with Ada.Numerics.Discrete_Random;

procedure Main is

   sl1:aliased SensorLector;
   ae1:aliased  ActuadorEscritor;
   r1:aliased Reactor;
   sl2:aliased SensorLector;
   ae2:aliased  ActuadorEscritor;
   r2:aliased Reactor;
   sl3:aliased SensorLector;
   ae3:aliased  ActuadorEscritor;
   r3:aliased Reactor;

   task type Iniciador;
   task body Iniciador is
   begin
      sl1.iniciar;
      ae1.iniciar;
      sl2.iniciar;
      ae2.iniciar;
      sl3.iniciar;
      ae3.iniciar;
   end Iniciador;
   Ini:Iniciador;

   task type Coordinador(numReactor: Integer) is
      entry mensaje;
   end Coordinador;
   task body Coordinador is
   begin
      loop
         select
            accept mensaje do
               null;
            end mensaje;
         or delay 3.0;
	    if numReactor =1 then
	       Text_IO.Put_Line("ALERTA: No se ha recibo mensaje del reactor 1");
	    elsif numReactor = 2 then
	       Text_IO.Put_Line("ALERTA: No se ha recibo mensaje del reactor 2");
	    else
	       Text_IO.Put_Line("ALERTA: No se ha recibo mensaje del reactor 3");
	    end if;
         end select;
      end loop;
   end Coordinador;

   c1:Coordinador(1);
   c2:Coordinador(2);
   c3:Coordinador(3);

   task type Lectura(entrada:access SensorLector; r:access Reactor; numReactor: Integer);
   task body Lectura is
      datoEntrada:Integer;
   begin
      loop
         entrada.leer(datoEntrada, r);
         Text_IO.Put_Line("Reactor "&numReactor'Img&" muestreo temperatura: "&datoEntrada'Img);
         if numReactor =1 then
	    c1.mensaje;
	 elsif numReactor = 2 then
	    c2.mensaje;
	 else
	    c3.mensaje;
	 end if;
      end loop;
   end Lectura;

   task type Escritura(salida:access ActuadorEscritor; r:access Reactor; entrada:access SensorLector);
   task body Escritura is
   begin
      -- puede que haya que añadir aqui un mensaje de aceptar la temperatura leida por Lectura si se utilizar en ACtuadorEscritor la tempMuestreada y no la real.
      loop
            salida.escribir(r, entrada);
      end loop;
   end Escritura;

   task type AlgoritmoFuncionamientoTemperatura(r1:access Reactor; r2:access Reactor; r3:access Reactor);
   task body AlgoritmoFuncionamientoTemperatura is
      sig:Ada.Real_Time.Time;
      intervalo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(2000);
      datoSalida:constant Integer:=150;
      subtype aleatorioReactor is Integer range 1..3;
      package Aleatorio is new Ada.Numerics.Discrete_Random(aleatorioReactor);
      seed : Aleatorio.Generator;
      temp: Integer;
   begin
      sig:=Clock+intervalo;
      loop
         Aleatorio.Reset(seed);
         temp:=Aleatorio.Random(seed);
	 if temp = 1 then
	    r1.escribir(datoSalida);
	 elsif temp = 2 then
	    r2.escribir(datoSalida);
	 else
	    r3.escribir(datoSalida);
         end if;
         delay until sig;
         sig:=sig+intervalo;
      end loop;
   end AlgoritmoFuncionamientoTemperatura;

   l1:Lectura(sl1'Access, r1'Access,1);
   e1:Escritura(ae1'Access, r1'Access, sl1'Access);
   l2:Lectura(sl2'Access, r2'Access,2);
   e2:Escritura(ae2'Access, r2'Access, sl2'Access);
   l3:Lectura(sl3'Access, r3'Access,3);
   e3:Escritura(ae3'Access, r3'Access, sl3'Access);
   funcionamientoTemperatura:AlgoritmoFuncionamientoTemperatura(r1'Access, r2'Access, r3'Access);

begin
   null;
end Main;
