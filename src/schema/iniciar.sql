USE ropa;
CREATE TABLE [dbo].[tbUsuarios](
	[usuaCodigo] [int] NOT NULL,
	[usuaDescripcion] [varchar](50) NULL,
	[usuaLogin] [varchar](50) NULL,
	[usuaPassword] [varchar](50) NULL,
	[estaCodigo] [int] NULL,
 CONSTRAINT [PK_tbUsuarios] PRIMARY KEY CLUSTERED 
(
	[usuaCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- estados
CREATE TABLE [dbo].[tbEstados](
	[estaCodigo] [int] NOT NULL,
	[estaDescripcion] [varchar](50) NULL,
 CONSTRAINT [PK_tbEstados] PRIMARY KEY CLUSTERED 
(
	[estaCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--foraneas
ALTER TABLE [dbo].[tbUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_tbUsuarios_tbEstados] FOREIGN KEY([estaCodigo])
REFERENCES [dbo].[tbEstados] ([estaCodigo])
GO
ALTER TABLE [dbo].[tbUsuarios] CHECK CONSTRAINT [FK_tbUsuarios_tbEstados]
GO

--insert estados
INSERT [dbo].[tbEstados] ([estaCodigo], [estaDescripcion]) VALUES (1, N'Activo');
INSERT [dbo].[tbEstados] ([estaCodigo], [estaDescripcion]) VALUES (2, N'Inactivo');
-- insert user admin
INSERT [dbo].[tbUsuarios] ([usuaCodigo], [usuaDescripcion], [usuaLogin], [usuaPassword], [estaCodigo]) VALUES (1, N'Admin', N'admin1@gmail.com', N'12345', 1)

-- proce para user
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarUsuario]
	@cLogin VARCHAR(50),
	@cPassword VARCHAR(50)
AS

SELECT 
[usuaCodigo],
[usuaDescripcion],
[usuaLogin],
[usuaPassword],
[estaCodigo]
FROM [dbo].[tbUsuarios]
WHERE
[usuaLogin] = @cLogin AND
[usuaPassword] = @cPassword AND
[estaCodigo] = 1;
GO

-- proce crear user
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertarUsuario]
	@cLogin VARCHAR(50),
	@cPassword VARCHAR(50)
AS

IF NOT EXISTS(SELECT 1 FROM [dbo].[tbUsuarios] WHERE [usuaLogin] = @cLogin)
BEGIN
	DECLARE @nCodigo INT = 
	(SELECT COALESCE(MAX(usuaCodigo),0) + 1
	FROM [dbo].[tbUsuarios]);

	INSERT INTO [dbo].[tbUsuarios]
	(usuaCodigo,
	usuaLogin,
	usuaPassword,
	estaCodigo)
	VALUES
	(@nCodigo,
	@cLogin,
	@cPassword,
	1);
END
GO
--PRODUCTOS

-- Crear tabla Productos
CREATE TABLE [dbo].[Productos](
    [prodCodigo] VARCHAR(50) NOT NULL,
    [prodNombre] VARCHAR(100) NOT NULL,
    [prodImagen] VARCHAR(255),
    [prodCantidad] INT NOT NULL,
    [prodPrecio] DECIMAL(18,2) NOT NULL,
    [prodGenero] INT NOT NULL,
    [prodCategoria] INT NOT NULL,
	CONSTRAINT [PK_tbProductos] PRIMARY KEY CLUSTERED 
(
	[prodCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Procedimiento para Insertar Producto
CREATE PROCEDURE [dbo].[spCrearProducto]
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Imagen VARCHAR(255),
    @Cantidad INT,
    @Precio DECIMAL(18,2),
    @Genero INT,
    @Categoria INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [dbo].[Productos] WHERE [prodCodigo] = @Codigo)
    BEGIN
        INSERT INTO [dbo].[Productos]
        (prodCodigo, prodNombre, prodImagen, prodCantidad, prodPrecio, prodGenero, prodCategoria)
        VALUES
        (@Codigo, @Nombre, @Imagen, @Cantidad, @Precio, @Genero, @Categoria);
    END
END
GO

-- Procedimiento para Actualizar Producto
CREATE PROCEDURE [dbo].[spActualizarProducto]
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Imagen VARCHAR(255),
    @Cantidad INT,
    @Precio DECIMAL(18,2),
    @Genero INT,
    @Categoria INT
AS
BEGIN
    UPDATE [dbo].[Productos]
    SET 
        prodNombre = @Nombre,
        prodImagen = @Imagen,
        prodCantidad = @Cantidad,
        prodPrecio = @Precio,
        prodGenero = @Genero,
        prodCategoria = @Categoria
    WHERE prodCodigo = @Codigo
END
GO

-- Procedimiento para Eliminar Producto
CREATE PROCEDURE [dbo].[spEliminarProducto]
    @Codigo VARCHAR(50)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM [dbo].[Productos] WHERE [prodCodigo] = @Codigo)
		BEGIN
    	DELETE FROM [dbo].[Productos]
    	WHERE prodCodigo = @Codigo
		END
END
GO

-- Procedimiento para Consultar Todos los Productos
CREATE PROCEDURE [dbo].[spConsultarProducto]
AS
BEGIN
    SELECT 
        prodCodigo,
        prodNombre,
        prodImagen,
        prodCantidad,
        prodPrecio,
        prodGenero,
        prodCategoria
    FROM [dbo].[Productos]
	JOIN 
END
GO

-- Procedimiento para Consultar un Producto específico
CREATE PROCEDURE [dbo].[spConsultarProducto]
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT 
        prodCodigo,
        prodNombre,
        prodImagen,
        prodCantidad,
        prodPrecio,
        prodGenero,
        prodCategoria
    FROM [dbo].[Productos]
    WHERE prodCodigo = @Codigo
END
GO


-- Crear tabla de Géneros
CREATE TABLE [dbo].[Generos](
    [GeneroID] INT PRIMARY KEY,
    [Nombre] VARCHAR(100) NOT NULL
);
GO

-- Insertar géneros básicos
INSERT INTO [dbo].[Generos] (GeneroID, Nombre) VALUES
    (1, 'Masculino'),
    (2, 'Femenino'),
    (3, 'Unisex');
GO

-- Modificar la tabla Productos para agregar la relación con Generos
ALTER TABLE [dbo].[Productos]
ADD CONSTRAINT FK_Productos_Generos 
FOREIGN KEY (Genero) REFERENCES Generos(GeneroID);
GO

-- Crear tabla de Categorías
CREATE TABLE [dbo].[Categorias](
    [CategoriaID] INT PRIMARY KEY,
    [Nombre] VARCHAR(100) NOT NULL
);
GO

-- Insertar las categorías iniciales
INSERT INTO [dbo].[Categorias] (CategoriaID, Nombre) VALUES
    (-1, '--Seleccione--'),
    (1, 'Camisas'),
    (2, 'Correas'),
    (3, 'Zapatos'),
    (4, 'Calzado Dama');
GO

-- Modificar la tabla Productos para agregar la relación con Categorias
ALTER TABLE [dbo].[Productos]
ADD CONSTRAINT FK_Productos_Categorias 
FOREIGN KEY (Categoria) REFERENCES Categorias(CategoriaID);
GO
--tabla pedido
CREATE TABLE tbPedidos (
    PedidoID INT IDENTITY(1,1), -- Identificador único del pedido
    Cliente VARCHAR(255) NOT NULL, -- Nombre completo del cliente
    Correo VARCHAR(255) NOT NULL, -- Correo del cliente
    Telefono VARCHAR(15) NOT NULL, -- Teléfono del cliente
    Direccion TEXT NOT NULL, -- Dirección del cliente
    Total DECIMAL(10, 2) NOT NULL, -- Monto total de la compra
    fecha_registro DATETIME DEFAULT GETDATE(), -- Fecha y hora de la compra
    status VARCHAR(50) DEFAULT 'Creada' -- Estado del pedido
    CONSTRAINT [PK_tbPedidos] PRIMARY KEY CLUSTERED 
(
	[PedidoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
-- crear tabla pedido detalle

CREATE TABLE tbPedidoDetalle (
    id INT IDENTITY(1,1), -- Identificador único del detalle
    PedidoID INT NOT NULL, -- Relación con la tabla de pedidos
    prodCodigo VARCHAR(50) NOT NULL, -- Relación con el código del producto
    Cantidad INT NOT NULL, -- Cantidad comprada
    Precio DECIMAL(10, 2) NOT NULL, -- Precio unitario del producto
    Subtotal DECIMAL(10, 2) NOT NULL, -- Subtotal para este producto
    CONSTRAINT [PK_tbPedidoDetalle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[tbPedidoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_tbPedidos_tbDetalle] FOREIGN KEY([PedidoID])
REFERENCES [dbo].[tbPedidos] ([PedidoID])
ALTER TABLE [dbo].[tbPedidoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_tbPedidosDetale_tbProductos] FOREIGN KEY([prodCodigo])
REFERENCES [dbo].[tbProductos] ([prodCodigo])
GO
ALTER TABLE [dbo].[tbPedidoDetalle] CHECK CONSTRAINT [FK_tbPedidos_tbDetalle]
ALTER TABLE [dbo].[tbPedidoDetalle] CHECK CONSTRAINT [FK_tbPedidos_tbProductos]
GO
