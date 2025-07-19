Sistema_financiero 💰

Proyecto de base de datos para una entidad financiera que permite la gestión de clientes, cuentas, transacciones, préstamos y pagos.

📌 Descripción del caso

Este sistema fue desarrollado para simular el funcionamiento básico de una entidad financiera, como un banco. Permite almacenar y gestionar información relacionada con los clientes, sus cuentas bancarias, movimientos financieros, préstamos otorgados y pagos realizados.

🛠 Fases del desarrollo

1. Análisis del caso  
   Se identificaron las necesidades del sistema a través del planteamiento de una entidad bancaria ficticia que atiende a cientos de clientes con servicios de ahorro, cuenta corriente y préstamos.

2. Modelo entidad-relación (ER) 
   Se diseñó un modelo ER que representa las relaciones entre clientes, cuentas, transacciones, préstamos y pagos.

3. Modelo relacional
   A partir del modelo ER, se normalizaron las tablas y se definieron las claves primarias y foráneas.

4. Script de creación de base de datos
   Se implementaron las sentencias CREATE TABLE para definir la estructura de la base de datos en SQL Server.

5. Generación masiva de datos
   Se utilizó Python con la librería Faker para generar datos ficticios e insertarlos de forma masiva en un archivo .sql.

 🧱 Tablas principales

- Cliente: información personal del cliente.
- Cuenta: tipo, saldo y fecha de apertura.
- Transacción: depósitos, retiros y transferencias.
- Préstamo: monto, tasa, plazo y estado.
- Pago de préstamo: pagos realizados por préstamo.

 💻 Tecnologías usadas

- SQL Server
- Python 3
- Faker (librería para generación de datos)
- Git y GitHub

📂 Archivos incluidos

- modelo_ER.png: imagen del diagrama entidad-relación.
- creacion_tablas.sql: script con sentencias CREATE TABLE.
- insert_masivo_banco.sql: datos de prueba generados automáticamente.
- generar_datos.py: script en Python para generar datos falsos.
- README.md: documentación del proyecto.

---

 ✅ Estado del proyecto

✔ Completado y funcional para pruebas académicas y simulaciones.
