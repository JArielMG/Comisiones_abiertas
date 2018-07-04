package mx.org.inai.viajesclaros.admin.model;

import java.util.Date;

public class ProcesaInterfazVO {
	private long idArchivo;
	private String archivo;
	private Date fechaCarga;
	private int totalReg;
	private int aceptados;
	private int rechazados;
	
	
	public long getIdArchivo() {
		return idArchivo;
	}
	public void setIdArchivo(long idArchivo) {
		this.idArchivo = idArchivo;
	}
	
	public String getArchivo() {
		return archivo;
	}
	public void setArchivo(String archivo) {
		this.archivo = archivo;
	}
	
	public Date getFechaCarga() {
		return fechaCarga;
	}
	public void setFechaCarga(Date fechaCarga) {
		this.fechaCarga = fechaCarga;
	}
	public int getTotalReg() {
		return totalReg;
	}
	public void setTotalReg(int totalReg) {
		this.totalReg = totalReg;
	}
	
	public int getAceptados() {
		return aceptados;
	}
	public void setAceptados(int aceptados) {
		this.aceptados = aceptados;
	}
	
	public int getRechazados() {
		return rechazados;
	}
	public void setRechazados(int rechazados) {
		this.rechazados = rechazados;
	}
	
}
