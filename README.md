# Simulación de Central Nuclear

Este proyecto simula el comportamiento de una central nuclear ficticia mediante un comportamiento simulado. En la central se tienen 3 reactores nucleares, cada uno controlando de manera independiente la temperatura del núcleo para evitar sobrepasar ciertos límites críticos.

## Funcionamiento Detallado de los Reactores

- La temperatura de cada reactor se muestrea cada 2 segundos. Al finalizar cada muestreo se envía un mensaje a una tarea coordinadora para indicar que el reactor está operativo.
- Si la temperatura es inferior a 1500º, no se toma ninguna acción.
- Si la temperatura es igual o superior a 1500º, se abre una compuerta para bajar la temperatura a razón de 50º por segundo.
- La compuerta se mantiene abierta mientras la temperatura sea superior a los 1500º.
- Si se supera la temperatura de 1750º, se imprime un mensaje de alerta y se mantiene la compuerta abierta.

## Tarea Coordinadora

Para controlar el correcto funcionamiento de cada reactor, existe una tarea coordinadora por cada uno que imprime un mensaje de alerta si no recibe un mensaje de alguna de las tareas que controla un reactor pasado un período de 3 segundos.

## Simulación de la Temperatura

Se crea una tarea que, cada 2 segundos, incrementa la temperatura de uno de los reactores en 150 grados. Este proceso simula el aumento de temperatura en los reactores.

