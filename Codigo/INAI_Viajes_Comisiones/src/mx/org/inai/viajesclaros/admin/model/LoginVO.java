package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class LoginVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String user;
	private String pwd;
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	

}
