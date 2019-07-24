/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     18/6/2019 15:54:32                           */
/*==============================================================*/


alter table AULA
   drop constraint FK_AULA_RELATIONS_SUCURSAL;

alter table CALIFICACIONES
   drop constraint FK_CALIFICA_RELATIONS_ESTUDIAN;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_RELATIONS_INSTRUCT;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_RELATIONS_CALIFICA;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_RELATIONS_NIVEL;

alter table INSTRUCTOR
   drop constraint FK_INSTRUCT_RELATIONS_AULA;

alter table NIVEL
   drop constraint FK_NIVEL_RELATIONS_INSTRUCT;

alter table NIVEL
   drop constraint FK_NIVEL_RELATIONS_ESTUDIAN;

drop index RELATIONSHIP_1_FK;

drop table AULA cascade constraints;

drop index RELATIONSHIP_6_FK;

drop table CALIFICACIONES cascade constraints;

drop index RELATIONSHIP_7_FK;

drop index RELATIONSHIP_5_FK;

drop index RELATIONSHIP_3_FK;

drop table ESTUDIANTE cascade constraints;

drop index RELATIONSHIP_2_FK;

drop table INSTRUCTOR cascade constraints;

drop index RELATIONSHIP_8_FK;

drop index RELATIONSHIP_4_FK;

drop table NIVEL cascade constraints;

drop table SUCURSAL cascade constraints;

/*==============================================================*/
/* Table: AULA                                                  */
/*==============================================================*/
create table AULA  (
   ID_AULA              INTEGER                         not null,
   ID_SUCURSAL          INTEGER,
   CODIGO_AULA          CHAR(15),
   CAPACIDAD            INTEGER,
   constraint PK_AULA primary key (ID_AULA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on AULA (
   ID_SUCURSAL ASC
);

/*==============================================================*/
/* Table: CALIFICACIONES                                        */
/*==============================================================*/
create table CALIFICACIONES  (
   ID_CALIFICACIONES    INTEGER                         not null,
   ID_ESTUDIANTE        INTEGER,
   CEDULA_ESTUDIANTE    INTEGER,
   CALIFICACION01       NUMBER(2,2),
   CALIFICACION02       NUMBER(2,2),
   CALIFICACION03       NUMBER(2,2),
   constraint PK_CALIFICACIONES primary key (ID_CALIFICACIONES)
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on CALIFICACIONES (
   ID_ESTUDIANTE ASC,
   CEDULA_ESTUDIANTE ASC
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE  (
   ID_ESTUDIANTE        INTEGER                         not null,
   CEDULA_ESTUDIANTE    INTEGER                         not null,
   ID_NIVEL             INTEGER,
   ID_INSTRUCTOR        INTEGER,
   CEDULA               INTEGER,
   ID_CALIFICACIONES    INTEGER,
   NOMBRE_ESTUDIANTE    CHAR(50),
   APELLIDO_ESTUDIANTE  CHAR(50),
   TELEFONO_ESTUDIANTE  CHAR(10),
   CORREO_ESTUDIANTE    CHAR(50),
   constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE, CEDULA_ESTUDIANTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on ESTUDIANTE (
   ID_INSTRUCTOR ASC,
   CEDULA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on ESTUDIANTE (
   ID_CALIFICACIONES ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_7_FK on ESTUDIANTE (
   ID_NIVEL ASC
);

/*==============================================================*/
/* Table: INSTRUCTOR                                            */
/*==============================================================*/
create table INSTRUCTOR  (
   ID_INSTRUCTOR        INTEGER                         not null,
   CEDULA               INTEGER                         not null,
   ID_AULA              INTEGER,
   NOMBRE_INSTRUCTOR    CHAR(50),
   APELLIDO_INSTRUCTOR  CHAR(50),
   DIRECCION_INSTRUCTOR VARCHAR2(100),
   TELEFONO_INSTRUCTOR  CHAR(10),
   NACIONALIDAD_INSTRUCTOR CHAR(100),
   FECHANACIMIENTO_INSTRUCTOR DATE,
   constraint PK_INSTRUCTOR primary key (ID_INSTRUCTOR, CEDULA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on INSTRUCTOR (
   ID_AULA ASC
);

/*==============================================================*/
/* Table: NIVEL                                                 */
/*==============================================================*/
create table NIVEL  (
   ID_NIVEL             INTEGER                         not null,
   ID_ESTUDIANTE        INTEGER,
   CEDULA_ESTUDIANTE    INTEGER,
   ID_INSTRUCTOR        INTEGER,
   CEDULA               INTEGER,
   NOMBRE_NIVEL         CHAR(50),
   FECHA_INICIO         DATE,
   FECHA_FIN            DATE,
   constraint PK_NIVEL primary key (ID_NIVEL)
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on NIVEL (
   ID_INSTRUCTOR ASC,
   CEDULA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_8_FK on NIVEL (
   ID_ESTUDIANTE ASC,
   CEDULA_ESTUDIANTE ASC
);

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL  (
   ID_SUCURSAL          INTEGER                         not null,
   NOMBRE_SUCURSAL      CHAR(50),
   CIUDAD_SUCURSAL      CHAR(50),
   DIRECCION_SUCURSAL   CHAR(50),
   TELEFONO_SUCURSAL    CHAR(10),
   constraint PK_SUCURSAL primary key (ID_SUCURSAL)
);

alter table AULA
   add constraint FK_AULA_RELATIONS_SUCURSAL foreign key (ID_SUCURSAL)
      references SUCURSAL (ID_SUCURSAL);

alter table CALIFICACIONES
   add constraint FK_CALIFICA_RELATIONS_ESTUDIAN foreign key (ID_ESTUDIANTE, CEDULA_ESTUDIANTE)
      references ESTUDIANTE (ID_ESTUDIANTE, CEDULA_ESTUDIANTE);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_INSTRUCT foreign key (ID_INSTRUCTOR, CEDULA)
      references INSTRUCTOR (ID_INSTRUCTOR, CEDULA);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_CALIFICA foreign key (ID_CALIFICACIONES)
      references CALIFICACIONES (ID_CALIFICACIONES);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_NIVEL foreign key (ID_NIVEL)
      references NIVEL (ID_NIVEL);

alter table INSTRUCTOR
   add constraint FK_INSTRUCT_RELATIONS_AULA foreign key (ID_AULA)
      references AULA (ID_AULA);

alter table NIVEL
   add constraint FK_NIVEL_RELATIONS_INSTRUCT foreign key (ID_INSTRUCTOR, CEDULA)
      references INSTRUCTOR (ID_INSTRUCTOR, CEDULA);

alter table NIVEL
   add constraint FK_NIVEL_RELATIONS_ESTUDIAN foreign key (ID_ESTUDIANTE, CEDULA_ESTUDIANTE)
      references ESTUDIANTE (ID_ESTUDIANTE, CEDULA_ESTUDIANTE);

