package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.math.BigInteger;


public class ErrorInterfazVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private BigInteger idArchivo;
	private int linea;
	private String estatus;
	private String error;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public BigInteger getIdArchivo() {
		return idArchivo;
	}
	public void setIdArchivo(BigInteger idArchivo) {
		this.idArchivo = idArchivo;
	}
	
	public int getLinea() {
		return linea;
	}
	public void setLinea(int linea) {
		this.linea = linea;
	}
	
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
}
