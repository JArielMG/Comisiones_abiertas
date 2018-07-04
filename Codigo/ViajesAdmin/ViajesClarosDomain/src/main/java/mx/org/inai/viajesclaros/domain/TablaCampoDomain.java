
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class TablaCampoDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private String tabla;
    private String campo;
    private String despliegueCampo;
    private String categoria;
    private Boolean constraintFails; // Para saber si se puede eliminar este registro

    /**
     * @return the tabla
     */
    public String getTabla() {
        return tabla;
    }

    /**
     * @param tabla the tabla to set
     */
    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    /**
     * @return the campo
     */
    public String getCampo() {
        return campo;
    }

    /**
     * @param campo the campo to set
     */
    public void setCampo(String campo) {
        this.campo = campo;
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

    /**
     * @return the despliegueCampo
     */
    public String getDespliegueCampo() {
        return despliegueCampo;
    }

    /**
     * @param despliegueCampo the despliegueCampo to set
     */
    public void setDespliegueCampo(String despliegueCampo) {
        this.despliegueCampo = despliegueCampo;
    }

    /**
     * @return the categoria
     */
    public String getCategoria() {
        return categoria;
    }

    /**
     * @param categoria the categoria to set
     */
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
}
