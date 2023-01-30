# Planificación-y-seguimiento-de-trayectorias-para-formación-de-robots-submarinos
Seguimiento de trayectoria basado en Purepursuit y control de formación empleado cinemática inversa para robots submarinos. Para poder realizar la simulación satisfactoriamente siga el siguiente procedimiento:

Existen 3 variables que el usuario puede modificar para cambiar el comportamiento de la simulación:
+ TipoM 
+ TipoF
+ lookAhead

# TipoM
Esta variable se encarga de modificar el mapa de la simulación. Esto se puede hacer cambiando su valor de 1 a 2. Se encuentra en fichero main.
1 --> Mapa llano
2 --> Mapa dunoso

# TipoF
Esta variable se encarga de modificar la trayectoria de la simulación. Esto se puede hacer cambiando su valor de 1, 2, 3 y 4. Se encuentra en fichero main.
1 --> Trayectoria recta.
2 --> Trayectoria curva plana.
3 --> Trayectoria en espiral.
4 --> Trayectoria de barrido. 

Importante: El mapa 1) se puede combinar con todas las trayectorias pero el mapa 2) esta adaptado unicamente para la trayectoria de barrido.

# Simulación
Para relazar la simulación simplemente se tiene que dar a run desde el main. Se puede jugar con la variable lookAhead (se encuentra en la función purepursuit) dandole distintos valores y viendo como afecta esto al seguimiento del recorrido y a la formación. Por defecto las gráficas de resultados se encuntran comentadas, para descomentarlas, diríjase al fichero main, a la parte de "graficas de datos" y descomente las lineas. También es posible realizar la simulación solo del purepursuit sin la formación comentando las siguientes lineas: (76 a 80) (92 a 94) (97 a 99) (103) (107) (110 a 112).
