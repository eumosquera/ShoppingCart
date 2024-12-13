
package Controllers;

import domain.Pedido;
import domain.PedidoDetalle;
import domain.PedidoDetalleFac;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import domain.Product;
import jakarta.faces.flow.SwitchCase;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.PedidoDTO;
import service.ProductService;

/**
 *
 * @author esteb
 */
@WebServlet(name = "CarritoController", urlPatterns = {"/CarritoController"})
public class CarritoController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        if (request.getParameter("btnIndex") != null) {
            Index(request, response);
        } else if (request.getParameter("btnGuardarC") != null) {
            btnGuardarC(request, response);

        } else if (request.getParameter("btnVerP") != null) {
            btnVerP(request, response);
        } else {
            ShoppingCart(request, response);
        }

    }

    private void Index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Product> products = new ArrayList<>();
            ProductService productService = new ProductService();
            products = productService.GetProducts();
            request.setAttribute("products", products);

            request.getRequestDispatcher("Carrito.jsp").forward(request, response);
        } catch (Exception ex) {
            request.setAttribute("message", ex.getMessage());
            System.out.println("eror: en btnindex carrito" + ex);
            request.setAttribute("type", "error");
            request.getRequestDispatcher("Carrito.jsp").forward(request, response);
        }

    } // FIN METODO INDEX

    private void ShoppingCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String id = request.getParameter("id");
            String action = request.getParameter("action");

            HttpSession session = request.getSession();

            List<Product> shoppingCart = new ArrayList<>();
            Product p = new Product();

            List<Product> products = new ArrayList<>();
            ProductService productService = new ProductService();
            products = productService.GetProducts();
            request.setAttribute("products", products);

            if (session.getAttribute("shoppingCart") != null) {
                shoppingCart = (List<Product>) session.getAttribute("shoppingCart");
            }

            for (Product item : products) {
                if (item.getCodigo().equals(id)) {
                    p = item;
                    break;
                }
            }

            boolean exist = false;

            for (Product item : shoppingCart) {
                if (item.getCodigo().equals(id)) {
                    exist = true;
                    int cantidadActual = item.getCantidad();

                    if (action.equals("add")) {
                        //validar la cantidad
                        if (cantidadActual < p.getCantidad()) {
                            item.setCantidad(cantidadActual + 1);
                        } else {
                            request.setAttribute("message", "No quedan existencias suficientes del producto: " + p.getNombre());
                            request.setAttribute("type", "warning");
                        }

                    } else if (action.equals("remove")) {

                        if (cantidadActual == 1) {
                            shoppingCart.remove(item);
                        } else {
                            item.setCantidad(cantidadActual - 1);
                        }

                    }

                    break;
                }
            }

            if (!exist && "add".equals(action)) {
                if (p.getCantidad() > 0) {
                    p.setCantidad(1);
                    shoppingCart.add(p);
                } else {
                    request.setAttribute("message", "No quedan existencias suficientes del producto: " + p.getNombre());
                    request.setAttribute("type", "warning");

                }
            }

            session.setAttribute("shoppingCart", shoppingCart);

            request.getRequestDispatcher("Carrito.jsp").forward(request, response);
        } catch (Exception ex) {
            request.setAttribute("message", ex.getMessage());
            request.setAttribute("type", "error");

            request.getRequestDispatcher("Carrito.jsp").forward(request, response);
        }

    } // FIN METODO PARA EL CARRO

    private List<Product> getShoppingCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Product> shoppingCart = (List<Product>) session.getAttribute("shoppingCart");

        if (shoppingCart == null) {
            shoppingCart = new ArrayList<>();
        }

        return shoppingCart;
    } // FIN METODO OBTENER EL CARRITO LLENO

    private void btnGuardarC(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            String cliente = request.getParameter("txtNombreC");
            String correo = request.getParameter("txtCorreo");
            String telefono = request.getParameter("txtTelefono");
            String direccion = request.getParameter("txtDireccion");

            HttpSession session = request.getSession();

            List<Product> shoppingCart = (List<Product>) session.getAttribute("shoppingCart");

            if (shoppingCart == null || shoppingCart.isEmpty()) {
                request.setAttribute("message", "El carrito está vacío. No se puede finalizar a compra.");
                request.setAttribute("type", "warning");
                request.getRequestDispatcher("CrearVenta.jsp").forward(request, response);

            }

            //calcular total
            double total = 0;
            for (Product item : shoppingCart) {
                total += item.getPrecio() * item.getCantidad();
            }

            Pedido pedido = new Pedido();
            pedido.setCliente(cliente);
            pedido.setCorreo(correo);
            pedido.setTelefono(telefono);
            pedido.setDireccion(direccion);
            pedido.setTotal(total);

            //detalle
            List<PedidoDetalle> detalles = new ArrayList<>();

            for (Product item : shoppingCart) {

                PedidoDetalle detalle = new PedidoDetalle();
                detalle.setProdCodigo(item.getCodigo());
                detalle.setCantidad(item.getCantidad());
                detalle.setPrecio(item.getPrecio());
                detalle.setSubTotal(item.getPrecio() * item.getCantidad());
                detalles.add(detalle);
            }
            pedido.setDetalles(detalles);

            //guardar
            PedidoDTO pedidoDTO = new PedidoDTO();

            pedidoDTO.guardarPedido(pedido);

            //vaciar el carro
            session.removeAttribute("shoppingCart");
            request.setAttribute("message", "Pedido finalizado con éxito");
            request.setAttribute("type", "success");
            request.getRequestDispatcher("Carrito.jsp").forward(request, response);

        } catch (Exception ex) {

            request.setAttribute("message", "Error al procesar el pedido: " + ex.getMessage());
            request.setAttribute("type", "error");
            request.getRequestDispatcher("CrearVenta.jsp").forward(request, response);
            System.out.println("Aqui es: "+ex);
        }

    }// FIN METODO GUARDAR COMPRA

    private void btnVerP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            PedidoDTO pedidoDTO = new PedidoDTO();
            List<PedidoDetalleFac> detallesPedido = pedidoDTO.ListarTodos();

            Map<Integer, List<PedidoDetalleFac>> pedidosAgrupados = new HashMap<>();
            for (PedidoDetalleFac detalle : detallesPedido) {
                pedidosAgrupados.putIfAbsent(detalle.getPedidoID(), new ArrayList<>());
                pedidosAgrupados.get(detalle.getPedidoID()).add(detalle);
            }

            request.setAttribute("pedidosAgrupados", pedidosAgrupados);
            request.getRequestDispatcher("Pedidos.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("message", "Error al cargar los pedidos: " + e.getMessage());
            request.setAttribute("type", "error");

            request.getRequestDispatcher("Pedidos.jsp").forward(request, response);
        }

    }

    //crear metodo para mostrar la lista de pedidos y sus vista
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
        } catch (SQLException ex) {
            Logger.getLogger(CarritoController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(CarritoController.class.getName()).log(Level.SEVERE, null, ex);
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
