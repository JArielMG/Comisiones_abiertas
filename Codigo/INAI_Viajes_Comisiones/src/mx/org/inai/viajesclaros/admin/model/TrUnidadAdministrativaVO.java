package mx.org.inai.viajesclaros.admin.model;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

public class TrUnidadAdministrativaVO implements Serializable{
    
    private static final long serialVersionUID = 1L;

    private Integer idUa;
    private Integer cveUa;
    private String nombreUa;
    private String titular;
    private Set<TrProgramaPresupuestalVO> trProgramaPresupuestals = new HashSet<TrProgramaPresupuestalVO>(0);

    public TrUnidadAdministrativaVO() {
    }

    public TrUnidadAdministrativaVO(Integer cveUa, String nombreUa, String titular, Set<TrProgramaPresupuestalVO> trProgramaPresupuestals) {
        this.cveUa = cveUa;
        this.nombreUa = nombreUa;
        this.titular = titular;
        this.trProgramaPresupuestals = trProgramaPresupuestals;
    }

    public TrUnidadAdministrativaVO(Integer id, Integer codigo, String descripcion) {
        this.idUa = id;
        this.cveUa = codigo;
        this.nombreUa = descripcion;
    }

    public Integer getIdUa() {
        return this.idUa;
    }

    public void setIdUa(Integer idUa) {
        this.idUa = idUa;
    }

    public Integer getCveUa() {
        return this.cveUa;
    }

    public void setCveUa(Integer cveUa) {
        this.cveUa = cveUa;
    }

    public String getNombreUa() {
        return this.nombreUa;
    }

    public void setNombreUa(String nombreUa) {
        this.nombreUa = nombreUa;
    }

    public String getTitular() {
        return this.titular;
    }

    public void setTitular(String titular) {
        this.titular = titular;
    }

    public Set<TrProgramaPresupuestalVO> getTrProgramaPresupuestals() {
        return this.trProgramaPresupuestals;
    }

    public void setTrProgramaPresupuestals(Set<TrProgramaPresupuestalVO> trProgramaPresupuestals) {
        this.trProgramaPresupuestals = trProgramaPresupuestals;
    }
}
