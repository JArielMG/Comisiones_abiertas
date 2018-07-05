package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class DetalleInterfazVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer idViaje;
	private String tabla;
	private String campo;
	private String valorT;
	private Number valorN;
	private Date valorF;

	
	public Integer getIdViaje() {
		return idViaje;
	}
	public void setIdViaje(Integer idViaje) {
		this.idViaje = idViaje;
	}
	
	public String getTabla() {
		return tabla;
	}
	public void setTabla(String tabla) {
		this.tabla = tabla;
	}
	public String getCampo() {
		return campo;
	}
	public void setCampo(String campo) {
		this.campo = campo;
	}
	
	public String getValorT() {
		return valorT;
	}
	public void setValorT(String valorT) {
		this.valorT = valorT;
	}
	
	public Number getValorN() {
		return valorN;
	}
	public void setValorN(Number valorN) {
		this.valorN = valorN;
	}
	
	public Date getValorF() {
		return valorF;
	}
	public void setValorF(Date valorF) {
		this.valorF = valorF;
	}
}
