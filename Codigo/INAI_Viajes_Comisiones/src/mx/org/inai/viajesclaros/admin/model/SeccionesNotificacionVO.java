package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.List;

public class SeccionesNotificacionVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer idSeccion; 
        private String etiqueta;
        private String nombreSeccion;
        private ProcesoVO flujo;
        private Integer orden;
        private List<ComisionDetalleVO> detalle;
    
	public Integer getIdSeccion() {
		return idSeccion;
	}
	public void setIdSeccion(Integer idSeccion) {
		this.idSeccion = idSeccion;
	}
	public String getEtiqueta() {
		return etiqueta;
	}
	public void setEtiqueta(String etiqueta) {
		this.etiqueta = etiqueta;
	}
	public String getNombreSeccion() {
		return nombreSeccion;
	}
	public void setNombreSeccion(String nombreSeccion) {
		this.nombreSeccion = nombreSeccion;
	}
	public ProcesoVO getFlujo() {
		return flujo;
	}
	public void setFlujo(ProcesoVO flujo) {
		this.flujo = flujo;
	}
	public Integer getOrden() {
		return orden;
	}
	public void setOrden(Integer orden) {
		this.orden = orden;
	}
	public List<ComisionDetalleVO> getDetalle() {
		return detalle;
	}
	public void setDetalle(List<ComisionDetalleVO> detalle) {
		this.detalle = detalle;
	}
    
}
