--------------------------------------------------------
-- SCRIPT DE CREACIÓN DE TABLAS PARA SISTEMA BANCARIO--
--------------------------------------------------------
--1. Crear la base de datos
--2. Usar la base de datos
--3. Usar el script para crear las tablas

create database Sistema_finaciero;
use Sistema_finaciero;

-- SCRIPT DE CREACIÓN DE TABLAS PARA SISTEMA BANCARIO

-- CLIENTE
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    dni CHAR(8) NOT NULL UNIQUE,
    direccion NVARCHAR(200),
    telefono CHAR(9) CHECK (LEN(telefono) = 9)
);

-- CUENTA
CREATE TABLE Cuenta (
    id_cuenta INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_cuenta VARCHAR(20) NOT NULL CHECK (tipo_cuenta IN ('ahorro', 'corriente', 'plazo fijo')),
    saldo DECIMAL(10,2) NOT NULL CHECK (saldo >= 0),
    fecha_apertura DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- TRANSACCION
CREATE TABLE Transaccion (
    id_transaccion INT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('deposito', 'retiro', 'transferencia', 'pago')),
    monto DECIMAL(10,2) NOT NULL CHECK (monto >= 0),
    fecha DATETIME NOT NULL,
    descripcion NVARCHAR(255),
    FOREIGN KEY (id_cuenta) REFERENCES Cuenta(id_cuenta)
);

-- PRESTAMO
CREATE TABLE Prestamo (
    id_prestamo INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
    tasa_interes DECIMAL(5,2) NOT NULL CHECK (tasa_interes > 0),
    plazo_meses INT NOT NULL CHECK (plazo_meses > 0),
    fecha_otorgado DATETIME NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('vigente', 'cancelado', 'vencido')),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- PAGO DE PRÉSTAMO
CREATE TABLE PagoPrestamo (
    id_pago INT PRIMARY KEY,
    id_prestamo INT NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL CHECK (monto_pagado > 0),
    fecha_pago DATETIME NOT NULL,
    FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo)
);
