package mx.org.inai.viajesclaros.admin.exception;

public class BonitaBPMException extends Exception {

	private static final long serialVersionUID = 1L;

	private Integer codigo;
	private String mensaje;
	
	public BonitaBPMException() {
		super();
	}
	
	public BonitaBPMException(Integer codigo, String mensaje) {
		super();
		this.codigo = codigo;
		this.mensaje = mensaje;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
}
