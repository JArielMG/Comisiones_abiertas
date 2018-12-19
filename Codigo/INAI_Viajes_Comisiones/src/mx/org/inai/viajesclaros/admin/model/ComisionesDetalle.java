package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.sql.Date;

public class ComisionesDetalle implements Serializable{

	private static final long serialVersionUID = 1L;

	private Integer idDetalle;
	private Integer idComision;
	private String tabla;
	private String campo;
        private String valorTexto;
        private Double valorNumerico;
        private Date valorFecha;

    public ComisionesDetalle() {
    }

    public ComisionesDetalle(Integer idDetalle, Integer idComision, String tabla, String campo, String valorTexto, Double valorNumerico, Date valorFecha) {
        this.idDetalle = idDetalle;
        this.idComision = idComision;
        this.tabla = tabla;
        this.campo = campo;
        this.valorTexto = valorTexto;
        this.valorNumerico = valorNumerico;
        this.valorFecha = valorFecha;
    }
    
    
    
	public Integer getIdDetalle() {
		return idDetalle;
	}
	
	public void setIdDetalle(Integer idDetalle) {
		this.idDetalle = idDetalle;
	}
	
	public Integer getIdComision() {
		return idComision;
	}
	
	public void setIdComision(Integer idComision) {
		this.idComision = idComision;
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

	public String getValorTexto() {
		return valorTexto;
	}

	public void setValorTexto(String valorTexto) {
		this.valorTexto = valorTexto;
	}

	public Double getValorNumerico() {
		return valorNumerico;
	}

	public void setValorNumerico(Double valorNumerico) {
		this.valorNumerico = valorNumerico;
	}

	public Date getValorFecha() {
		return valorFecha;
	}

	public void setValorFecha(Date valorFecha) {
		this.valorFecha = valorFecha;
	}
	
	

}
