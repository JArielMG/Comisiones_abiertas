package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class FlujosComisionesVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer idComision;
	private String f1;
	private String f2;
	private String f3;
	private String f4;
	
	public FlujosComisionesVO (Integer idComision,String f1,String f2,String f3,String f4){
		this.idComision = idComision;
		this.f1 = f1;
		this.f2 = f2;
		this.f3 = f3;
		this.f4 = f4;
	}
	
	public Integer getIdComision() {
		return idComision;
	}
	public void setIdComision(Integer idComision) {
		this.idComision = idComision;
	}
	
	public String getF1() {
		return f1;
	}
	public void setF1(String f1) {
		this.f1 = f1;
	}
	
	public String getF2() {
		return f2;
	}
	public void setF2(String f2) {
		this.f2 = f2;
	}
	
	public String getF3() {
		return f3;
	}
	public void setF3(String f3) {
		this.f3 = f3;
	}
	
	public String getF4() {
		return f4;
	}
	public void setF4(String f4) {
		this.f4 = f4;
	}
}
