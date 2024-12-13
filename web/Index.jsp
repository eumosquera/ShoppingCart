

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Index</title>
        <!-- Bootstrap core CSS-->
        <link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
        <!-- Custom fonts for this template-->
        <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <!-- Page level plugin CSS-->
        <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
        <script src="dist/sweetalert.js"></script>
        <link rel="stylesheet" href="dist/sweetalert.css">
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Page level plugin JavaScript-->
        <script src="vendor/chart.js/Chart.min.js"></script>
        <script src="vendor/datatables/jquery.dataTables.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin.min.js"></script>
        <!-- Custom scripts for this page-->
        <script src="js/sb-admin-datatables.min.js"></script>
        <script src="js/sb-admin-charts.min.js"></script>

        <Script>
            function loadOption(option) {
                document.getElementById('frame').src = option;
            }
        </Script>

        <style>
            iframe{
                width: 100%;
                height: 1350px;
            }
        </style>
    </head>
    <body class="fixed-nav sticky-footer bg-dark" id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
            <a class="navbar-brand" href="Index.jsp">CARRITO DE COMPRAS</a>
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Agregar productos">
                        <a class="nav-link" onclick="loadOption('ProductoControllador')">

                           <i class="fa fa-fw fa-address-book"></i>
                            <span class="nav-link-text">Agregar Producto</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title=" Consultar ventas">
                        <a class="nav-link" 
                           onclick="loadOption('CarritoController?btnVerP=true')">
                            <i class="fa fa-fw fa-address-book"></i>
                            <span class="nav-link-text">Ventas</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Consultar productos">
                        <a class="nav-link"
                           onclick="loadOption('ProductController?accion=listar')">
                            <i class="fa fa-fw fa-address-book"></i>
                            <span class="nav-link-text">Ver Productos</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Ir al carrito">
                        <a class="nav-link" 
                           onclick="loadOption('CarritoController?btnIndex=true')">
                            <i class="fa fa-fw fa-address-book"></i>
                            <span class="nav-link-text">Carrito</span>
                        </a>
                    </li>
                    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Contactos">
                        <a class="nav-link" 
                           onclick="loadOption('ContactosController?btnConsultar=true')">
                            <i class="fa fa-fw fa-address-book"></i>
                            <span class="nav-link-text">Contactos</span>
                        </a>
                    </li>

                </ul>     
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">
                            <i class="fa fa-fw fa-sign-out"></i>Salir</a>
                    </li>
                </ul>
            </div>

        </nav>


        <div class="content-wrapper">
            <div class="container-fluid">
                
                <iframe id="frame" frameborder="0"></iframe>
            </div> 


            <footer class="sticky-footer">
                <div class="container">
                    <div class="text-center">
                        <small>Copyright © CarritoCompras</small>
                    </div>
                </div>
            </footer>               
        </div>
    </body>
</html>
