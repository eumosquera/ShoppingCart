<%-- 
    Document   : Pedidos
    Created on : 13/12/2024, 7:38:33 a. m.
    Author     : esteb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.PedidoDetalleFac"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

        <script src="dist/sweetalert.js"></script>
        <link rel="stylesheet" href="dist/sweetalert.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar pedidos</title>
    </head>

    <% if (request.getAttribute("message") != null) {%>

    <input type="text" id="message" value="<%= request.getAttribute("message")%>" hidden="" />
    <input type="text" id="type" value="<%= request.getAttribute("type")%>" hidden="" />
    <script>
        var message = document.getElementById("message").value;
        var type = document.getElementById("type").value;
        swal("Notificación", message, type);
    </script>

    <%}%>  

    <div class="container">
        <h1 style="text-align: center;">Facturación de Pedidos</h1>
        <%
            Map<Integer, List<PedidoDetalleFac>> pedidosAgrupados = 
                (Map<Integer, List<PedidoDetalleFac>>) request.getAttribute("pedidosAgrupados");
        %>
        <%
            for (Map.Entry<Integer, List<PedidoDetalleFac>> entry : pedidosAgrupados.entrySet()) {
                List<PedidoDetalleFac> detalles = entry.getValue();
                PedidoDetalleFac primerDetalle = detalles.get(0); // Para mostrar la información del cliente.
        %>
        <div class="card mb-6">
            <div class="card-header">
                <h2>Pedido Número: <%= primerDetalle.getPedidoID() %></h2>
                <small>Fecha: <%= primerDetalle.getFechaRegistro() %></small>
            </div>
            <div class="card-body">
                <p><strong>Cliente:</strong> <%= primerDetalle.getCliente() %></p>
                <p><strong>Correo:</strong> <%= primerDetalle.getCorreo() %></p>
                <p><strong>Teléfono:</strong> <%= primerDetalle.getTelefono() %></p>
                <p><strong>Dirección:</strong> <%= primerDetalle.getDireccion() %></p>
                <p><strong style="font-size: 18px;">Total Pedido:</strong> $<%= primerDetalle.getTotal() %></p>
            </div>
            <h3>Productos:</h3>
            <table class="table table-bordered">
                <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Subtotal</th>
                </tr>
                <%
                    for (PedidoDetalleFac detalle : detalles) {
                %>
                <tr>
                    <td><%= detalle.getProdCodigo() %></td>
                    <td><%= detalle.getProdNombre() %></td>
                    <td><%= detalle.getCantidad() %></td>
                    <td>$<%= detalle.getPrecio() %></td>
                    <td>$<%= detalle.getSubtotal() %></td>
                </tr>
                <%
                    }
                %>
                <c:if test="${pedidosAgrupados.size() == 0}">
                    <tr class="text-center">
                        <td colspan="6">No hay registros</td>
                    </tr>
                </c:if>
            </table>

            <hr>
        </div>
        <%
            }
        %>
    </div>


</body>
</html>
