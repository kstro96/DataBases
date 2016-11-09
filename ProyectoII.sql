DROP TABLE contacto_de;
Drop Table Ubicacion;
DROP TABLE Pertenece_a;
DROP TABLE Deuda;
DROP TABLE Cuenta;

DROP INDEX Es_aprobada__IDX;
DROP TABLE Es_aprobada;
DROP TABLE Grupo;
DROP TABLE LiderGrupo;
DROP TABLE Transaccion;
DROP TABLE Usuario;


-- Generado por Oracle SQL Developer Data Modeler 4.1.3.901
--   en:        2016-11-09 12:03:07 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g

CREATE TABLE Cuenta
  (
    id     NUMBER (10) NOT NULL ,
    nombre VARCHAR2 (20 CHAR) NOT NULL ,
    costo  NUMBER (20) NOT NULL ,
    recibo CLOB ,
    fecha_creacion DATE NOT NULL ,
    Grupo_id       NUMBER (5) NOT NULL ,
    Usuario_id     NUMBER (5) NOT NULL ,
    comentarios CLOB
  ) ;
ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_PK PRIMARY KEY ( id ) ;


CREATE TABLE Deuda
  (
    cantidad   NUMBER (8) ,
    Usuario_id NUMBER (5) NOT NULL ,
    Cuenta_id  NUMBER (10) NOT NULL ,
    Id_Deuda   NUMBER (3) NOT NULL
  ) ;
ALTER TABLE Deuda ADD CONSTRAINT Deuda_PK PRIMARY KEY ( Cuenta_id, Usuario_id, Id_Deuda ) ;


CREATE TABLE Es_aprobada
  (
    Transaccion_id               NUMBER (5) NOT NULL ,
    Transaccion_Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Transaccion_Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Transaccion_Deuda_Id_Deuda   NUMBER (3) NOT NULL ,
    LiderGrupo_fechaIngreso      DATE NOT NULL ,
    LiderGrupo_Grupo_id          NUMBER (5) NOT NULL ,
    LiderGrupo_Usuario_id        NUMBER (5) NOT NULL ,
    fecha_aprobacion             DATE NOT NULL
  ) ;
CREATE INDEX Es_aprobada__IDX ON Es_aprobada
  (
    Transaccion_id ASC ,
    Transaccion_Deuda_Cuenta_id ASC ,
    Transaccion_Deuda_Usuario_id ASC ,
    Transaccion_Deuda_Id_Deuda ASC ,
    LiderGrupo_fechaIngreso ASC ,
    LiderGrupo_Grupo_id ASC ,
    LiderGrupo_Usuario_id ASC
  ) ;
ALTER TABLE Es_aprobada ADD CONSTRAINT Es_aprobada_PK PRIMARY KEY ( Transaccion_id, Transaccion_Deuda_Cuenta_id, Transaccion_Deuda_Usuario_id, Transaccion_Deuda_Id_Deuda, LiderGrupo_fechaIngreso, LiderGrupo_Grupo_id, LiderGrupo_Usuario_id ) ;


CREATE TABLE Grupo
  (
    id              NUMBER (5) NOT NULL ,
    nombre          VARCHAR2 (20 CHAR) NOT NULL ,
    UsuarioDueno_id NUMBER (5) NOT NULL ,
    Fecha_creacion  DATE NOT NULL ,
    disuelto        CHAR (1 CHAR) NOT NULL ,
    retenido        CHAR (1 CHAR) NOT NULL
  ) ;
ALTER TABLE Grupo ADD CONSTRAINT disuelto_Invalido CHECK ( disuelto IN ('N', 'S', 'Y')) ;
ALTER TABLE Grupo ADD CONSTRAINT retenido_Invalido CHECK ( retenido IN ('N', 'S', 'Y')) ;
ALTER TABLE Grupo ADD CONSTRAINT Grupo_PK PRIMARY KEY ( id ) ;


CREATE TABLE LiderGrupo
  (
    fechaIngreso     DATE NOT NULL ,
    fechaSalida      DATE ,
    Grupo_id         NUMBER (5) NOT NULL ,
    Usuario_id       NUMBER (5) NOT NULL ,
    fecha_aprobacion DATE
  ) ;
ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_PK PRIMARY KEY ( fechaIngreso, Grupo_id, Usuario_id ) ;


