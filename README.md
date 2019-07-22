# BDDD
Material de la materia de BDDD

CONTENIDO TOMADO DE:
** Distributed database management systems, A Practical Approach, Saeed K. Rahimi, Frank S. Haug

## Enlaces

[Grupo drive base de datos distribuidas](https://drive.google.com/drive/folders/1XI_63xHAIQPeJnq_48AHhJsdpdzCzHwx?usp=sharing)
[redes](http://chennaicisco.blogspot.com/2013/02/configure-igrp-in-routers-to-enable.html)


[Informe proyecto BDDD](https://drive.google.com/drive/folders/1XI_63xHAIQPeJnq_48AHhJsdpdzCzHwx?usp=sharing)


[capturas practica 3](https://docs.google.com/document/d/1jx48QMMA6el_J53kBXjxH0utqqkv6NaY8VpxOGYKR5E/edit?usp=sharing)

[capturas practica 5](https://docs.google.com/document/d/1keQgY2U0vRRBPnTWSPhk622RderoMbeb3FAtLRWEfnM/edit?usp=sharing)

[captura pratica 6](https://drive.google.com/open?id=1szGD76vJcB7aY4s-acaPf8v7i9dT0HL08-aqV04nFII)


# CONTENIDO

* [Tema proyecto.](#id1)

* [Objetivos del proyecto.](#id2)

* [Descripción del proyecto.](#id3)

* [Modelo Entidad Relación.](#id4)

* [Esquema de fragmentación y replicacion.](#id5)

* [Script.](#id6)

* [Conclusiones.](#id7)

  

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
# Esquema de Fragmentación– Replicación
  ## Roles
  
  Las sedes están en dos ciudades, Quito y Cuenca.
En cada sede se realizarán proyectos concernientes a desarrollo de software, se gestionara la nómina de los empleados de dicha sede y los clientes de dicha sede.

La Sede en la ciudad de Quito se encargará de los proyectos de Desarrollo Web y la sede en Cuenca se encarga de los proyectos de Desarrollo Móvil.

  
  ## Fragmentación– Replicación

###	TABLA SEDE 

La –TABLA SEDE- se replica; ya que no es muy dinámica. Es poco probable que se inaugure otra sede.

SEDE -> se replica

### TABLA PROYECTO
Fragmentación Horizontal Primaria
La –TABLA PROYECTO- se fragmenta en función de la SEDE.

![image](https://user-images.githubusercontent.com/50051312/61537357-9816e200-a9fc-11e9-8794-9fe4cf97b577.png)

### TABLA SERVICIO
Replicada
La –TABLA SERVICIO- se replica ya que diferentes proyectos en diferentes sedes pueden realizar el mismo SERVICIO.

SERVICIO -> se replica


### TABLA EMPLEADO
Fragmentación Horizontal Derivada,  en función de PROYECTO i
La –TABLA EMPLEADO- se fragmenta en función de cada proyecto.

![image](https://user-images.githubusercontent.com/50051312/61537450-d2807f00-a9fc-11e9-9d0d-d74d57f4b832.png)

### TABLA CLIENTE
Fragmentación Horizontal Derivada, en función de PROYECTO i
La –TABLA CLIENTE- se fragmenta en función del PROYECTO i; ya los clientes solicitan un proyecto que está en una respectiva SEDE que atienda una área.  

![image](https://user-images.githubusercontent.com/50051312/61537481-e7f5a900-a9fc-11e9-8eb7-1b3fdc2b0b65.png)


  ## Esquema asignación
  
| ESQUEMA DE ASIGNACIÓN |            |            |            |            |
|:---------------------:|------------|------------|------------|------------|
| **SEDE**                | SEDE       |            | SEDE       |            |
| **PROYECTO**             | PROYECTO 1 |            | PROYECTO 2 |            |
| **EMPLEADO**              | EMPLEADO 1 | EMPLEADO 2 | EMPLEADO 1 | EMPLEADO 2 |
| **SERVICIO**              | SERVICIO   |            | SERVICIO   |            |
| **CLIENTE**               | CLIENTE    |            | CLIENTE    |            |

<a name="id6"></a>
# SCRIPT

**Crear base**
``` type:javascript

CREATE DATABASE  `proyecto1`
ALTER SESSION SET CURRENT_SCHEMA = proyecto1;

```
**Tabla asignación**

``` type:javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE asignacion';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asignacion` (
  Servicio_idServicio number(10) NOT NULL,
  Proyecto_idProyecto number(10) NOT NULL,
  PRIMARY KEY (Servicio_idServicio,Proyecto_idProyecto)
  CREATE INDEX fk_Servicio_has_Proyecto_Proyecto1_idx ON `asignacion` (Proyecto_idProyecto)
  CREATE INDEX fk_Servicio_has_Proyecto_Servicio1_idx ON `asignacion` (Servicio_idServicio),
  CONSTRAINT fk_Servicio_has_Proyecto_Proyecto1 FOREIGN KEY (Proyecto_idProyecto) REFERENCES `proyecto` (idProyecto),
  CONSTRAINT fk_Servicio_has_Proyecto_Servicio1 FOREIGN KEY (Servicio_idServicio) REFERENCES `servicio` (idServicio)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```


**Tabla cliente**

``` type:javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE cliente';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  idCliente number(10) NOT NULL,
  nombreCliente varchar2(45) NOT NULL,
  apellidoCliente varchar2(45) NOT NULL,
  direccionCliente varchar2(45) NOT NULL,
  PRIMARY KEY (idCliente)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```

**Tabla emppleado**

``` type:javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE empleado';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
  idEmpleado number(10) NOT NULL,
  nombreEmpleado varchar2(45) NOT NULL,
  apellidoEmpleado varchar2(45) NOT NULL,
  sueldoEmpleado number(7,2) NOT NULL,
  Empleado_idEmpleado number(10) DEFAULT NULL,
  Proyecto_idProyecto number(10) DEFAULT NULL,
  PRIMARY KEY (idEmpleado)
  CREATE INDEX fk_Empleado_Empleado1_idx ON `empleado` (Empleado_idEmpleado)
  CREATE INDEX fk_Empleado_Proyecto1_idx ON `empleado` (Proyecto_idProyecto),
  CONSTRAINT fk_Empleado_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES `empleado` (idEmpleado),
  CONSTRAINT fk_Empleado_Proyecto1 FOREIGN KEY (Proyecto_idProyecto) REFERENCES `proyecto` (idProyecto)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```

**tabla proyecto**


``` type:javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE proyecto';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyecto` (
  idProyecto number(10) NOT NULL,
  nombreProyecto varchar2(45) NOT NULL,
  estadoProyecto varchar2(45) NOT NULL,
  fechaSolicitudProyecto date NOT NULL,
  fechaEntregaProyecto date NOT NULL,
  Sede_idSede number(10) NOT NULL,
  Cliente_idCliente number(10) NOT NULL,
  PRIMARY KEY (idProyecto)
  CREATE INDEX fk_Proyecto_Sede1_idx ON `proyecto` (Sede_idSede)
  CREATE INDEX fk_Proyecto_Cliente1_idx ON `proyecto` (Cliente_idCliente),
  CONSTRAINT fk_Proyecto_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES `cliente` (idCliente),
  CONSTRAINT fk_Proyecto_Sede1 FOREIGN KEY (Sede_idSede) REFERENCES `sede` (idSede)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```

**sede**

``` type: javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE sede';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sede` (
  idSede number(10) NOT NULL,
  ciudadSede varchar2(45) NOT NULL,
  PRIMARY KEY (idSede)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
```


**tabla servicio**
``` type:javascript
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE servicio';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicio` (
  idServicio number(10) NOT NULL,
  temaServicio varchar2(45) NOT NULL,
  precioServicio number(8,2) NOT NULL,
  descripcionServicio varchar2(45) NOT NULL,
  PRIMARY KEY (idServicio)
); ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```


  
<a name="id7"></a>
#  CONCLUSIONES

* Se logró plantear el problema a solucionar con la base de datos
* Se completo el diagrama modelo entidad relación a ejecutarse en el proyecto de implementación.
* Se plantea la solución por fragmentación para el segundo bimestre
* Como principales constraint el uso de primary y foreing key son los más utilizados para establecer cada relación de todas nuestras
entidades de la base de datos.

