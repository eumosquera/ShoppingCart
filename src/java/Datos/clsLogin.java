/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author esteb
 */
public class clsLogin {

    //IMPORTAR CLASE DE LA CONEXIÓN
    ConexionDB obConexionDB = new ConexionDB();
    Connection conn = null;

    //CONSTRUCTOR
    public clsLogin() {

        conn = obConexionDB.getConnexion();
        
    }

    public String stInsertarUsuario(Models.clsLogin obclsLogin) {

        try {

            PreparedStatement ps = conn.prepareStatement("{call spInsertarUsuario(?,?)}");

            ps.setString(1, obclsLogin.getStEmail());
            ps.setString(2, obclsLogin.getStPassword());

            ps.execute();
            return "OK";

        } catch (Exception e) {
            return e.getMessage();
        } finally {
            obConexionDB.cerrarConnexion(conn);
        }
    }

    public boolean validarLogin(Models.clsLogin obclsLogin) {
        try {

            PreparedStatement ps = conn.prepareCall("{ call spConsultarUsuario(?,?)}");

            ps.setString(1, obclsLogin.getStEmail());
            ps.setString(2, obclsLogin.getStPassword());

            ResultSet rs = ps.executeQuery();

            boolean blExiste = false;

            while (rs.next()) {
                blExiste = true;
            }

            return blExiste;

        } catch (Exception ex) {
            System.out.print(ex);
            return false;
        }
    }
    
    public boolean validarCorreo(Models.clsLogin obclsLogin) {
        try {

            PreparedStatement ps = conn.prepareCall("{ call spValidarCorreo(?)}");

            ps.setString(1, obclsLogin.getStEmail());

            ResultSet rs = ps.executeQuery();

            boolean blExiste = false;

            while (rs.next()) {
                blExiste = true;
            }

            return blExiste;

        } catch (Exception ex) {
            System.out.print(ex);
            return false;
        }
    }
    
}
