
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class ListaValoresDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idList;
    private String nombreLista;
    private Boolean habilitada;
    private Boolean constraintFails; // Para saber si tiene referencias de otras tablas (si es así no se puede eliminar)

    /**
     * @return the idList
     */
    public Integer getIdList() {
        return idList;
    }

    /**
     * @param idList the idList to set
     */
    public void setIdList(Integer idList) {
        this.idList = idList;
    }

    /**
     * @return the nombreLista
     */
    public String getNombreLista() {
        return nombreLista;
    }

    /**
     * @param nombreLista the nombreLista to set
     */
    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }

    /**
     * @return the habilitada
     */
    public Boolean getHabilitada() {
        return habilitada;
    }

    /**
     * @param habilitada the habilitada to set
     */
    public void setHabilitada(Boolean habilitada) {
        this.habilitada = habilitada;
    }

    /**
     * @return the constraintFails
     */
    public Boolean getConstraintFails() {
        return constraintFails;
    }

    /**
     * @param constraintFails the constraintFails to set
     */
    public void setConstraintFails(Boolean constraintFails) {
        this.constraintFails = constraintFails;
    }
}
