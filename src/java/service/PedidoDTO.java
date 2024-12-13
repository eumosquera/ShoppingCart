/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import Datos.ConexionDB;
import domain.Pedido;
import domain.PedidoDetalle;
import domain.PedidoDetalleFac;
import domain.Producto;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author esteb
 */
public class PedidoDTO {

    ConexionDB obConexionDB = new ConexionDB();
    Connection conn = null;

    public PedidoDTO() {

        conn = obConexionDB.getConnexion();
    }

    public void guardarPedido(Pedido pedido) throws SQLException {

        try {
            conn.setAutoCommit(false);
            CallableStatement ps = conn.prepareCall("{ call spCrearPedido(?,?,?,?,?,?) }");
            ps.setString(1, pedido.getCliente());
            ps.setString(2, pedido.getCorreo());
            ps.setString(3, pedido.getTelefono());
            ps.setString(4, pedido.getDireccion());
            ps.setDouble(5, pedido.getTotal());
            ps.registerOutParameter(6, java.sql.Types.INTEGER);
            ps.execute();
            
            int pedidoID = ps.getInt(6);

            CallableStatement psd = conn.prepareCall("{ call spCrearPedidoDetalle(?,?,?,?,?) }");

            for (PedidoDetalle detalle : pedido.getDetalles()) {
                psd.setInt(1, pedidoID);
                psd.setString(2, detalle.getProdCodigo());
                psd.setInt(3, detalle.getCantidad());
                psd.setDouble(4, detalle.getPrecio());
                psd.setDouble(5, detalle.getSubTotal());
                psd.addBatch();
            }
            psd.executeBatch();
            conn.commit();

        } catch (Exception e) {

            System.out.println("Error: " + e);
            if (conn != null) {
                conn.rollback();
            }
            throw new SQLException("Error al guardar el pedido y sus detalles: " + e.getMessage(), e);

        } finally {

            if (conn != null) {
                conn.setAutoCommit(true);
            }

            if (conn != null) {
                conn.close();
            }

        }

    }

    public List<PedidoDetalleFac> ListarTodos() throws SQLException {
        List<PedidoDetalleFac> detallesPedido = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement("{ call spConsultarPedido() }");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                PedidoDetalleFac detalle = new PedidoDetalleFac();
                detalle.setPedidoID(rs.getInt("PedidoID"));
                detalle.setCliente(rs.getString("Cliente"));
                detalle.setCorreo(rs.getString("Correo"));
                detalle.setTelefono(rs.getString("Telefono"));
                detalle.setDireccion(rs.getString("Direccion"));
                detalle.setTotal(rs.getDouble("Total"));
                detalle.setFechaRegistro(rs.getTimestamp("fecha_registro"));

                detalle.setProdCodigo(rs.getString("prodCodigo"));
                detalle.setProdNombre(rs.getString("prodNombre"));
                detalle.setProdImagen(rs.getString("prodImagen"));
                detalle.setCantidad(rs.getInt("Cantidad"));
                detalle.setPrecio(rs.getDouble("Precio"));
                detalle.setSubtotal(rs.getDouble("Subtotal"));

                detalle.setProdCategoria(rs.getString("prodCategoria"));
                detalle.setProdGenero(rs.getString("prodGenero"));

                detallesPedido.add(detalle);
            }

        } catch (Exception e) {

            System.out.println("Err Cons: " + e);

        } finally {
            conn.close();
        }

        return detallesPedido;

    }// METODO LISTAR TODOS 
}
