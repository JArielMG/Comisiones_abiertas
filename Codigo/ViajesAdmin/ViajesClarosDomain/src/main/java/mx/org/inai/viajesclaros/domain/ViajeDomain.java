
package mx.org.inai.viajesclaros.domain;

import java.util.List;

/**
 *
 * @author Sandro Alejandro
 */
public class ViajeDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private List<String> datos;
    private List<String> headers;

    public ViajeDomain() {
    }
    
    public ViajeDomain(List<String> datos) {
        this.datos = datos;
    }
    
    /**
     * @return the datos
     */
    public List<String> getDatos() {
        return datos;
    }

    /**
     * @param datos the datos to set
     */
    public void setDatos(List<String> datos) {
        this.datos = datos;
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
     * @return the headers
     */
    public List<String> getHeaders() {
        return headers;
    }

    /**
     * @param headers the headers to set
     */
    public void setHeaders(List<String> headers) {
        this.headers = headers;
    }
}
