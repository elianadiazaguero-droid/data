-- =====================================================
-- PROYECTO RETAILPRO
-- Módulo 5 - Pre-entrega: Consultas con JOINs
-- Título: Cruzando tablas para enriquecer el análisis
-- Alumna: Eliana Diaz
-- =====================================================

USE ventas_tech_DB;


-- CONSULTA 1
-- Vista base del proyecto

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;


-- CONSULTA 2
-- Clientes registrados que no realizaron ninguna compra

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- CONSULTA 3
-- Productos del catálogo que no registran ventas

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;


-- CONSULTA 4
-- Consolidado por canal utilizando UNION ALL
-- En este caso se utiliza el período como criterio de separación.

SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total_venta,
        'Hasta el 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total_venta,
        'Desde el 11 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'

) AS ventas_consolidadas
GROUP BY canal;
