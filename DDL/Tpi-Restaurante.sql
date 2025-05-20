--create database RESTAURANTE

use RESTAURANTE
go

create table provincias(
id_provincia int,
Nombre varchar(30),
CONSTRAINT pk_provincia PRIMARY KEY (id_provincia)
)
create table barrios(
id_barrio int,
Nombre varchar(50) NOT NULL,
id_provincia int NOT NULL,
CONSTRAINT pk_barrios PRIMARY KEY (id_barrio),
CONSTRAINT fk_provincia FOREIGN KEY (id_provincia) references provincias (id_provincia)
)

create table tipos_contactos(
id_tipo_contacto int,
tipo_conctacto varchar(10) NOT NULL,
CONSTRAINT pk_tipo_contacto PRIMARY KEY (id_tipo_contacto),
)

create table  roles(
id_rol int,
tipo_conctacto varchar(20) NOT NULL,
CONSTRAINT pk_roles PRIMARY KEY (id_rol),
)
create table tipos_docs(
id_tipo_doc int,
tipo_doc varchar(20) NOT NULL,
CONSTRAINT pk_tipo_doc PRIMARY KEY (id_tipo_doc),
)
create table Personal(
legajo int,
direccion varchar (50) NOT NULL,
num_docu int NOT NULL,
nombre varchar (20) NOT NULL,
apellido varchar (30) NOT NULL,
fecha_ingreso date NOT NULL,
id_barrio int NOT NULL,
id_rol int NOT NULL,
id_tipo_doc int NOT NULL,
CONSTRAINT pk_personal PRIMARY KEY (legajo),
CONSTRAINT fk_barrios FOREIGN KEY (id_barrio) REFERENCES barrios (id_barrio),
CONSTRAINT fk_rol  FOREIGN KEY (id_rol) REFERENCES roles (id_rol),
CONSTRAINT fk_tipo_doc FOREIGN KEY (id_tipo_doc) REFERENCES tipos_docs (id_tipo_doc)
)

create table tipos_recargos (
id_recargo int,
descripcion varchar (50) NOT NULL,
CONSTRAINT pk_tipos_recargos PRIMARY KEY(id_recargo),
)

create table formas_pagos(
id_forma_pago int,
forma_pago varchar(30) NOT NULL,
recargo bit NOT NULL,
id_recargo int NOT NULL
CONSTRAINT pk_forma_pago PRIMARY KEY (id_forma_pago),
CONSTRAINT fk_tipos_recargos_formas_pagos FOREIGN KEY (id_recargo) REFERENCES tipos_recargos (id_recargo)
)

create table proveedores(
id_proveedor int,
Nombre varchar (40) NOT NULL,
razon_social varchar(50) NOT NULL,
fecha_alta date NOT NULL,
direccion varchar(30) NOT NULL,
id_barrio int NOT NULL,
CONSTRAINT pk_proveedor PRIMARY KEY (id_proveedor),
CONSTRAINT fk_barrio FOREIGN KEY (id_barrio) REFERENCES barrios (id_barrio)
)
create table penalizaciones(
id_penalizacion int,
descripcion varchar (40) NOT NULL,
CONSTRAINT pk_penalizacion PRIMARY KEY (id_penalizacion)
)

create table puntos (
id_punto int,
cantidad int NOT NULL,
fecha_suma date NOT NULL,
fecha_canje date NULL
CONSTRAINT pk_puntos PRIMARY KEY(id_punto)
)


create table promociones (
id_promocion int,
descripcion varchar(40),
fecha_vigencia date NOT NULL,
CONSTRAINT pk_promociones PRIMARY KEY(id_promocion)
)

create table puntos_promociones (
id_punto int NOT NULL,
id_promocion int NOT NULL
CONSTRAINT pk_puntos_promociones PRIMARY KEY (id_punto, id_promocion),
CONSTRAINT fk_puntos_promociones_puntos FOREIGN KEY (id_punto) REFERENCES puntos(id_punto),
CONSTRAINT fk_puntos_promociones_promociones FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion)
)

