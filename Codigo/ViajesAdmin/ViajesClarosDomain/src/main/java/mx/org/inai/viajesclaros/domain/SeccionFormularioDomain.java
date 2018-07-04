
package mx.org.inai.viajesclaros.domain;

import java.util.List;

/**
 *
 * @author Sandro Alejandro
 */
public class SeccionFormularioDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private String etiqueta;
    private String nombre;
    private Integer idFlujo;
    private Integer orden;
    private List<CampoFlujoDomain> campos;

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
     * @return the etiqueta
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * @param etiqueta the etiqueta to set
     */
    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
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

    /**
     * @return the idFlujo
     */
    public Integer getIdFlujo() {
        return idFlujo;
    }

    /**
     * @param idFlujo the idFlujo to set
     */
    public void setIdFlujo(Integer idFlujo) {
        this.idFlujo = idFlujo;
    }

    /**
     * @return the orden
     */
    public Integer getOrden() {
        return orden;
    }

    /**
     * @param orden the orden to set
     */
    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    /**
     * @return the campos
     */
    public List<CampoFlujoDomain> getCampos() {
        return campos;
    }

    /**
     * @param campos the campos to set
     */
    public void setCampos(List<CampoFlujoDomain> campos) {
        this.campos = campos;
    }
}
