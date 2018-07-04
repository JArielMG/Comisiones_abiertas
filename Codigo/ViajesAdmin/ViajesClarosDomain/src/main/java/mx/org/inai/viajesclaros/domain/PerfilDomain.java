
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class PerfilDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private String nombre;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
