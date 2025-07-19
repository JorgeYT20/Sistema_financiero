#------Codigo para generar datos masivos para sql------
from faker import Faker
from random import randint, choice

# Configuraciones
NUM_CLIENTES = 500
CUENTAS_POR_CLIENTE = (1, 3)
TRANSACCIONES_POR_CUENTA = (5, 20)
PORCENTAJE_CON_PRESTAMO = 0.2
PAGOS_POR_PRESTAMO = (3, 12)

fake = Faker()

with open("insert_masivo_banco.sql", "w", encoding="utf-8") as f:

    # CLIENTES
    f.write("-- CLIENTES\n")
    for i in range(1, NUM_CLIENTES + 1):
        nombre = fake.name().replace("'", "''")
        dni = str(randint(10000000, 99999999))
        direccion = fake.address().replace("\n", ", ").replace("'", "''")
        telefono = fake.phone_number().replace("'", "")
        f.write(f"INSERT INTO Cliente (id_cliente, nombre, dni, direccion, telefono) VALUES ({i}, '{nombre}', '{dni}', '{direccion}', '{telefono}');\n")

    # CUENTAS
    cuenta_id = 1
    f.write("\n-- CUENTAS\n")
    for cliente_id in range(1, NUM_CLIENTES + 1):
        num_cuentas = randint(*CUENTAS_POR_CLIENTE)
        for _ in range(num_cuentas):
            tipo = choice(['Ahorros', 'Corriente'])
            saldo = round(randint(100, 10000) + randint(0, 99)/100, 2)
            fecha = fake.date_time_between(start_date='-2y', end_date='now').strftime('%Y-%m-%d %H:%M:%S')
            f.write(f"INSERT INTO Cuenta (id_cuenta, id_cliente, tipo_cuenta, saldo, fecha_apertura) VALUES ({cuenta_id}, {cliente_id}, '{tipo}', {saldo}, '{fecha}');\n")
            cuenta_id += 1

    # TRANSACCIONES
    transaccion_id = 1
    f.write("\n-- TRANSACCIONES\n")
    for c_id in range(1, cuenta_id):
        num_trans = randint(*TRANSACCIONES_POR_CUENTA)
        for _ in range(num_trans):
            tipo = choice(['Depósito', 'Retiro', 'Transferencia'])
            monto = round(randint(10, 1000) + randint(0, 99)/100, 2)
            descripcion = fake.sentence().replace("'", "''")
            fecha = fake.date_time_between(start_date='-2y', end_date='now').strftime('%Y-%m-%d %H:%M:%S')
            f.write(f"INSERT INTO Transaccion (id_transaccion, id_cuenta, tipo, monto, fecha, descripcion) VALUES ({transaccion_id}, {c_id}, '{tipo}', {monto}, '{fecha}', '{descripcion}');\n")
            transaccion_id += 1

    # PRESTAMOS Y PAGOS
    f.write("\n-- PRESTAMOS Y PAGOS\n")
    prestamo_id = 1
    clientes_con_prestamo = [i for i in range(1, NUM_CLIENTES + 1) if randint(1, 100) <= PORCENTAJE_CON_PRESTAMO * 100]
    for cliente_id in clientes_con_prestamo:
        monto = round(randint(500, 5000) + randint(0, 99)/100, 2)
        interes = round(randint(5, 20) + randint(0, 99)/100, 2)
        plazo = choice([6, 12, 18, 24])
        estado = choice(['Pendiente', 'Pagado', 'En Mora'])
        fecha_otorgado = fake.date_time_between(start_date='-2y', end_date='now')
        fecha_otorgado_str = fecha_otorgado.strftime('%Y-%m-%d %H:%M:%S')
        f.write(f"INSERT INTO Prestamo (id_prestamo, id_cliente, monto, tasa_interes, plazo_meses, fecha_otorgado, estado) VALUES ({prestamo_id}, {cliente_id}, {monto}, {interes}, {plazo}, '{fecha_otorgado_str}', '{estado}');\n")

        pagos = randint(*PAGOS_POR_PRESTAMO)
        for i in range(pagos):
            fecha_pago = fake.date_time_between(start_date=fecha_otorgado, end_date='now').strftime('%Y-%m-%d %H:%M:%S')
            monto_pago = round(monto / plazo + randint(0, 50), 2)
            f.write(f"INSERT INTO PagoPrestamo (id_pago, id_prestamo, monto_pagado, fecha_pago) VALUES ({prestamo_id*100 + i}, {prestamo_id}, {monto_pago}, '{fecha_pago}');\n")

        prestamo_id += 1

print("✅ Archivo insert_masivo_banco.sql con fechas y horas generado correctamente.")
