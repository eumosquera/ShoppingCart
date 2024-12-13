<%-- 
    Document   : NuevoProducto
    Created on : 9/12/2024, 5:18:43 p. m.
    Author     : esteb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>Editar Producto</title>
    </head>
    <body>
        <div class="container mt-3">
            <div class="card">
                <div class="card-body">
                    <h3>${producto.prodCodigo == 0 ? "Nuevo": "Editar"} Producto</h3>
                    <hr />

                    <form action="ProductController" method="post">
                        <div class="mb-3">
                            <label>Codigo:</label>
                            <input class="form-control" type="text" placeholder="Ingrese el código" id="txtCodigo" name="txtCodigo" value="${producto.prodCodigo}"/>

                        </div>
                        <div class="mb-3">
                            <label>Nombre:</label>
                            <input class="form-control" type="text" placeholder="Ingrese el nombre" id="txtNombre" name="txtNombre" value="${producto.prodNombre}"/>
                        </div>
                        <div class="mb-3">
                            <label>Cantidad:</label>
                            <input class="form-control" type="number" placeholder="Ingrese la cantidad" id="txtCantidad" name="txtCantidad" value="${producto.prodCantidad}" />
                        </div>
                        <div class="mb-3">
                            <label>Precio</label>
                            <input class="form-control" type="number" placeholder="Ingrese la cantidad" id="txtPrecio" name="txtPrecio" value="${producto.prodPrecio}" />
                        </div>
                        <div class="mb-3">
                            <label>Genero:</label>
                            <select class="form-control" id="ddlGenero" name="ddlGenero">
                                <option value="-1">--Seleccione--</option>
                                <option value="1">Hombre</option>
                                <option value="2">Mujer</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Categoria:</label>
                            <select class="form-control" id="ddlCategoria" name="ddlCategoria">
                                <option value="-1">--Seleccione--</option>
                                <option value="1">Camisas</option>
                                <option value="2">Correas</option>
                                <option value="3">Zapatos</option>
                                <option value="4">Calzado Dama</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Imagen Url:</label>
                            <input placeholder="Ingrese la url" type="text" class="form-control" id="txtImagen" name="txtImagen" value="${producto.prodImagen}" />
                        </div>
                        <!-- AQUI VAMOS  PARA EDITAR LOS PRODUCTOS-->


                        <div class="mb-3">
                            <input type="hidden" name="prodCodigo" id="prodCodigo" value="${producto.prodCodigo}">
                            <input type="hidden" name="accion" value="guardar">
                            <button class="btn btn-primary btn-sm">
                                <i class="fa fa-save"></i> Guardar
                            </button>
                            <a href="ProductController?accion=listar" 
                               class="btn btn-dark btn-sm">
                                <i class="fa fa-arrow-left"></i> Volver atras
                            </a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
