CREATE TABLE usuarios (
  id            int(11) NOT NULL AUTO_INCREMENT, 
  nombreUsuario varchar(10) NOT NULL UNIQUE, 
  contrasena    varchar(255) NOT NULL, 
  nombre        varchar(60) NOT NULL, 
  fecha         datetime NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (fecha));
CREATE TABLE sesiones (
  id      int(11) NOT NULL AUTO_INCREMENT, 
  inicio  datetime NOT NULL, 
  fin     datetime NULL, 
  usuario int(11) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE comentarios (
  id          int(11) NOT NULL AUTO_INCREMENT, 
  comentario  varchar(255) NOT NULL, 
  fecha       datetime NOT NULL, 
  publicacion int(11) NOT NULL, 
  sesion      int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (fecha));
CREATE TABLE empresas (
  id        int(11) NOT NULL AUTO_INCREMENT, 
  nombre    varchar(60) NOT NULL UNIQUE, 
  direccion varchar(60) NOT NULL, 
  fecha     datetime NOT NULL, 
  sesion    int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (direccion), 
  INDEX (fecha));
CREATE TABLE publicaciones (
  id      int(11) NOT NULL AUTO_INCREMENT, 
  texto   varchar(255) NOT NULL, 
  precio  decimal(8, 2) NOT NULL, 
  borrado tinyint(3) NOT NULL, 
  fecha   datetime NOT NULL, 
  empresa int(11) NOT NULL, 
  sesion  int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (borrado), 
  INDEX (fecha));
CREATE TABLE compras (
  id            int(11) NOT NULL AUTO_INCREMENT, 
  fechaRegistro datetime NOT NULL, 
  fechaCompra   datetime NULL, 
  empresa       int(11) NOT NULL, 
  sesion        int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (fechaRegistro), 
  INDEX (fechaCompra));
CREATE TABLE compras_detalles (
  id          int(11) NOT NULL AUTO_INCREMENT, 
  costo       decimal(8, 2) NOT NULL, 
  compra      int(11) NOT NULL, 
  publicacion int(11) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE solicitudesDeVenta (
  id                         int(11) NOT NULL AUTO_INCREMENT, 
  fechaSolicitud             datetime NOT NULL, 
  precio                     decimal(8, 2) NOT NULL, 
  empresaSolicitante         int(11) NOT NULL, 
  empresaAutorizadora        int(11) NOT NULL, 
  publicacion                int(11) NOT NULL, 
  solicitudDeVentaAutorizada int(11), 
  PRIMARY KEY (id), 
  INDEX (fechaSolicitud));
CREATE TABLE solicitudesDeVentaAutorizadas (
  id                int(11) NOT NULL AUTO_INCREMENT, 
  fechaAutorizacion datetime NOT NULL, 
  sesion            int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (fechaAutorizacion));
CREATE TABLE empresas_telefonos (
  id       int(11) NOT NULL AUTO_INCREMENT, 
  telefono varchar(20) NOT NULL, 
  fecha    datetime NOT NULL, 
  empresa  int(11) NOT NULL, 
  sesion   int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (telefono), 
  INDEX (fecha));
CREATE TABLE empresas_correos (
  id      int(11) NOT NULL AUTO_INCREMENT, 
  correo  varchar(60) NOT NULL, 
  fecha   datetime NOT NULL, 
  empresa int(11) NOT NULL, 
  sesion  int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (correo), 
  INDEX (fecha));
CREATE TABLE usuarios_telefonos (
  id       int(11) NOT NULL AUTO_INCREMENT, 
  telefono varchar(20) NOT NULL, 
  fecha    datetime NOT NULL, 
  usuario  int(11) NOT NULL, 
  sesion   int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (telefono), 
  INDEX (fecha));
CREATE TABLE usuarios_correos (
  id      int(11) NOT NULL AUTO_INCREMENT, 
  correo  varchar(60) NOT NULL, 
  fecha   datetime NOT NULL, 
  usuario int(11) NOT NULL, 
  sesion  int(11) NOT NULL, 
  PRIMARY KEY (id), 
  INDEX (correo), 
  INDEX (fecha));
CREATE UNIQUE INDEX empresas_telefonos 
  ON empresas_telefonos (telefono, empresa);
CREATE UNIQUE INDEX empresas_correos 
  ON empresas_correos (correo, empresa);
CREATE UNIQUE INDEX usuarios_telefonos 
  ON usuarios_telefonos (telefono, usuario);
CREATE UNIQUE INDEX usuarios_correos 
  ON usuarios_correos (correo, usuario);
ALTER TABLE sesiones ADD CONSTRAINT FKsesiones962082 FOREIGN KEY (usuario) REFERENCES usuarios (id);
ALTER TABLE comentarios ADD CONSTRAINT FKcomentario894217 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE empresas ADD CONSTRAINT FKempresas925113 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE publicaciones ADD CONSTRAINT FKpublicacio388307 FOREIGN KEY (empresa) REFERENCES empresas (id);
ALTER TABLE publicaciones ADD CONSTRAINT FKpublicacio981206 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE compras ADD CONSTRAINT FKcompras310832 FOREIGN KEY (empresa) REFERENCES empresas (id);
ALTER TABLE compras ADD CONSTRAINT FKcompras717932 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE compras_detalles ADD CONSTRAINT FKcompras_de289722 FOREIGN KEY (compra) REFERENCES compras (id);
ALTER TABLE compras_detalles ADD CONSTRAINT FKcompras_de325846 FOREIGN KEY (publicacion) REFERENCES publicaciones (id);
ALTER TABLE solicitudesDeVenta ADD CONSTRAINT FKsolicitude262912 FOREIGN KEY (empresaSolicitante) REFERENCES empresas (id);
ALTER TABLE solicitudesDeVenta ADD CONSTRAINT FKsolicitude267555 FOREIGN KEY (publicacion) REFERENCES publicaciones (id);
ALTER TABLE comentarios ADD CONSTRAINT FKcomentario247374 FOREIGN KEY (publicacion) REFERENCES publicaciones (id);
ALTER TABLE solicitudesDeVenta ADD CONSTRAINT FKsolicitude515686 FOREIGN KEY (empresaAutorizadora) REFERENCES empresas (id);
ALTER TABLE solicitudesDeVentaAutorizadas ADD CONSTRAINT FKsolicitude419832 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE solicitudesDeVenta ADD CONSTRAINT FKsolicitude742856 FOREIGN KEY (solicitudDeVentaAutorizada) REFERENCES solicitudesDeVentaAutorizadas (id);
ALTER TABLE empresas_telefonos ADD CONSTRAINT FKempresas_t534403 FOREIGN KEY (empresa) REFERENCES empresas (id);
ALTER TABLE empresas_telefonos ADD CONSTRAINT FKempresas_t30087 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE empresas_correos ADD CONSTRAINT FKempresas_c753036 FOREIGN KEY (empresa) REFERENCES empresas (id);
ALTER TABLE empresas_correos ADD CONSTRAINT FKempresas_c160137 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE usuarios_telefonos ADD CONSTRAINT FKusuarios_t26986 FOREIGN KEY (usuario) REFERENCES usuarios (id);
ALTER TABLE usuarios_telefonos ADD CONSTRAINT FKusuarios_t748706 FOREIGN KEY (sesion) REFERENCES sesiones (id);
ALTER TABLE usuarios_correos ADD CONSTRAINT FKusuarios_c733980 FOREIGN KEY (usuario) REFERENCES usuarios (id);
ALTER TABLE usuarios_correos ADD CONSTRAINT FKusuarios_c455701 FOREIGN KEY (sesion) REFERENCES sesiones (id);

create view vw_compras_ventas as

    select emp.*, comp.id as compvta, 0 as tipo, sum(cdet.costo) as total
    from empresas emp
    join compras comp on comp.empresa = emp.id
    join compras_detalles cdet on cdet.compra = comp.id
    group by emp.id, comp.id
    union
    select emp.*, sol.id as compvta, 1 as tipo, sum(sol.precio) as total
    from empresas emp
    join solicitudesdeventa sol on sol.empresaAutorizadora = emp.id
    join solicitudesdeventaautorizadas sola on sol.solicitudDeVentaAutorizada = sola.id
    group by emp.id, sol.id;
