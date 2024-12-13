
package service;

import Datos.ConexionDB;
import domain.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author esteb
 */
public class ProductService {
    
    ConexionDB obConexionDB = new ConexionDB();
    Connection conn = null;
    
    public ProductService(){
        
        conn = obConexionDB.getConnexion();
    }
    
    public List<Product> GetProducts() throws Exception {

        try {

            List<Product> products = new ArrayList<>();
            
            
            
            PreparedStatement ps = conn.prepareStatement("{ call spConsultarProducto() }");
            
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                //asignando
                p.setCodigo(rs.getString("prodCodigo"));
                p.setNombre(rs.getString("prodNombre"));
                p.setImagen(rs.getString("prodImagen"));
                p.setCantidad(rs.getInt("prodCantidad"));
                p.setPrecio(rs.getDouble("prodPrecio"));
                p.setGenero(rs.getString("prodGenero"));
                p.setCategoria(rs.getString("prodCategoria"));
                
                products.add(p);
            }

            return products;

        } catch (Exception ex) {
            throw ex;
        } finally{
            conn.close();
        }
    }
    
    public void CreateProduct(String codigo,String nombre,
            String imagen,
            int cantidad,
            double precio,
            String categoria,
            String genero) throws Exception {

        try {

            
            PreparedStatement ps = conn.prepareStatement("{ call spCrearProducto(?,?,?,?,?,?,?) }");

            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, imagen);
            ps.setInt(4, cantidad);
            ps.setDouble(5, precio);
            ps.setString(6, genero);
            ps.setString(7, categoria);

            ps.execute();

        } catch (Exception ex) {
            throw ex;
        }
    }

    
}