CREATE TABLE Pertenece_a
  (
    Usuario_id    NUMBER (5) NOT NULL ,
    Grupo_id      NUMBER (5) NOT NULL ,
    fecha_ingreso DATE NOT NULL ,
    fecha_salida  DATE
  ) ;
ALTER TABLE Pertenece_a ADD CONSTRAINT Pertenece_a_PK PRIMARY KEY ( Usuario_id, Grupo_id, fecha_ingreso ) ;


CREATE TABLE Transaccion
  (
    id               NUMBER (5) NOT NULL ,
    fecha            DATE NOT NULL ,
    cantidad         NUMBER (10) NOT NULL ,
    Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Deuda_Id_Deuda   NUMBER (3) NOT NULL ,
    Tipo             CHAR (1 CHAR) NOT NULL ,
    fecha_aprobacion DATE NOT NULL ,
    Tipo1            CHAR (1 CHAR) NOT NULL
  ) ;
ALTER TABLE Transaccion ADD CONSTRAINT Transaccion_PK PRIMARY KEY ( id, Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) ;


CREATE TABLE Ubicacion
  (
    fecha            DATE NOT NULL ,
    longitudGrados   NUMBER (3) NOT NULL ,
    longitudMinutos  NUMBER (2) NOT NULL ,
    longitudSegundos NUMBER (2) NOT NULL ,
    latitudGrados    NUMBER (3) NOT NULL ,
    latitudMinutos   NUMBER (2) NOT NULL ,
    latitudSegundos  NUMBER (2) NOT NULL ,
    Usuario_id       NUMBER (5) NOT NULL
  ) ;
ALTER TABLE Ubicacion ADD CONSTRAINT Ubicacion_PK PRIMARY KEY ( fecha, Usuario_id ) ;


CREATE TABLE Usuario
  (
    id               NUMBER (5) NOT NULL ,
    nombre           VARCHAR2 (50 CHAR) NOT NULL ,
    numeroTelefono   NUMBER (10) ,
    email            VARCHAR2 (50 CHAR) NOT NULL ,
    Paypal           VARCHAR2 (20) NOT NULL ,
    apellidos        VARCHAR2 (50 CHAR) NOT NULL ,
    fecha_nacimiento DATE DEFAULT '01/01/1900' NOT NULL ,
    genero           CHAR (1 CHAR) NOT NULL ,
    user_name        VARCHAR2 (20 CHAR) NOT NULL ,
    contrasena       VARCHAR2 (20 CHAR) NOT NULL ,
    "online"         CHAR (1 CHAR) DEFAULT 'N' NOT NULL
  ) ;
ALTER TABLE Usuario ADD CONSTRAINT Genero_Invalido CHECK ( genero  IN ('F', 'M')) ;
ALTER TABLE Usuario ADD CONSTRAINT Online_invalido CHECK ( "online" IN ('N', 'S', 'Y')) ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_PK PRIMARY KEY ( id ) ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_user_name_UN UNIQUE ( user_name ) ;


CREATE TABLE contacto_de
  (
    Usuario_id  NUMBER (5) NOT NULL ,
    Usuario_id1 NUMBER (5) NOT NULL
  ) ;
ALTER TABLE contacto_de ADD CONSTRAINT contacto_de_PK PRIMARY KEY ( Usuario_id, Usuario_id1 ) ;


ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_Grupo_FK FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Deuda ADD CONSTRAINT Deuda_Cuenta_FK FOREIGN KEY ( Cuenta_id ) REFERENCES Cuenta ( id ) ;

ALTER TABLE Deuda ADD CONSTRAINT Deuda_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Pertenece_a ADD CONSTRAINT FK_ASS_1 FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Pertenece_a ADD CONSTRAINT FK_ASS_2 FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE Es_aprobada ADD CONSTRAINT FK_ASS_3 FOREIGN KEY ( Transaccion_id, Transaccion_Deuda_Cuenta_id, Transaccion_Deuda_Usuario_id, Transaccion_Deuda_Id_Deuda ) REFERENCES Transaccion ( id, Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) ;

ALTER TABLE Es_aprobada ADD CONSTRAINT FK_ASS_4 FOREIGN KEY ( LiderGrupo_fechaIngreso, LiderGrupo_Grupo_id, LiderGrupo_Usuario_id ) REFERENCES LiderGrupo ( fechaIngreso, Grupo_id, Usuario_id ) ;

ALTER TABLE contacto_de ADD CONSTRAINT FK_ASS_5 FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE contacto_de ADD CONSTRAINT FK_ASS_6 FOREIGN KEY ( Usuario_id1 ) REFERENCES Usuario ( id ) ;

