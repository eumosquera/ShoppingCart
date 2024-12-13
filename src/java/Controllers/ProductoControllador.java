package Controllers;

import domain.Product;
import domain.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.List;
import service.ProductService;
import service.ProductoDTO;

/**
 *
 * @author esteb
 */
@WebServlet(name = "ProductoControllador", urlPatterns = {"/ProductoControllador"})
public class ProductoControllador extends HttpServlet {

    ProductoDTO objProdu = new ProductoDTO();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            String codigo = request.getParameter("txtCodigo");
            String nombre = request.getParameter("txtNombre");
            String imagen = request.getParameter("txtImagen");
            int cantidad = Integer.valueOf(request.getParameter("txtCantidad"));
            double precio = Double.valueOf(request.getParameter("txtPrecio"));
            String genero = request.getParameter("ddlGenero");
            String categoria = request.getParameter("ddlCategoria");
            
            ProductService productService = new ProductService();
            productService.CreateProduct(codigo, nombre, imagen, cantidad, precio, categoria, genero);

            HttpSession session = request.getSession();

            Product p = new Product();

            p.setCodigo(codigo);
            p.setNombre(nombre);
            p.setCantidad(cantidad);
            p.setPrecio(precio);
            p.setGenero(genero);
            p.setCategoria(categoria);
            p.setImagen(imagen);

            List<Product> products = new ArrayList<>();

            if (session.getAttribute("products") != null) {
                products = (List<Product>) session.getAttribute("products");
            }

            products.add(p);

            session.setAttribute("products", products);
            request.setAttribute("preview", codigo + "/" + nombre + "/" + cantidad + "/" + precio);

            request.getRequestDispatcher("CrearProducto.jsp").forward(request, response);

        } catch (Exception e) {

            request.getRequestDispatcher("CrearProducto.jsp").forward(request, response);

        }

    } // FIN METODO 



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
        processRequest(request, response);
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
        processRequest(request, response);
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