create table clientes (
id_cliente int,
id_punto int NOT NULL,
cantidad_reservas int NOT NULL,
reservas_canceladas int NOT NULL,
nombre varchar (20) NOT NULL,
apellido varchar (30) NOT NULL,
num_doc int NOT NULL,
penalizacion bit NOT NULL,
fecha_registro date NOT NULL,
tipo_doc int NOT NULL,
tipo_penalizacion int NOT NULL,
contraseña varchar(16) NOT NULL,
nombre_usuario varchar (20) NOT NULL,
CONSTRAINT pk_cliente PRIMARY KEY(id_cliente),
CONSTRAINT fk_tipo_doc_clientes FOREIGN KEY (tipo_doc) REFERENCES tipos_docs (id_tipo_doc),
CONSTRAINT fk_penalizacion FOREIGN KEY (tipo_penalizacion) REFERENCES penalizaciones (id_penalizacion),
CONSTRAINT fk_clientes_puntos FOREIGN KEY (id_punto) REFERENCES puntos(id_punto)
)

create table mesas(
nro_mesa int,
capacidad int NOT NULL,
ubicacion varchar (15),
CONSTRAINT pk_mesas PRIMARY KEY (nro_mesa)
)



create table tipos_menu (
id_tipo_menu int,
nombre varchar (15) NOT NULL,
descripcion varchar (40) NOT NULL,
CONSTRAINT pk_tipo_menu PRIMARY KEY (id_tipo_menu)
)
create table unidad_medidas(
id_medida int,
nombre varchar (30),
CONSTRAINT pk_unidad_medidas PRIMARY KEY (id_medida)
)
create table menus(
id_menu int,
nombre varchar (30) NOT NULL,
descripcion varchar (50) NOT NULL,
precio decimal NOT NULL,
cantidad int Not NULL,
id_tipo_menu int NOT NULL,
id_medida int NOT NULL,
CONSTRAINT pk_menu PRIMARY KEY (id_menu),
CONSTRAINT fk_tipo_menu FOREIGN KEY (id_tipo_menu) REFERENCES tipos_menu(id_tipo_menu),
CONSTRAINT fk_menu_medida FOREIGN KEY (id_medida) REFERENCES unidad_medidas(id_medida)
)
create table estados_remitos(
id_estado_remito int,
estado varchar(10) NOT NULL,
descripcion varchar (30) NOT NULL,
CONSTRAINT pk_estado_remito PRIMARY KEY (id_estado_remito)
)

create table pedidos (
nro_pedido int,
fecha_pedido date NOT NULL,
fecha_recepcion date NOT NULL,
fecha_pago date NOT NULL,
forma_pago int NOT NULL,
proveedor int NOT NULL,
CONSTRAINT pk_pedidos PRIMARY KEY (nro_pedido),
CONSTRAINT fk_forma_pago FOREIGN KEY (forma_pago) REFERENCES formas_pagos (id_forma_pago),
CONSTRAINT fk_proveedor FOREIGN KEY (proveedor) REFERENCES proveedores (id_proveedor)
)
create table insumos (
id_insumo int,
descripcion varchar (30) NOT NULL,
nombre varchar (20) NOT NULL,
precio decimal NOT NULL,
proveedor int NOT NULL,
CONSTRAINT pk_insumos PRIMARY KEY (id_insumo),
CONSTRAINT fk_proveedor_insumos FOREIGN KEY (proveedor) REFERENCES proveedores (id_proveedor)
)
create table detalles_pedidos(
nro_detalle_pedido int,
cantidad int NOT NULL,
precio decimal NOT NULL,
insumo int NOT NULL,
nro_pedido int NOT NULL,
CONSTRAINT pk_detalle_pedido PRIMARY KEY (nro_detalle_pedido),
CONSTRAINT fk_insumos FOREIGN KEY (insumo) REFERENCES insumos (id_insumo),
CONSTRAINT fk_pedido FOREIGN KEY (nro_pedido) REFERENCES pedidos (nro_pedido),
 )
