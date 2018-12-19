package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class ReporteFlujoComisionCargoVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer idComision;
	private String nombres;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String respuesta;
	private String nombreFlujo;
        private String cargo;
	
	public ReporteFlujoComisionCargoVO(Integer idComision,String nombres,String apellidoPaterno,String apellidoMaterno,String respuesta,String nombreFlujo, String cargo){
		this.idComision = idComision;
		this.nombres = nombres;
		this.apellidoPaterno = apellidoPaterno;
		this.apellidoMaterno = apellidoMaterno;
		this.respuesta = respuesta;
		this.nombreFlujo = nombreFlujo;
                this.cargo = cargo;
	}
	
	public Integer getIdComision() {
		return idComision;
	}
	public void setIdComision(Integer idComision) {
		this.idComision = idComision;
	}
	
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	
	public String getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(String respuesta) {
		this.respuesta = respuesta;
	}
	
	public String getNombreFlujo() {
		return nombreFlujo;
	}
	public void setNombreFlujo(String nombreFlujo) {
		this.nombreFlujo = nombreFlujo;
	}

        public String getCargo() {
            return cargo;
        }

        public void setCargo(String cargo) {
            this.cargo = cargo;
        }

        
}