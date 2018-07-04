
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class SimpleElementDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private String codigo;
    private String descripcion;
    
    public SimpleElementDomain(){
    }
    
    public SimpleElementDomain(Integer id, String descripcion) {
        this.id = id;
        this.descripcion = descripcion;
    }

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
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the codigo
     */
    public String getCodigo() {
        return codigo;
    }

    /**
     * @param codigo the codigo to set
     */
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
}
