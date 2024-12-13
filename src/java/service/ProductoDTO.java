/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import Datos.ConexionDB;
import domain.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.CallableStatement;

/**
 *
 * @author esteb
 */
public class ProductoDTO {

    ConexionDB obConexionDB = new ConexionDB();
    Connection conn = null;

    public ProductoDTO() {
        conn = obConexionDB.getConnexion();
    }

    public ArrayList<Producto> ListarTodos() {
        ArrayList<Producto> lista = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement("{call spConsultarProducto()}");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();

                //asignando
                p.setprodCodigo(rs.getString("prodCodigo"));
                p.setProdNombre(rs.getString("prodNombre"));
                p.setProdImagen(rs.getString("prodImagen"));
                p.setProdCantidad(rs.getInt("prodCantidad"));
                p.setProdPrecio(rs.getDouble("prodPrecio"));
                p.setProdGenero(rs.getString("prodGenero"));
                p.setProdCategoria(rs.getString("prodCategoria"));

                lista.add(p);
            }

        } catch (Exception e) {
            System.out.println("Error:" + e);
        }

        return lista;
    } // FIN METODO LISTAR TODOS

    public Producto buscarID(String prodCodigo) throws SQLException {

        Producto objproducto = null;
        try {
            PreparedStatement ps = conn.prepareCall("{ call spConsultarProductoID(?)}");

            ps.setString(1, prodCodigo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                objproducto = new Producto();

                //asignando
                objproducto.setprodCodigo(rs.getString("prodCodigo"));
                objproducto.setProdNombre(rs.getString("prodNombre"));
                objproducto.setProdImagen(rs.getString("prodImagen"));
                objproducto.setProdCantidad(rs.getInt("prodCantidad"));
                objproducto.setProdPrecio(rs.getDouble("prodPrecio"));
                objproducto.setProdGenero(rs.getString("prodGenero"));
                objproducto.setProdCategoria(rs.getString("prodCategoria"));
            }
        } catch (Exception e) {
            System.out.println("Error consid:" + e);
        } finally {
            conn.close();
        }

        return objproducto;
    }// fin metodo buscarid

    public boolean eliminar(String prodCodigo) throws SQLException {
        boolean resultado = false;
        try {
            CallableStatement  ps = conn.prepareCall("{ call spEliminarProducto(?,?)}");

            ps.setString(1, prodCodigo);
            ps.registerOutParameter(2, java.sql.Types.INTEGER);

            ps.execute();
            
            int resultadoSP = ps.getInt(2);

            if (resultadoSP ==1) {

                resultado = true;

            }

        } catch (Exception e) {
            
            System.out.println("No elimino " + e);
        } finally{
        conn.close();
        }
        return resultado;
    } // fin metodo eliminar

    public boolean modificarProducto(Producto objp) {

        boolean resultado = false;

        try {

            PreparedStatement ps = conn.prepareStatement("{ call spActualizarProducto(?,?,?,?,?,?,?)}");
            ps.setString(1, objp.getprodCodigo());
            ps.setString(2, objp.getProdNombre());
            ps.setString(3, objp.getProdImagen());
            ps.setInt(4, objp.getProdCantidad());
            ps.setDouble(5, objp.getProdPrecio());
            ps.setInt(6, Integer.parseInt(objp.getProdGenero()));
            ps.setInt(7, Integer.parseInt(objp.getProdCategoria()));
            int rowAffect = ps.executeUpdate();

            if (rowAffect>0) {
                resultado = true;
            }

        } catch (Exception e) {
            System.out.println("service.ProductoDTO.modificarProducto()" + e);

        }

        return resultado;

    }
}
