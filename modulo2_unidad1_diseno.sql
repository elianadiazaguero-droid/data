-- CREAR TABLA CLIENTES
CREATE TABLE Clientes(
id_cliente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
perfil_bio TEXT,
fecha_registro DATE
);
SELECT * FROM Clientes;

--CREAR TABLA PRODUCTOS
CREATE TABLE Productos(
id_producto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
descripcion VARCHAR(255) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
esta_activo BIT NOT NULL
);
SELECT * FROM Productos;


-- esta_activo:
-- BIT porque solo puede tener dos valores:
-- 1= Activo
-- 0= Inactivo
