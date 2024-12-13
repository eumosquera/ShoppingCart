package Controllers;

import domain.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.ProductoDTO;

/**
 *
 * @author esteb
 */
public class ProductController extends HttpServlet {

    ProductoDTO objProdu = new ProductoDTO();
    private final String pagListar = "listar.jsp";
    private final String pagNuevo = "NuevoProducto.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String accion = request.getParameter("accion");

        switch (accion) {
            case "listar" ->
                listar(request, response);
            case "editar" ->
                editar(request, response);
            case "guardar" ->
                guardar(request, response);
            case "eliminar" ->
                eliminar(request, response);
            default ->
                throw new AssertionError();
        }

    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        request.setAttribute("productos", objProdu.ListarTodos());
        request.getRequestDispatcher(pagListar).forward(request, response);

    } // FIN MEDOTO LISTAR

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        String prodCodigo = request.getParameter("prodCodigo");
        Producto objP = objProdu.buscarID(prodCodigo);

        if (objP != null) {
            request.setAttribute("producto", objP);
            request.getRequestDispatcher(pagNuevo).forward(request, response);
        } else {
            request.getSession().setAttribute("error", "No se encontro producto con Codigo " + prodCodigo);
            response.sendRedirect("ProductController?accion=listar");
        }

    } // FIN MEDOTO EDITAR

    private void guardar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        Producto objproducto = new Producto();

        objproducto.setprodCodigo(request.getParameter("txtCodigo"));
        objproducto.setProdNombre(request.getParameter("txtNombre"));
        objproducto.setProdImagen(request.getParameter("txtImagen"));
        objproducto.setProdCantidad(Integer.valueOf(request.getParameter("txtCantidad")));
        objproducto.setProdPrecio(Double.valueOf(request.getParameter("txtPrecio")));
        objproducto.setProdGenero(request.getParameter("ddlGenero"));
        objproducto.setProdCategoria(request.getParameter("ddlCategoria"));

        boolean resultado = false;

        resultado = objProdu.modificarProducto(objproducto);
        System.out.println("resultado variable:" + resultado);
        if (resultado) {
            request.getSession().setAttribute("success", "Datos guardados!");
            response.sendRedirect("ProductController?accion=listar");
        } else {
            request.getSession().setAttribute("error", "No se pudo guardar datos.");
            request.setAttribute("producto", objproducto);
            request.getRequestDispatcher(pagNuevo).forward(request, response);
        }

    } // FIN MEDOTO PARA GUARDAR

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {

        String prodCodigo = request.getParameter("prodCodigo");

        boolean resultado = objProdu.eliminar(prodCodigo);
        try {
            if (resultado) {
                request.setAttribute("message", "Producto con codigo: " + prodCodigo + " eliminado!");
                request.setAttribute("type", "success");
                request.getRequestDispatcher(pagListar).forward(request, response);
                //response.sendRedirect("ProductController?accion=listar");
            } else {
                request.setAttribute("message", "Error. El producto con codigo: " + request.getParameter("prodCodigo") + " Está en un pedido.");
                request.setAttribute("type", "error");
                request.getRequestDispatcher(pagListar).forward(request, response);
                //response.sendRedirect("ProductController?accion=listar");
            }
            //request.getRequestDispatcher(pagListar).forward(request, response);
            response.sendRedirect("ProductController?accion=listar");
        } catch (Exception e) {
            request.setAttribute("message", "Ocurrió un error al intentar eliminar el producto: " + e.getMessage());
            request.setAttribute("type", "error");
            request.getRequestDispatcher(pagListar).forward(request, response);
            //response.sendRedirect("ProductController?accion=listar");
        }

    } // FIN MEDOTO ELIMINAR

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            System.out.println("Err:" + ex);
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
