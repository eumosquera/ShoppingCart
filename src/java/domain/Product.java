
package domain;

/**
 *
 * @author esteb
 */
public class Product {
    
    public Product() {

    }
    
    public Product(String Codigo, String Nombre, String Imagen, int Cantidad, double Precio, String Genero, String Categoria) {
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Imagen = Imagen;
        this.Cantidad = Cantidad;
        this.Precio = Precio;
        this.Genero = Genero;
        this.Categoria = Categoria;
    }
    
    public Product GetProduct(String codigo) {
        Product p = new Product();
        return p;
    }

    public Product GetProduct(String codigo, String nombre) {
        Product p = new Product();
        return p;
    }


    public String  getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getImagen() {
        return Imagen;
    }

    public void setImagen(String Imagen) {
        this.Imagen = Imagen;
    }

    public int getCantidad() {
        return Cantidad;
    }

    public void setCantidad(int Cantidad) {
        this.Cantidad = Cantidad;
    }

    public double getPrecio() {
        return Precio;
    }

    public void setPrecio(double Precio) {
        this.Precio = Precio;
    }

    public String getGenero() {
        return Genero;
    }

    public void setGenero(String Genero) {
        this.Genero = Genero;
    }

    public String getCategoria() {
        return Categoria;
    }

    public void setCategoria(String Categoria) {
        this.Categoria = Categoria;
    }
    
    private String Codigo;
    private String Nombre;
    private String Imagen;
    private int Cantidad;
    private double Precio;
    private String Genero;
    private String Categoria;
    
}
