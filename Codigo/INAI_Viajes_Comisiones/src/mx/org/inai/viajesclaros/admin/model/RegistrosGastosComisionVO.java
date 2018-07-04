package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class RegistrosGastosComisionVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer idRegistro;
    private Double importe;
    private String concepto;
    private String tipoPago;
    private String comprobante;
    
    public RegistrosGastosComisionVO(Integer idRegistro, Double importe, String concepto, String tipoPago, String comprobante){
    	this.idRegistro = idRegistro;
    	this.importe = importe;
    	this.concepto = concepto;
    	this.tipoPago = tipoPago;
    	this.comprobante = comprobante;
    }
    
	public Integer getIdRegistro() {
		return idRegistro;
	}
	
	public void setIdRegistro(Integer idRegistro) {
		this.idRegistro = idRegistro;
	}
	
	public Double getImporte() {
		return importe;
	}
	
	public void setImporte(Double importe) {
		this.importe = importe;
	}
	
	public String getConcepto() {
		return concepto;
	}
	
	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}
	
	public String getTipoPago() {
		return tipoPago;
	}
	
	public void setTipoPago(String tipoPago) {
		this.tipoPago = tipoPago;
	}
	
	public String getComprobante() {
		return comprobante;
	}
	
	public void setComprobante(String comprobante) {
		this.comprobante = comprobante;
	}
}
