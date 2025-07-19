create database Sistema_finaciero;
use Sistema_finaciero;

-- SCRIPT DE CREACIÓN DE TABLAS PARA SISTEMA BANCARIO

-- CLIENTE
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre NVARCHAR(100),
    dni CHAR(8),
    direccion NVARCHAR(200),
    telefono NVARCHAR(20)
);

-- CUENTA
CREATE TABLE Cuenta (
    id_cuenta INT PRIMARY KEY,
    id_cliente INT,
    tipo_cuenta VARCHAR(20),
    saldo DECIMAL(10,2),
    fecha_apertura DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- TRANSACCION
CREATE TABLE Transaccion (
    id_transaccion INT PRIMARY KEY,
    id_cuenta INT,
    tipo VARCHAR(20),
    monto DECIMAL(10,2),
    fecha DATETIME,
    descripcion NVARCHAR(255),
    FOREIGN KEY (id_cuenta) REFERENCES Cuenta(id_cuenta)
);

-- PRESTAMO
CREATE TABLE Prestamo (
    id_prestamo INT PRIMARY KEY,
    id_cliente INT,
    monto DECIMAL(10,2),
    tasa_interes DECIMAL(5,2),
    plazo_meses INT,
    fecha_otorgado DATETIME,
    estado VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- PAGO DE PRÉSTAMO
CREATE TABLE PagoPrestamo (
    id_pago INT PRIMARY KEY,
    id_prestamo INT,
    monto_pagado DECIMAL(10,2),
    fecha_pago DATETIME,
    FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo)
);