create table remitos (
nro_remito int,
fecha_entrega DATE NOT NULL,
estado_remito int NOT NULL,
pedido int NOT NULL,
CONSTRAINT pk_remito PRIMARY KEY(nro_remito),
CONSTRAINT fk_estado_remito FOREIGN KEY (estado_remito) REFERENCES estados_remitos (id_estado_remito),
CONSTRAINT fk_pedido_remito FOREIGN KEY (pedido) REFERENCES pedidos (nro_pedido)
)
create table detalles_remitos (
nro_detalle_remito int,
cantidad int NOT NULL,
precio decimal NOT NULL,
descuento int NOT NULL,
insumo int NOT NULL,
remito int NOT NULL,
CONSTRAINT pk_detalle_remito PRIMARY KEY (nro_detalle_remito),
CONSTRAINT fk_insumos_detalle_remito FOREIGN KEY (insumo) REFERENCES insumos (id_insumo),
CONSTRAINT fk_remito FOREIGN KEY (remito) REFERENCES remitos (nro_remito)
)

create table stock (
id_stock int,
cantidad int NOT NULL,
id_medida int NOT NULL,
CONSTRAINT pk_stock PRIMARY KEY (id_stock),
CONSTRAINT fk_stock_medida FOREIGN KEY (id_medida) REFERENCES unidad_medidas(id_medida)
)

create table materias_primas (
id_materia_prima int,
nombre varchar (20) NOT NULL,
nro_detalle_remito int NOT NULL,
id_stock int NOT NULL,
CONSTRAINT pk_materia_prima PRIMARY KEY (id_materia_prima),
CONSTRAINT fk_detalle_remito FOREIGN KEY (nro_detalle_remito) REFERENCES detalles_remitos (nro_detalle_remito), 
CONSTRAINT fk_materias_primas_stock FOREIGN KEY (id_stock) REFERENCES stock (id_stock)
)

create table productos(
id_producto int,
nombre varchar (20) NOT NULL,
descripcion varchar (50) NOT NULL,
precio decimal NOT NULL,
cantidad int NOT NULL,
id_materia_prima int NOT NULL,
id_medida int NOT NULL,
CONSTRAINT pk_producto PRIMARY KEY (id_producto),
CONSTRAINT fk_medida_producto FOREIGN KEY (id_medida) REFERENCES unidad_medidas(id_medida)
)

create table materias_primas_productos (
id_materia_prima int,
id_producto int
CONSTRAINT pk_materias_primas_productos PRIMARY KEY (id_materia_prima, id_producto),
CONSTRAINT fk_materias_primas_productos FOREIGN KEY (id_materia_prima) REFERENCES materias_primas (id_materia_prima),
CONSTRAINT fk_productos_materias_primas FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
)

create table menus_productos (
id_menu int,
id_producto int,
CONSTRAINT pk_menu_pruducto PRIMARY KEY(id_menu, id_producto),
CONSTRAINT fk_menu FOREIGN KEY (id_menu) REFERENCES menus (id_menu),
CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
)
create table comandas (
id_comanda int,
descripcion varchar (30) NOT NULL,
id_cliente int NOT NULL,
CONSTRAINT pk_comanda PRIMARY KEY (id_comanda),
CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
)

create table comandas_menus (
id_comanda int,
id_menu int, 
CONSTRAINT pk_comanda_menu PRIMARY KEY(id_comanda, id_menu),
CONSTRAINT fk_comanda_menu_comandas FOREIGN KEY (id_comanda) REFERENCES comandas(id_comanda),
CONSTRAINT fk_comanda_menu_menus  FOREIGN KEY (id_menu) REFERENCES menus (id_menu)
)


create table detalles_facturas (
id_detalle_factura int,
precio decimal NOT NULL,
cantidad int NOT NULL,
id_comanda int NOT NULL,
id_promocion int NOT NULL,
CONSTRAINT pk_detalle_factura PRIMARY KEY(id_detalle_factura),
CONSTRAINT fk_comandas FOREIGN KEY (id_comanda) REFERENCES comandas (id_comanda),
CONSTRAINT fk_promociones FOREIGN KEY (id_promocion) REFERENCES promociones (id_promocion),
)

