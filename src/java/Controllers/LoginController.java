/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author esteb
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("btnAutenticar") != null) {

            btnAutenticar(request, response);

        } else if (request.getParameter("btnRegistrar") != null) {

            btnRegistrar(request, response);

        }

    }

    private void btnRegistrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try { // INICIO BLOQUE TRY

            String stMensaje = "";

            if (request.getParameter("txtEmail") == null) {
                stMensaje += "Ingrese email,";
            }
            if (request.getParameter("txtPassword") == null) {
                stMensaje += "Ingrese password";
            }
            if (request.getParameter("txtConfirmarPassword") == null) {
                stMensaje += "Debe confirmar el password";
            }

            if (!request.getParameter("txtPassword").equals(request.getParameter("txtConfirmarPassword"))) {
                stMensaje += "El password ingresado no coincide con la confirmación! ";

            }

            if (!stMensaje.equals("")) {
                throw new Exception(stMensaje.substring(0, stMensaje.length() - 1));
            }

            //INSTANCIA PARA LA VISTA
            Datos.clsLogin obclsLogin = new Datos.clsLogin();
            //INSTANCIA DEL MODELO
            Models.clsLogin obclsLoginModel = new Models.clsLogin();

            obclsLoginModel.setStEmail(request.getParameter("txtEmail"));
            obclsLoginModel.setStPassword(request.getParameter("txtPassword"));

            Datos.clsLogin obLogin = new Datos.clsLogin();

            boolean blBandera = obLogin.validarCorreo(obclsLoginModel);

            if (blBandera) {

                throw new Exception("Email ya está registrado.");

            }

            if (!obclsLogin.stInsertarUsuario(obclsLoginModel).equals("OK")) {
                throw new Exception("Se produjo un error durante el procedimiento.");
            } else {
                request.setAttribute("stMensaje", "Se realizo proceso con exito.");
                request.setAttribute("stTipo", "success");
                request.getRequestDispatcher("Registrar.jsp").forward(request, response);
            }

        } catch (Exception e) { //INICIO CATCH
            request.setAttribute("stError", e.getMessage());
            request.setAttribute("stMensaje", e.getMessage());
            request.setAttribute("stTipo", "error");
            request.getRequestDispatcher("Registrar.jsp").forward(request, response);

        } // FIN CATCH

    }

    private void btnAutenticar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String stMensaje = "";

            if (request.getParameter("txtEmail").equals("")) {
                stMensaje += "Ingrese email,";
            }
            if (request.getParameter("txtPassword").equals("")) {
                stMensaje += " Ingrese password,";
            }

            if (!stMensaje.equals("")) {
                throw new Exception(stMensaje.substring(0, stMensaje.length() - 1));
            }

            Models.clsLogin obclsLogin = new Models.clsLogin();

            obclsLogin.setStEmail(request.getParameter("txtEmail"));
            obclsLogin.setStPassword(request.getParameter("txtPassword"));

            Datos.clsLogin obLogin = new Datos.clsLogin();

            boolean blBandera = obLogin.validarLogin(obclsLogin);

            if (blBandera) {
                request.getRequestDispatcher("Index.jsp").forward(request, response);
            } else {
                throw new Exception("Email o password incorrecto.");
            }

        } catch (Exception e) {
            request.setAttribute("stError", e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);

        }

    }

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
