# BDDD
Material de la materia de BDDD

CONTENIDO TOMADO DE:
** Distributed database management systems, A Practical Approach, Saeed K. Rahimi, Frank S. Haug

## Enlaces

[Grupo drive base de datos distribuidas](https://drive.google.com/drive/folders/1XI_63xHAIQPeJnq_48AHhJsdpdzCzHwx?usp=sharing)
[redes](http://chennaicisco.blogspot.com/2013/02/configure-igrp-in-routers-to-enable.html)


[Informe proyecto BDDD](https://drive.google.com/drive/folders/1XI_63xHAIQPeJnq_48AHhJsdpdzCzHwx?usp=sharing)


[capturas 3](https://docs.google.com/document/d/1jx48QMMA6el_J53kBXjxH0utqqkv6NaY8VpxOGYKR5E/edit?usp=sharing)

[capturas 5](https://docs.google.com/document/d/1keQgY2U0vRRBPnTWSPhk622RderoMbeb3FAtLRWEfnM/edit?usp=sharing)

# CONTENIDO

* [Tema proyecto.](#id1)

* [Objetivos del proyecto.](#id2)

* [Descripción del proyecto.](#id3)

* [Modelo Entidad Relación.](#id4)

* [Conclusiones.](#id5)
  

<a name="id1"></a>

# TEMA PROYECTO

BASE DE DATOS DE EMPRESA DE SOLUCIONES INFORMÁTICAS.


<a name="id2"></a>

# OBJETIVOS


1.    Desarrollar una base de datos que permita presentar información detallada acerca de cada proyecto que lleva a cabo la empresa. Incluye información como: El servicio que se prestara en dicho proyecto, cliente que solicito el proyecto, empleados que están a cargo del proyecto.
 
2.    Implementar los conceptos a cerca de bases de datos distribuidas para poder afrontar el caso de las dos sucursales planteadas como problema.
 
3.    Representar dicha base de datos en dos modelos bien conocidos para una mejor comprensión de lo que se va a realizar, comprendiendo sus partes como relaciones entre las mismas.
 
4.    Familiarizarse con las nuevas herramientas que nos facilitarán la creación de los modelos de base de datos a realizar.


<a name="id3"></a>

## DESCRIPCIÓN 

La empresa ACP Solutions posee dos sucursales una en la ciudad de Quito y la segunda ubicada en la ciudad de Cuenca. Se desea crear una base de datos distribuida para gestionar la información de clientes, empleados  y proyectos, así como los servicios vinculados a cada proyecto.
Se puede definir las siguientes especificaciones en cuanto al escenario:
 
*  Cada cliente puede solicitar uno o varios proyectos, mientras que cada proyecto pertenece a un solo cliente.
 
*  Cada proyecto  requiere de un servicio que va ser brindado, y un servicio en concreto puede ser requerido por varios proyectos.
*   Un proyecto puede asignarse a varios empleados, y cada empleado trabaja en un proyecto específico.
 
*   Un empleado puede tener una relación de jerarquía superior sobre otros empleados.

<a name="id4"></a>

#  MODELO ENTIDAD RELACIÓN Y ESPECIFICACIONES DE LA BASE


Los constraint implementados en nuestra base datos con la clave primaria con valor único.

## Diagrama Entidad Relación

![image](https://user-images.githubusercontent.com/50051312/58880499-9fc53600-869d-11e9-87ff-cbc3e8b9221c.png)

## UML Modelo Entidad Relación

![image](https://user-images.githubusercontent.com/50051312/58880910-a3a58800-869e-11e9-821b-03b4d4f50ce8.png)


     
Fig 1. Muestra el modelo entidad relación de la base de datos para la gestión de proyectos.



<a name="id5"></a>
#  CONCLUSIONES

* Se logró plantear el problema a solucionar con la base de datos
* Se completo el diagrama modelo entidad relación a ejecutarse en el proyecto de implementación.
* Se plantea la solución por fragmentación para el segundo bimestre
* Como principales constraint el uso de primary y foreing key son los más utilizados para establecer cada relación de todas nuestras
entidades de la base de datos.

