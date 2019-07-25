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

``` type:javascript

 /*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     24/7/2019 12:23:57                           */
/*==============================================================*/


alter table ASIGNACION
   drop constraint FK_ASIGNACI_FK_PROYEC_PROYECTO;

alter table ASIGNACION
   drop constraint FK_ASIGNACI_FK_SERVIC_SERVICIO;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_FK_PROYEC_PROYECTO;

alter table PROYECTO
   drop constraint FK_PROYECTO_FK_CLIENT_CLIENTE;

alter table PROYECTO
   drop constraint FK_PROYECTO_FK_SEDE_SEDE;

drop index FK_SERVICIO_FK;

drop index FK_PROYECTOASIG_FK;

drop table ASIGNACION cascade constraints;

drop table CLIENTE cascade constraints;

drop index FK_PROYECTO_FK;

drop table EMPLEADO cascade constraints;

drop index FK_SEDE_FK;

drop index FK_CLIENTE_FK;

drop table PROYECTO cascade constraints;

drop table SEDE cascade constraints;

drop table SERVICIO cascade constraints;

/*==============================================================*/
/* Table: ASIGNACION                                            */
/*==============================================================*/
create table ASIGNACION  (
   ASINGNACIONID        NUMBER(8)                       not null,
   PROYECTOID           NUMBER(8)                       not null,
   SERIVCIOID           NUMBER(8)                       not null,
   constraint PK_ASIGNACION primary key (ASINGNACIONID)
);

/*==============================================================*/
/* Index: FK_PROYECTOASIG_FK                                    */
/*==============================================================*/
create index FK_PROYECTOASIG_FK on ASIGNACION (
   PROYECTOID ASC
);

/*==============================================================*/
/* Index: FK_SERVICIO_FK                                        */
/*==============================================================*/
create index FK_SERVICIO_FK on ASIGNACION (
   SERIVCIOID ASC
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE  (
   CLIENTEID            NUMBER(8)                       not null,
   CLI_NOMBRE           VARCHAR2(30),
   CLI_APELLIDO         VARCHAR2(30),
   DIRECCION            VARCHAR2(30),
   constraint PK_CLIENTE primary key (CLIENTEID)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO  (
   EMPLEADOID           NUMBER(8)                       not null,
   PROYECTOID           NUMBER(8)                       not null,
   EM_NOMBRE            VARCHAR2(30),
   EM_APELLIDO          VARCHAR2(30),
   SUELDO_EM            NUMBER(8),
   constraint PK_EMPLEADO primary key (EMPLEADOID)
);

/*==============================================================*/
/* Index: FK_PROYECTO_FK                                        */
/*==============================================================*/
create index FK_PROYECTO_FK on EMPLEADO (
   PROYECTOID ASC
);

/*==============================================================*/
/* Table: PROYECTO                                              */
/*==============================================================*/
create table PROYECTO  (
   PROYECTOID           NUMBER(8)                       not null,
   CLIENTEID            NUMBER(8)                       not null,
   SEDEID               NUMBER(8)                       not null,
   PROI_NOMBRE          VARCHAR2(30),
   ESTADO               RAW(2),
   FECHA_ENTREGA        DATE,
   constraint PK_PROYECTO primary key (PROYECTOID)
);

/*==============================================================*/
/* Index: FK_CLIENTE_FK                                         */
/*==============================================================*/
create index FK_CLIENTE_FK on PROYECTO (
   CLIENTEID ASC
);

/*==============================================================*/
/* Index: FK_SEDE_FK                                            */
/*==============================================================*/
create index FK_SEDE_FK on PROYECTO (
   SEDEID ASC
);

/*==============================================================*/
/* Table: SEDE                                                  */
/*==============================================================*/
create table SEDE  (
   SEDEID               NUMBER(8)                       not null,
   CIUDAD               VARCHAR2(30),
   constraint PK_SEDE primary key (SEDEID)
);

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO  (
   SERIVCIOID           NUMBER(8)                       not null,
   TEMA                 VARCHAR2(30),
   PRECIO               NUMBER(8),
   DESCRIPCION          VARCHAR2(30),
   constraint PK_SERVICIO primary key (SERIVCIOID)
);

alter table ASIGNACION
   add constraint FK_ASIGNACI_FK_PROYEC_PROYECTO foreign key (PROYECTOID)
      references PROYECTO (PROYECTOID);

alter table ASIGNACION
   add constraint FK_ASIGNACI_FK_SERVIC_SERVICIO foreign key (SERIVCIOID)
      references SERVICIO (SERIVCIOID);

alter table EMPLEADO
   add constraint FK_EMPLEADO_FK_PROYEC_PROYECTO foreign key (PROYECTOID)
      references PROYECTO (PROYECTOID);

alter table PROYECTO
   add constraint FK_PROYECTO_FK_CLIENT_CLIENTE foreign key (CLIENTEID)
      references CLIENTE (CLIENTEID);

alter table PROYECTO
   add constraint FK_PROYECTO_FK_SEDE_SEDE foreign key (SEDEID)
      references SEDE (SEDEID);



```


  
<a name="id7"></a>
#  CONCLUSIONES

* Se logró plantear el problema a solucionar con la base de datos
* Se completo el diagrama modelo entidad relación a ejecutarse en el proyecto de implementación.
* Se plantea la solución por fragmentación para el segundo bimestre
* Como principales constraint el uso de primary y foreing key son los más utilizados para establecer cada relación de todas nuestras
entidades de la base de datos.

