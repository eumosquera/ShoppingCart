<%-- 
    Document   : CrearVenta
    Created on : 2/12/2024, 12:48:14 p. m.
    Author     : esteb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Venta</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

        <script src="dist/sweetalert.js"></script>
        <link rel="stylesheet" href="dist/sweetalert.css">
    </head>
    <body>
        <div class="container">
            <% if (request.getAttribute("message") != null) {%>

            <input type="text" id="message" value="<%= request.getAttribute("message")%>" hidden="" />
            <input type="text" id="type" value="<%= request.getAttribute("type")%>" hidden="" />
            <script>
                var message = document.getElementById("message").value;
                var type = document.getElementById("type").value;
                swal("Notificación", message, type);
            </script>

            <%}%>  
            <%
                List<Product> products = new ArrayList<>();
                List<Product> shoppingCart = new ArrayList<>();

                if (request.getAttribute("products") != null) {
                    products = (List<Product>) request.getAttribute("products");
                }

                if (session.getAttribute("shoppingCart") != null) {
                    shoppingCart = (List<Product>) session.getAttribute("shoppingCart");
                }
            %>
            <h1 style="text-align: center;">Facturación y Envío</h1>
            <hr>
            <div>
                <h2>Resumen de la Compra</h2>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                double total = 0;
                                for (Product item : shoppingCart) {
                                    total += item.getPrecio() * item.getCantidad();
                            %>
                            <tr>
                                <td><%= item.getCodigo() %></td>
                                <td><%= item.getNombre() %></td>
                                <td><%= item.getCantidad() %></td>
                                <td>$<%= item.getPrecio() %></td>
                                <td>$<%= item.getPrecio() * item.getCantidad() %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="text-right">
                        <span class="badge badge-success" style="font-size: 20px;">Total de la compra: $<%= total %></span>
                    </div>
                    <hr>
                </div>
            </div>
            <div>
                <h2>Datos para completar la Compra</h2>
            </div>
            <hr>
            <form method="post" action="CarritoController">
                <div class="form-row">
                    <div class="col-md-3">
                        <label for="txtNombreC">Nombre completo:</label>
                        <input class="form-control" type="text" placeholder="Ingrese el nombre" id="txtNombreC" name="txtNombreC" required />
                    </div>           
                    <div class="col-md-3">
                        <label for="txtCorreo">Correo electrónico:</label>
                        <input class="form-control" type="email" placeholder="Ingrese el correo" id="txtCorreo" name="txtCorreo" required />
                    </div>
                    <div class="col-md-3">
                        <label for="txtTelefono">Teléfono:</label>
                        <input class="form-control" type="tel" placeholder="Ingrese el teléfono" id="txtTelefono" name="txtTelefono" required pattern="[0-9]{10}" />
                    </div>
                    <div class="col-md-3">
                        <label for="txtDireccion">Dirección:</label>
                        <input class="form-control" type="text" placeholder="Ingrese la dirección" id="txtDireccion" name="txtDireccion" required />
                    </div>
                </div>
                <hr>
                <div class="form-row">
                    <div class="col-md-12 text-right">
                        <button type="submit" name="btnGuardarC" id="btnGuardarC" class="btn btn-success">Finalizar Compra</button>
                        <a href="CarritoController" class="btn btn-info">Seguir comprando</a>
                    </div>
                </div>
            </form> 
        </div>


    </body>
</html>
