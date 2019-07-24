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

