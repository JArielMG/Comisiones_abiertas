package mx.org.inai.viajesclaros.admin.model;

import java.util.List;

public class SeccionesFormulario {
    
    private Integer idSeccion; 
    private String etiqueta;
    private String nombreSeccion;
    private Integer idFlujo;
    private Integer orden;
    private List<CamposFormulario> camposFormulario;

    /**
     * @return the idSeccion
     */
    public Integer getIdSeccion() {
        return idSeccion;
    }

    /**
     * @param idSeccion the idSeccion to set
     */
    public void setIdSeccion(Integer idSeccion) {
        this.idSeccion = idSeccion;
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
     * @return the etiqueta
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * @param descripcion the etiqueta to set
     */
    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    /**
     * @return the nombreSeccion
     */
    public String getNombreSeccion() {
        return nombreSeccion;
    }

    /**
     * @param nombreSeccion the nombreSeccion to set
     */
    public void setNombreSeccion(String nombreSeccion) {
        this.nombreSeccion = nombreSeccion;
    }

    /**
     * @return the camposFormulario
     */
    public List<CamposFormulario> getCamposFormulario() {
        return camposFormulario;
    }

    /**
     * @param camposFormulario the camposFormulario to set
     */
    public void setCamposFormulario(List<CamposFormulario> camposFormulario) {
        this.camposFormulario = camposFormulario;
    }
    
    /**
     * @return the orden
     */
        public Integer getOrden() {
        return orden;
    }
        
	/**
	 * @param nombreSeccion the nombreSeccion to set
	*/
	public void setOrden(Integer orden) {
		this.orden = orden;
    }
}