create table facturas (
nro_factura int, 
fecha_facutra date NOT NULL,
id_detalle_factura int NOT NULL,
id_personal int NOT NULL,
id_forma_pago int NOT NULL,
nro_mesa int NOT NULL,
id_cliente int NOT NULL,
CONSTRAINT pk_factura PRIMARY KEY (nro_factura),
CONSTRAINT fk_detalle_factura FOREIGN KEY (id_detalle_factura) REFERENCES detalles_facturas (id_detalle_factura),
CONSTRAINT fk_forma_pago_factura FOREIGN KEY (id_forma_pago) REFERENCES formas_pagos (id_forma_pago),
CONSTRAINT fk_mesas FOREIGN KEY (nro_mesa) REFERENCES mesas (nro_mesa),
CONSTRAINT fk_cliente_factura FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
)

create table mozos_facturas (
legajo int,
nro_factura int,
CONSTRAINT pk_mozos_facturas PRIMARY KEY (legajo, nro_factura),
CONSTRAINT fk_mozos_facturas_mozos FOREIGN KEY (legajo) REFERENCES personal (legajo),
CONSTRAINT fk_mozos_facturas_facturas FOREIGN KEY (nro_factura) REFERENCES facturas (nro_factura)
)

create table estado_reservas (
id_estado_reserva int,
nombre varchar(15) NOT NULL,
descripcion varchar(30) NOT NULL,
CONSTRAINT pk_estado_reserva PRIMARY KEY (id_estado_reserva)
)
create table tipo_comida_especial(
id_tipo_comida_especial int,
nombre varchar (20) NOT NULL,
CONSTRAINT pk_comida_especial PRIMARY KEY (id_tipo_comida_especial)
)
create table necesidades_especiales(
id_necesidad_especial int,
descripcion varchar (50) NOT NULL,
comida_especial int NOT NULL,
CONSTRAINT pk_necesidad_especial PRIMARY KEY (id_necesidad_especial),
CONSTRAINT fk_comida_especial FOREIGN KEY (comida_especial) REFERENCES tipo_comida_especial(id_tipo_comida_especial)
)
create table reservas (
id_reserva int,
cant_personas int NOT NULL,
fecha date NOT NULL,
hora TIME NOT NULL,
estado int NOT NULL,
necesidad_especial  int NOT NULL,
cliente int NOT NULL,
CONSTRAINT pk_reserva PRIMARY KEY (id_reserva),
CONSTRAINT fk_estado FOREIGN KEY (estado) REFERENCES estado_reservas (id_estado_reserva),
CONSTRAINT fk_necesidad_especial FOREIGN KEY (necesidad_especial) REFERENCES necesidades_especiales (id_necesidad_especial),
CONSTRAINT fk_cliente_reserva FOREIGN KEY (cliente) REFERENCES clientes (id_cliente)
)
create table mesas_reservas (
id_reserva int,
nro_mesa int,
CONSTRAINT pk_mesas_reservas PRIMARY KEY (id_reserva, nro_mesa),
CONSTRAINT fk_reserva_mesa FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva),
CONSTRAINT fk_mesa_reserva FOREIGN KEY (nro_mesa) REFERENCES mesas (nro_mesa)
)


create table contactos(
id_contacto int,
contacto varchar(50) NOT NULL,
id_tipo_contacto int NOT NULL,
id_cliente int NOT NULL,
id_personal int NOT NULL,
id_proveedor int NOT NULL,
CONSTRAINT pk_contacto PRIMARY KEY (id_contacto),
CONSTRAINT fk_tipo_contacto FOREIGN KEY (id_tipo_contacto) references tipos_contactos (id_tipo_contacto),
CONSTRAINT fk_clientes FOREIGN KEY (id_cliente) references clientes (id_cliente),
CONSTRAINT fk_personal FOREIGN KEY (id_personal) references personal (legajo),
CONSTRAINT fk_proveedor_contacto FOREIGN KEY (id_proveedor) references proveedores (id_proveedor),
)