package body ReactorP is
   protected body Reactor is
      procedure escribir(dato:Integer) is
      begin
         temperatura:=temperatura+dato;
      end escribir;

      function leerTemp return Integer is
      begin
         return temperatura;
      end leerTemp;

   end Reactor;
end ReactorP;