ALTER TABLE Grupo ADD CONSTRAINT Grupo_Usuario_FK FOREIGN KEY ( UsuarioDueno_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_Grupo_FK FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Transaccion ADD CONSTRAINT Transaccion_Deuda_FK FOREIGN KEY ( Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) REFERENCES Deuda ( Cuenta_id, Usuario_id, Id_Deuda ) ;

ALTER TABLE Ubicacion ADD CONSTRAINT Ubicacion_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             1
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

delete from cuenta;
delete from deuda;
delete from grupo;
delete from usuario;
delete from PERTENECE_A;
delete from TRANSACCION;

INSERT INTO usuario values(1,'andres',5645646,'asdasd@email.com','asddasddssd','contreras',TO_DATE('21-Ago-1986','DD-Mon-YY'),'M','andres111','468946431');
INSERT INTO usuario values(2,'felipe',6456487,'felipe@email.com','12121ww','ramirez',TO_DATE('22-Ago-1981','DD-Mon-YY'),'M','felipe4564','12468qd');
INSERT INTO usuario values(3,'carlos',11122235,'carlos@email.com','11aa1d12s1','rodrigez',TO_DATE('15-Ene-1984','DD-Mon-YY'),'M','carlos12q','87rer87r');
INSERT INTO usuario values(4,'pedro',78115775,'pedro@email.com','a121a1001a1','morales',TO_DATE('22-Ago-1985','DD-Mon-YY'),'M','pedro154e','124qqasd');
INSERT INTO usuario values(5,'pablo',6456487,'pablo@email.com','ppppaaab','ariza',TO_DATE('11-May-1989','DD-Mon-YY'),'M','pabloar','87121pgfh');
INSERT INTO usuario values(6,'alejandro',5489712,'alejandro@email.com','78dsafd','castro',TO_DATE('22-Jul-1983','DD-Mon-YY'),'M','ajenjadro45d','121err');
INSERT INTO usuario values(7,'santiago',712347,'santiago@email.com','445sdggf','salamanca',TO_DATE('12-Ago-1983','DD-Mon-YY'),'M','santiago12','78dsf41');
INSERT INTO usuario values(8,'julio',425215410,'julio@email.com','54fd12fg','torres',TO_DATE('12-Dic-1989','DD-Mon-YY'),'M','juliot12','45we1sdf');
INSERT INTO usuario values(9,'juan',456473,'juan@email.com','421dff12','casta�eda',TO_DATE('12-Oct-1986','DD-Mon-YY'),'M','juan4112','18112');
INSERT INTO usuario values(10,'santiago',425215410,'sanchuster@email.com','54fd12fg','chuster',TO_DATE('22-Dic-1986','DD-Mon-YY'),'M','chuster12','41213fgh');
INSERT INTO usuario values(11,'maria',1586478,'maria@email.com','sdfsdfc4','lozano',TO_DATE('14-Sep-1987','DD-Mon-YY'),'F','maria486d','13456dfd');
INSERT INTO usuario values(12,'juana',784523264,'juana@email.com','f1564sdf1d','perez',TO_DATE('12-Dic-1982','DD-Mon-YY'),'F','juana4564','1214541sdf');
INSERT INTO usuario values(13,'tulia',4252154,'tulia@email.com','45d4f5fs','jimenez',TO_DATE('12-Dic-1982','DD-Mon-YY'),'F','tulia154','011010101');
INSERT INTO usuario values(14,'lucia',425215410,'lucia@email.com','5454sdf','torres',TO_DATE('12-Dic-1987','DD-Mon-YY'),'F','lucia81d','31101101');


INSERT INTO grupo values(1,'grupo_1',1,TO_DATE('21-Ago-2016','DD-Mon-YY'),'N');
INSERT INTO grupo values(2,'grupo_2',2,TO_DATE('14-Feb-2016','DD-Mon-YY'),'N');
INSERT INTO grupo values(3,'grupo_3',3,TO_DATE('29-Ago-2016','DD-Mon-YY'),'N');
INSERT INTO grupo values(4,'grupo_4',1,TO_DATE('05-Ene-2016','DD-Mon-YY'),'N');
INSERT INTO grupo values(5,'grupo_5',1,TO_DATE('20-Ago-2016','DD-Mon-YY'),'N');

INSERT INTO pertenece_a values(1,1,TO_DATE('22-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(1,2,TO_DATE('12-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(1,3,TO_DATE('05-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(2,1,TO_DATE('14-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(2,2,TO_DATE('11-May-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(2,3,TO_DATE('24-Dic-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(3,1,TO_DATE('31-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(3,2,TO_DATE('02-Ago-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(3,3,TO_DATE('29-Sep-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(4,5,TO_DATE('23-Oct-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(4,2,TO_DATE('18-Feb-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(4,4,TO_DATE('02-Mar-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(5,5,TO_DATE('28-May-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(6,1,TO_DATE('14-Jul-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(7,1,TO_DATE('22-Dic-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(8,5,TO_DATE('14-Feb-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(9,4,TO_DATE('20-Nov-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(10,4,TO_DATE('09-Mar-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(11,3,TO_DATE('16-Oct-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(12,4,TO_DATE('22-Sep-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(13,4,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(8,1,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(4,3,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(7,3,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(5,4,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);
INSERT INTO pertenece_a values(6,4,TO_DATE('22-Jun-2016','DD-Mon-YY'),null);

INSERT INTO cuenta values(1,'almuerzo',300000,null,TO_DATE('22-Jul-2016','DD-Mon-YY'),1,1);
INSERT INTO cuenta values(2,'spotify',800000,null,TO_DATE('03-Jul-2016','DD-Mon-YY'),1,2);
INSERT INTO cuenta values(9,'televisor',450000,null,TO_DATE('22-Jul-2016','DD-Mon-YY'),1,8);
INSERT INTO cuenta values(10,'utiles',600000,null,TO_DATE('22-Jul-2016','DD-Mon-YY'),1,3);

INSERT INTO cuenta values(3,'salida',500000,null,TO_DATE('13-May-2016','DD-Mon-YY'),2,3);
INSERT INTO cuenta values(8,'transporte',300000,null,TO_DATE('18-Jul-2016','DD-Mon-YY'),2,1);

INSERT INTO cuenta values(4,'paseo',900000,null,TO_DATE('22-Feb-2016','DD-Mon-YY'),3,4);
INSERT INTO cuenta values(7,'donacion',100000,null,TO_DATE('22-Ago-2016','DD-Mon-YY'),3,7);

INSERT INTO cuenta values(5,'reunion',100000,null,TO_DATE('22-Oct-2016','DD-Mon-YY'),4,5);
INSERT INTO cuenta values(6,'deuda',250000,null,sysdate,4,6);

INSERT INTO cuenta values(11,'evento',600000,null,sysdate,5,5);



INSERT INTO Deuda values(60000,2,1,1);
INSERT INTO Deuda values(60000,3,1,2);
INSERT INTO Deuda values(60000,6,1,3);
INSERT INTO Deuda values(60000,7,1,4);
INSERT INTO Deuda values(60000,8,1,5);

INSERT INTO Deuda values(90000,1,9,6);
INSERT INTO Deuda values(90000,3,9,7);
INSERT INTO Deuda values(90000,6,9,8);
INSERT INTO Deuda values(90000,7,9,9);
INSERT INTO Deuda values(90000,2,9,10);

INSERT INTO Deuda values(120000,1,10,11);
INSERT INTO Deuda values(120000,2,10,12);
INSERT INTO Deuda values(120000,6,10,13);
INSERT INTO Deuda values(120000,7,10,14);
INSERT INTO Deuda values(120000,8,10,15);

INSERT INTO Deuda values(160000,1,2,16);
INSERT INTO Deuda values(160000,3,2,17);
INSERT INTO Deuda values(160000,6,2,18);
INSERT INTO Deuda values(160000,7,2,19);
INSERT INTO Deuda values(160000,8,2,20);

INSERT INTO Deuda values(166667,1,3,21);
INSERT INTO Deuda values(166667,2,3,22);
INSERT INTO Deuda values(166667,4,3,23);

INSERT INTO Deuda values(100000,2,8,24);
INSERT INTO Deuda values(100000,3,8,25);
INSERT INTO Deuda values(100000,4,8,26);

INSERT INTO Deuda values(180000,1,4,27);
INSERT INTO Deuda values(180000,2,4,28);
INSERT INTO Deuda values(180000,3,4,29);
INSERT INTO Deuda values(180000,11,4,30);
INSERT INTO Deuda values(180000,7,4,31);

INSERT INTO Deuda values(20000,1,7,32);
INSERT INTO Deuda values(20000,2,7,33);
INSERT INTO Deuda values(20000,3,7,34);
INSERT INTO Deuda values(20000,4,7,35);
INSERT INTO Deuda values(20000,11,7,36);

INSERT INTO Deuda values(16667,4,5,37);
INSERT INTO Deuda values(16667,6,5,38);
INSERT INTO Deuda values(16667,9,5,39);
INSERT INTO Deuda values(16667,10,5,40);
INSERT INTO Deuda values(16667,12,5,41);
INSERT INTO Deuda values(16667,13,5,42);

INSERT INTO Deuda values(41667,4,6,43);
INSERT INTO Deuda values(41667,5,6,44);
INSERT INTO Deuda values(41667,9,6,45);
INSERT INTO Deuda values(41667,10,6,46);
INSERT INTO Deuda values(41667,12,6,47);
INSERT INTO Deuda values(41667,13,6,48);

INSERT INTO Deuda values(300000,4,11,49);
INSERT INTO Deuda values(300000,8,11,50);

INSERT INTO transaccion values(1,TO_DATE('23-Jul-2015','DD-Mon-YY'),20000,1,2,1,'P');
INSERT INTO transaccion values(2,TO_DATE('24-Jul-2015','DD-Mon-YY'),2000,1,2,1,'P');
INSERT INTO transaccion values(3,TO_DATE('25-Jul-2015','DD-Mon-YY'),10000,1,2,1,'P');
INSERT INTO transaccion values(4,TO_DATE('12-Sep-2015','DD-Mon-YY'),5000,1,3,2,'C');
INSERT INTO transaccion values(5,TO_DATE('12-Sep-2015','DD-Mon-YY'),1000,1,3,2,'O');
INSERT INTO transaccion values(6,TO_DATE('12-Sep-2015','DD-Mon-YY'),3000,1,3,2,'P');
INSERT INTO transaccion values(7,TO_DATE('07-Jul-2015','DD-Mon-YY'),10000,9,1,6,'P');
INSERT INTO transaccion values(8,TO_DATE('07-Jul-2015','DD-Mon-YY'),30000,9,1,6,'P');
INSERT INTO transaccion values(9,TO_DATE('08-Oct-2015','DD-Mon-YY'),22000,9,3,7,'C');
INSERT INTO transaccion values(10,TO_DATE('08-Oct-2015','DD-Mon-YY'),12000,9,3,7,'C');
INSERT INTO transaccion values(11,TO_DATE('08-Oct-2015','DD-Mon-YY'),4000,9,3,7,'C');
INSERT INTO transaccion values(12,TO_DATE('24-May-2015','DD-Mon-YY'),35000,10,1,11,'P');
INSERT INTO transaccion values(13,TO_DATE('24-May-2015','DD-Mon-YY'),12000,10,1,11,'C');
INSERT INTO transaccion values(14,TO_DATE('22-Feb-2015','DD-Mon-YY'),15000,10,2,12,'P');
INSERT INTO transaccion values(15,TO_DATE('22-Feb-2015','DD-Mon-YY'),15000,10,2,12,'C');
INSERT INTO transaccion values(16,TO_DATE('28-Mar-2015','DD-Mon-YY'),50000,2,7,19,'C');
INSERT INTO transaccion values(17,TO_DATE('28-Mar-2015','DD-Mon-YY'),10000,2,7,19,'P');
INSERT INTO transaccion values(18,TO_DATE('28-Mar-2015','DD-Mon-YY'),5000,2,7,19,'P');
INSERT INTO transaccion values(19,TO_DATE('10-Ago-2015','DD-Mon-YY'),50000,2,8,20,'C');
INSERT INTO transaccion values(20,TO_DATE('10-Ago-2015','DD-Mon-YY'),10000,2,8,20,'C');
INSERT INTO transaccion values(21,TO_DATE('20-Jul-2015','DD-Mon-YY'),35000,3,2,22,'C');
INSERT INTO transaccion values(22,TO_DATE('24-Ago-2015','DD-Mon-YY'),42000,3,4,23,'C');
INSERT INTO transaccion values(23,TO_DATE('01-Oct-2015','DD-Mon-YY'),50000,8,3,25,'C');
INSERT INTO transaccion values(24,TO_DATE('01-Oct-2015','DD-Mon-YY'),5000,8,3,25,'C');
INSERT INTO transaccion values(25,TO_DATE('02-Jul-2015','DD-Mon-YY'),30000,8,4,26,'P');
INSERT INTO transaccion values(26,TO_DATE('03-Oct-2015','DD-Mon-YY'),20000,4,3,29,'C');
INSERT INTO transaccion values(27,TO_DATE('03-Oct-2015','DD-Mon-YY'),12000,4,3,29,'C');
INSERT INTO transaccion values(28,TO_DATE('04-May-2015','DD-Mon-YY'),65000,4,11,30,'C');
INSERT INTO transaccion values(29,TO_DATE('11-May-2015','DD-Mon-YY'),46000,4,7,31,'C');
INSERT INTO transaccion values(30,TO_DATE('11-May-2015','DD-Mon-YY'),8000,4,7,31,'P');
INSERT INTO transaccion values(31,TO_DATE('18-Jul-2015','DD-Mon-YY'),3000,7,3,34,'C');
INSERT INTO transaccion values(32,TO_DATE('25-Nov-2015','DD-Mon-YY'),8000,7,4,35,'C');
INSERT INTO transaccion values(33,TO_DATE('23-Jul-2015','DD-Mon-YY'),3000,5,9,39,'C');
INSERT INTO transaccion values(34,TO_DATE('23-Jul-2015','DD-Mon-YY'),1000,5,9,39,'P');
INSERT INTO transaccion values(35,TO_DATE('19-Oct-2015','DD-Mon-YY'),5000,5,10,40,'C');
INSERT INTO transaccion values(36,TO_DATE('19-May-2015','DD-Mon-YY'),9000,5,12,41,'P');
INSERT INTO transaccion values(37,TO_DATE('27-May-2015','DD-Mon-YY'),13000,6,5,44,'C');
INSERT INTO transaccion values(38,TO_DATE('27-May-2015','DD-Mon-YY'),2000,6,5,44,'C');
INSERT INTO transaccion values(39,TO_DATE('03-Jul-2015','DD-Mon-YY'),18000,6,10,46,'C');
INSERT INTO transaccion values(40,TO_DATE('09-Feb-2015','DD-Mon-YY'),22000,6,13,48,'C');
INSERT INTO transaccion values(41,TO_DATE('05-Jul-2015','DD-Mon-YY'),115000,11,4,49,'C');
INSERT INTO transaccion values(42,TO_DATE('05-Jul-2015','DD-Mon-YY'),8000,11,4,49,'C');
INSERT INTO transaccion values(43,TO_DATE('04-Jul-2015','DD-Mon-YY'),98000,11,8,50,'C');
INSERT INTO transaccion values(44,TO_DATE('04-Jul-2015','DD-Mon-YY'),5000,11,8,50,'O');

commit;
/*

  Historial de transacciones realizadas por cada grupo discriminando por usuarios que la realizaron
  
  3.7.1 Step 2 
  UsuarioId Nombre Apellido GrupoID NombreGrupo CuentaID CuentaNombre DeudaId TrasaccionID TransaccionFecha TransaccionCantidad

*/
with CuentaXTransaccion(cuentaid,cuentanombre,cuentagrupoid,deudausuario_id,deuda_deudaid,transaccionid,transaccionfecha,transaccioncantidad) as 
(select Cuenta.id,Cuenta.nombre,Cuenta.Grupo_Id,Deuda.Usuario_Id,Deuda.Id_Deuda,Transaccion.ID,Transaccion.fecha,Transaccion.cantidad
from Cuenta,Deuda,Transaccion 
where Cuenta.id=Deuda.Cuenta_Id and Transaccion.Deuda_Cuenta_Id=Deuda.Cuenta_Id and Transaccion.Deuda_Usuario_Id = Deuda.Usuario_Id and Transaccion.Id_Deuda = Deuda.Id_Deuda
),
UsuarioXGrupo (usunombre ,usuapellido,usuid,grunombre,gruid) as 
(select Usuario.nombre,Usuario.apellidos,Usuario.id,Grupo.nombre, Grupo.ID
from Grupo,Usuario,Pertenece_a
where Usuario.id = Pertenece_a.Usuario_id and Grupo.id = Pertenece_a.Grupo_Id and Grupo.DISUELTO='N' )

select  usuid UsuarioID, usunombre Nombre, usuapellido Apellido, gruid Grupo_ID, grunombre GrupoNombre,cuentaid Cuenta_ID,cuentanombre Cuenta_Nombre,deuda_deudaid Deuda_ID,transaccionid Transaccion_ID,transaccionfecha Transaccion_Fecha,transaccioncantidad Transaccion_Cantidad
from UsuarioXGrupo,CuentaXTransaccion  
where CuentaXTransaccion.DEUDAUSUARIO_ID = UsuarioXGrupo.USUID and CuentaXTransaccion.CUENTAGRUPOID = UsuarioXGrupo.GRUID;


/*
  3.5.1. step 3 parte A
*/
with grupo_usuario(grupo,id_g,usuario,id_u)as
(select gg.nombre,gg.id as ID_G,uu.nombre ||' '|| uu.apellidos as nombre,uu.id as ID_U
from grupo gg, pertenece_a pp,usuario uu
where (gg.id = pp.grupo_id) and pp.usuario_id = uu.id
),

deudas(grupo,usuario,deudas)as
(select gg.id as grupo,dd.usuario_id,sum(dd.cantidad) as deudas
from grupo gg, cuenta cc, deuda dd
where gg.id = cc.grupo_id and cc.id = dd.cuenta_id
group by gg.id,dd.usuario_id),

transacciones(grupo,usuario,transacciones)as
(select gg.id as grupo,dd.usuario_id, sum(-1*tt.cantidad) as transaccion
from grupo gg, cuenta cc, deuda dd, transaccion tt
where( gg.id = cc.grupo_id and cc.id = dd.cuenta_id) and (tt.deuda_usuario_id = dd.usuario_id  and tt.deuda_cuenta_id = cc.id)
group by gg.id,dd.usuario_id),

balance(grupo,usuario,balance)as
(select *
from ((select * from transacciones) UNION (select * from deudas))),

balance_final(grupo,usuario,balancef)as
(select grupo,usuario,sum(balance) from balance group by grupo,usuario)


select gg.grupo , gg.usuario, bb.balancef
from grupo_usuario gg,balance_final bb
where gg.id_g = bb.grupo and gg.id_u = bb.usuario;

/*
  3.5.1 Step 3
  Parte B y C
*/
with 
  cuentas( id, costo, nombrec, dueno_id, grupo ) as
  ( select id, costo, nombre, Usuario_id, Grupo_id
    from cuenta ),
    
  deudas( grupo, usuario, deudas )as
  ( select gg.id as grupo, dd.usuario_id, sum( dd.cantidad ) as deudas
    from grupo gg, cuentas cc, deuda dd
    where gg.id = cc.grupo and cc.id = dd.cuenta_id
    group by gg.id, dd.usuario_id ),

  transacciones( grupo, usuario, transacciones ) as
  ( select gg.id as grupo, dd.usuario_id, -1 * sum( tt.cantidad ) as transaccion
    from grupo gg, cuentas cc, deuda dd, transaccion tt
    where ( gg.id = cc.grupo and cc.id = dd.cuenta_id ) and ( tt.deuda_usuario_id = dd.usuario_id and tt.deuda_cuenta_id = cc.id )
    group by gg.id,dd.usuario_id ),

  balance( grupo, usuario, balance ) as
  ( select *
    from ( ( select * from transacciones ) UNION ( select * from deudas ) ) ),

  balance_fin( grupo, usuario, balancef ) as
  ( select grupo, usuario, sum( balance ) 
    from balance 
    group by grupo, usuario ),
  
  balance_final( grupo, usuario, balancef ) as
  ( select grupo, usuario.nombre || ' ' || usuario.apellidos , balancef 
    from balance_fin, usuario
    where balance_fin.usuario = usuario.id)

select distinct grupo.nombre as Grupo, nombrec as Cuenta, usuario.nombre as due�o, usuario Deudor, balancef Debe
from cuentas natural join balance_final, usuario, grupo
where dueno_id = usuario.id and grupo = grupo.id
order by grupo.nombre;
/*

  1) Cuentas Por grupo (CuentasXGrupo)
  2) Transacciones por grupo (TransaccionesXGrupo)
  3.6.1
  
*/
DROP VIEW CuentasXGrupo;
CREATE VIEW CuentasXGrupo AS
SELECT Grupo.ID GrupoID, Grupo.NOMBRE GrupoNombre, Cuenta.ID CuentaID, Cuenta.NOMBRE CuentaNombre, Cuenta.COSTO Costo, Cuenta.FECHA_CREACION
FROM Grupo left outer join Cuenta
ON Grupo.ID = Cuenta.GRUPO_ID;  

DROP VIEW TransaccionesXDeuda;
CREATE VIEW TransaccionesXDeuda AS 
SELECT ID_DEUDA, Deuda.CUENTA_ID, Deuda.USUARIO_ID, Transaccion.CANTIDAD, Transaccion.FECHA, Transaccion.TIPO
FROM Deuda right outer join Transaccion
USING (ID_DEUDA); 

DROP VIEW DeudasXCuenta;
CREATE VIEW DeudasXCuenta AS
SELECT CuentasxGrupo.GRUPOID, CuentasxGrupo.GRUPONOMBRE, CuentasxGrupo.FECHA_CREACION, CuentasxGrupo.CUENTAID, CuentasxGrupo.CUENTANOMBRE, Deuda.USUARIO_ID, Deuda.CANTIDAD, Deuda.ID_DEUDA
FROM CuentasxGrupo right outer join Deuda
ON CUENTASXGRUPO.CuentaID = DEUDA.Cuenta_id;


DROP VIEW TransaccionesXGrupo;
CREATE VIEW TransaccionesXGrupo AS 
with TransaccionesXGrupoI as
(SELECT DeudasXCuenta.GRUPOID, DeudasXCuenta.GRUPONOMBRE, DeudasXCuenta.CUENTAID, DeudasXCuenta.CUENTANOMBRE, DeudasXCuenta.FECHA_CREACION, DeudasXCuenta.USUARIO_ID Paga, TransaccionesXDeuda.CANTIDAD, TransaccionesXDeuda.FECHA, TransaccionesXDeuda.TIPO
FROM DeudasXCuenta right outer join TransaccionesXDeuda
USING (Id_deuda))
SELECT GRUPOID, GRUPONOMBRE, CUENTAID, CUENTANOMBRE, FECHA_CREACION, Paga PAGAID, Usuario.nombre, Usuario.apellidos, CANTIDAD, FECHA FECHAPAGO, TIPO
FROM TransaccionesXGrupoI, Usuario
WHERE paga = Usuario.id;

SELECT * 
FROM CuentasXGrupo;

SELECT * 
FROM TransaccionesXGrupo;

/*

  Notificacion a los deudores cuando se genera una nueva Cuenta
  3.10.1
  
*/
with 
  cuentas( id, costo, nombrec, dueno_id, grupo ) as
  ( select id, costo, nombre, Usuario_id, Grupo_id
    from cuenta
    where to_char( fecha_creacion ) = to_char( sysdate ) ),
    
  deudas( grupo, usuario, deudas )as
  ( select gg.id as grupo, dd.usuario_id, sum( dd.cantidad ) as deudas
    from grupo gg, cuentas cc, deuda dd
    where gg.id = cc.grupo and cc.id = dd.cuenta_id
    group by gg.id, dd.usuario_id ),

  transacciones( grupo, usuario, transacciones ) as
  ( select gg.id as grupo, dd.usuario_id, -1 * sum( tt.cantidad ) as transaccion
    from grupo gg, cuentas cc, deuda dd, transaccion tt
    where ( gg.id = cc.grupo and cc.id = dd.cuenta_id ) and ( tt.deuda_usuario_id = dd.usuario_id and tt.deuda_cuenta_id = cc.id )
    group by gg.id,dd.usuario_id ),

  balance( grupo, usuario, balance ) as
  ( select *
    from ( ( select * from transacciones ) UNION ( select * from deudas ) ) ),

  balance_fin( grupo, usuario, balancef ) as
  ( select grupo, usuario, sum( balance ) 
    from balance 
    group by grupo, usuario ),
  
  balance_final( grupo, usuario, balancef ) as
  ( select grupo, usuario.nombre, balancef 
    from balance_fin, usuario
    where balance_fin.usuario = usuario.id)

select distinct '$' || to_char( costo ) || ' ' || nombrec as New_Bill , usuario.nombre as Paid_by, grupo.nombre as Group_, usuario, balancef
from cuentas natural join balance_final, usuario, grupo
where dueno_id = usuario.id and grupo = grupo.id;

/*
  4.1.8
*/
select u2.nombre Quien_paga, u1.nombre Quien_recibe, tt.cantidad Monto, tt.tipo Tipo_Pago
from transaccion tt, usuario u1, usuario u2, cuenta cc
where tt.deuda_cuenta_id = cc.id and u1.id = cc.usuario_id and u2.id = tt.deuda_usuario_id;