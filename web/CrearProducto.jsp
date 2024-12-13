<%-- 
    Document   : CrearProducto
    Created on : 20/11/2024, 4:14:15 p. m.
    Author     : esteb
--%>
<%@page import="domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Productos</title>
    </head>
    <body>
        <div class="container">
            <form method="post" action="ProductoControllador">

                <%
                    List<Product> products = new ArrayList();

                    if (session.getAttribute("products") != null) {
                        products = (List<Product>) session.getAttribute("products");
                    }
                %>

                <h1>Productos ( <%= products.size()%> )</h1>
                <hr>
                <div class="form-row">
                    <div class="col-md-3">
                        <label>Codigo:</label>
                        <input class="form-control" type="text" placeholder="Ingrese el código" id="txtCodigo" name="txtCodigo" />
                    </div>           
                    <div class="col-md-3">
                        <label>Nombre:</label>
                        <input class="form-control" type="text" placeholder="Ingrese el nombre" id="txtNombre" name="txtNombre" />
                    </div>
                    <div class="col-md-3">
                        <label>Cantidad:</label>
                        <input class="form-control" type="number" placeholder="Ingrese la cantidad" id="txtCantidad" name="txtCantidad" />
                    </div>
                    <div class="col-md-3">
                        <label>Precio</label>
                        <input class="form-control" type="number" placeholder="Ingrese la cantidad" id="txtPrecio" name="txtPrecio" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3">
                        <br>
                        <label>Genero:</label>
                        <select class="form-control" id="ddlGenero" name="ddlGenero">
                            <option value="-1">--Seleccione--</option>
                            <option value="1">Hombre</option>
                            <option value="2">Mujer</option>
                        </select>
                    </div>  
                    <div class="col-md-3">
                        <br>
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
                        <br>
                        <label>Imagen:</label>
                        <input placeholder="Ingrese la url" type="text" class="form-control" id="txtImagen" name="txtImagen" />
                    </div>  
                </div>
                <div class="form-row">
                    <div class="col-md-12">
                        <br>
                        <input class="btn-outline-success btn" type="submit" value="Guardar" id="btnGuardar" name="btnGuardar" />
                        <a class="btn-outline-primary btn" href="ListarProductos.jsp">Ver Sesion</a>
                        <a class="btn-outline-primary btn" href="refresh.jsp">Ver Todos</a>
                        <a class="btn-outline-danger btn" href="CarritoController" id="btnIndex" name="btnIndex" >Carrito de compra</a>
                    </div>
                </div>

                <%
                    if (request.getAttribute("preview") != null) {
                %>
                <label class="badge badge-success">Resumen: <%= request.getAttribute("preview")%> </label><br>
                <%
                    }
                %>

                <%
                    if (request.getParameter("txtCodigo") != null
                            && request.getParameter("txtNombre") != null) {
                %>

                <label class="badge badge-dark">Codigo: <%= request.getParameter("txtCodigo")%> </label><br>
                <label class="badge badge-dark">Nombre: <%= request.getParameter("txtNombre")%> </label><br>
                <label class="badge badge-dark">Cantidad: <%= request.getParameter("txtCantidad")%> </label><br>
                <label class="badge badge-dark">Precio: <%= request.getParameter("txtPrecio")%> </label><br>

                <%
                    }
                %>

            </form>
        </div>
        
    </body>
</html>
