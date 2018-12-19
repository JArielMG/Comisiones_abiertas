package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class TrActividadPresupuestalVO implements Serializable{
    
    private static final long serialVersionUID = 1L;

    public Integer getIdActividad() {
        return idActividad;
    }

    public void setIdActividad(Integer idActividad) {
        this.idActividad = idActividad;
    }

    public Integer getCve_ua() {
        return cve_ua;
    }

    public void setCve_ua(Integer cve_ua) {
        this.cve_ua = cve_ua;
    }

    public String getCve_pp() {
        return cve_pp;
    }

    public void setCve_pp(String cve_pp) {
        this.cve_pp = cve_pp;
    }

    public String getCve_pe() {
        return cve_pe;
    }

    public void setCve_pe(String cve_pe) {
        this.cve_pe = cve_pe;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrs() {
        return prs;
    }

    public void setPrs(String prs) {
        this.prs = prs;
    }
    
    private Integer idActividad;
    private Integer cve_ua;
    private String cve_pp;
    private String cve_pe;
    private String nombre;
    private String prs;

    public TrActividadPresupuestalVO() {
    }
    
}
