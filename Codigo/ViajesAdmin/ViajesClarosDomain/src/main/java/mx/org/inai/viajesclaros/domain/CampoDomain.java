
package mx.org.inai.viajesclaros.domain;

/**
 * Clase Campo, se utiliza tanto para campos dinámicos como para campos base
 * @author Sandro Alejandro
 */
public class CampoDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    /* primary key: tabla-campo */
    private String tabla;
    private String campo;
    private String despliegue;
    private Integer idTipoDato;
    private String tipoDato;
    private Integer idTipoControl;
    private String tipoControl;
    private String operador;
    private Integer idLista;
    private String nombreLista;
    private String descripcion;
    private String categoria;
    private Boolean constraintFails;

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
     * @return the despliegue
     */
    public String getDespliegue() {
        return despliegue;
    }

    /**
     * @param despliegue the despliegue to set
     */
    public void setDespliegue(String despliegue) {
        this.despliegue = despliegue;
    }

    /**
     * @return the idTipoDato
     */
    public Integer getIdTipoDato() {
        return idTipoDato;
    }

    /**
     * @param idTipoDato the idTipoDato to set
     */
    public void setIdTipoDato(Integer idTipoDato) {
        this.idTipoDato = idTipoDato;
    }

    /**
     * @return the tipoDato
     */
    public String getTipoDato() {
        return tipoDato;
    }

    /**
     * @param tipoDato the tipoDato to set
     */
    public void setTipoDato(String tipoDato) {
        this.tipoDato = tipoDato;
    }

    /**
     * @return the idTipoControl
     */
    public Integer getIdTipoControl() {
        return idTipoControl;
    }

    /**
     * @param idTipoControl the idTipoControl to set
     */
    public void setIdTipoControl(Integer idTipoControl) {
        this.idTipoControl = idTipoControl;
    }

    /**
     * @return the tipoControl
     */
    public String getTipoControl() {
        return tipoControl;
    }

    /**
     * @param tipoControl the tipoControl to set
     */
    public void setTipoControl(String tipoControl) {
        this.tipoControl = tipoControl;
    }

    /**
     * @return the operador
     */
    public String getOperador() {
        return operador;
    }

    /**
     * @param operador the operador to set
     */
    public void setOperador(String operador) {
        this.operador = operador;
    }

    /**
     * @return the idLista
     */
    public Integer getIdLista() {
        return idLista;
    }

    /**
     * @param idLista the idLista to set
     */
    public void setIdLista(Integer idLista) {
        this.idLista = idLista;
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
