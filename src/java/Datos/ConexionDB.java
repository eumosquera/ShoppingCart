/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

import java.sql.DriverManager;
import java.sql.Connection;

/**
 *
 * @author esteb
 */
public class ConexionDB {

    // Variable para crear la conexion a la BD
    Connection conn = null;
    String stServidor, stDataBase, stUsuario, stPassword = "";

    public ConexionDB() { // METODO CONSTRUCTOR 

        //Bloque TRY PARA MANEJO DE ERORES EN LA CONEXION
        try {

            stServidor = "localhost";
            stDataBase = "ropa";
            stUsuario = "AdminDB";
            stPassword = "12345678";
            
            //CREAR CONEEXION
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String stConnexion="jdbc:sqlserver://"+stServidor+":1433; databaseName="+stDataBase;
            //String stConexion="jdbc:sqlserver://"+stServidor+":1433; databaseName="+stDataBase;
           
            conn = DriverManager.getConnection(stConnexion, stUsuario, stPassword);

        } catch (Exception ex) {

        }
    }

    // METODO PARA RETORNAR LA CONEXION
    public Connection getConnexion() {

        return conn;
    }

    // METODO PARA RETORNAR EL CIERRE DE LA CONEXION 
    public void cerrarConnexion(Connection conn) {

        try {

            conn.close();

        } catch (Exception ex) {

        }
    }

}
