# 💈 Sistema de Gestión de Barbería - Base de Datos SQL

Este repositorio contiene el script de base de datos relacional para un **Sistema de Gestión de Barbería**. El proyecto implementa sentencias estructuradas en lenguajes **DDL** (Data Definition Language) y **DML** (Data Manipulation Language) bajo el motor **MySQL**.

El diseño agrupa de forma dinámica las agendas de clientes, asignación de barberos profesionales y un sistema de auditoría transaccional para controlar los cambios de citas en tiempo real.

---

## 🛠️ Estructura del Proyecto (Aspectos Clave)

El código se divide rigurosamente en tres fases esenciales del ciclo de vida de los datos:

1. **Creación (DDL):** Definición y construcción de las tablas relacionales (`clientes`, `barberos`, `citas` y `cambios_barbero_logs`) asegurando la integridad referencial por medio de llaves primarias (`PRIMARY KEY`) y foráneas (`FOREIGN KEY`).
2. **Inserción (DML):** Poblamiento inicial del sistema con registros simulados de clientes, barberos especialistas y la agenda base de citas para pruebas operativas.
3. **Consulta y Transacciones (DML Avanzado):** Consultas analíticas (`SELECT` con múltiples `INNER JOIN` y `LEFT JOIN`), filtros lógicos (`WHERE`, `LIKE`) y un bloque de control de transferencias encapsulado en una transacción segura (`START TRANSACTION`).

---

## 📋 Requerimientos y Consultas Resueltas

El script da solución a las siguientes necesidades analíticas del negocio:

* **Catálogo General:** Consolidación de citas activas mapeando el nombre del servicio, barbero responsable y el cliente asignado.
* **Filtros Personalizados:** Búsqueda predictiva de servicios por palabras clave (ej. servicios de *'Corte'*) y filtrado exacto por la carga laboral de un barbero específico.
* **Métricas de Control:** Cuantificación total de las citas programadas en la jornada.
* **Auditoría Transaccional:** Control estricto de novedades que reasigna un barbero a una cita y genera de manera simultánea una traza o *log* histórico detallando el motivo de la transferencia.
* **Análisis de Datos:** Identificación del barbero con mayor volumen de trabajo, el empleado que más cambios de agenda registra, y el conteo de citas estables que nunca han sufrido modificaciones.

---