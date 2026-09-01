-- =====================================================
-- PROYECTO RETAILPRO
-- Módulo 4 - Pre-entrega: Consultas SQL de negocio
-- Alumna: Eliana Diaz
-- =====================================================

USE ventas_tech_DB;

--CONSULTA 1
--Resumen ejecutivo mensual:
--total facturado, cantidad de pedidos y ticket promedio por mes.

SELECT 
MONTH(fecha_venta) as mes,
SUM(cantidad*precio_unitario) as total_facturado,
COUNT(*) as cantidad_pedidos,
AVG(cantidad*precio_unitario) as ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

--CONSULTA 2
--Ranking de productos

SELECT TOP 5
id_producto,
SUM(cantidad) as unidades_vendidas,
SUM(cantidad*precio_unitario) as total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


--CONSULTA 3
--Clientes que hayan realizado mas de un pedido
SELECT
id_cliente,
COUNT (*) as cantidad_pedidos,
SUM(cantidad*precio_unitario) as total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*)>1;


--CONSULTA 4

SELECT
MONTH(fecha_venta) as mes,
SUM (cantidad*precio_unitario) as total_facturado,
CASE
WHEN SUM(cantidad*precio_unitario)> AVG (cantidad*precio_unitario)
THEN 'Por encima'
ELSE 'Por debajo'
END AS comparacion
FROM ventas
GROUP BY MONTH(fecha_venta);

-- la base contiene ventas unicamente del mes de marzo, por lo que no es posible observar diferencias entre meses respecto del promedio mensual.



-- HALLAZGOS

-- 1. En el mes 3 se registraron 10 pedidos, con una facturación total de $6.444 y un ticket promedio de $644,40.

-- 2. El producto 1 lidera el ranking de facturación con $3.600, pese a registrar solo 3 unidades vendidas.

-- 3. Todos los clientes realizaron 2 pedidos, siendo el cliente 1 el de mayor gasto total con $2.640.
