package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class HeaderInterfazVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int idViaje;
	private int idDependencia;
	private Date fecPublic;
	private int idComision;
	private long idArchivo;

	public int getIdViaje() {
		return idViaje;
	}
	public void setIdViaje(int idViaje) {
		this.idViaje = idViaje;
	}
	
	public int getIdDependencia() {
		return idDependencia;
	}
	public void setIdDependencia(int idDependencia) {
		this.idDependencia = idDependencia;
	}
	
	public Date getFecPublic() {
		return fecPublic;
	}
	public void setFecPublic(Date fecPublic) {
		this.fecPublic = fecPublic;
	}
	
	public int getIdComision() {
		return idComision;
	}
	public void setIdComision(int idComision) {
		this.idComision = idComision;
	}
	
	public long getIdArchivo() {
		return idArchivo;
	}
	public void setIdArchivo(long idArchivo) {
		this.idArchivo = idArchivo;
	}
}
