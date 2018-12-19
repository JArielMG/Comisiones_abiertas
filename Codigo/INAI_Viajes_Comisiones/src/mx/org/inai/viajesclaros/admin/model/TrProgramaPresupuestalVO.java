package mx.org.inai.viajesclaros.admin.model;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

public class TrProgramaPresupuestalVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idProgramaPresupuestal;
    private String cvePp;
    private String descripcionPp;
    private Integer anio;
    private Set<TrUnidadAdministrativaVO> trUnidadAdministrativas = new HashSet<TrUnidadAdministrativaVO>(0);
    private Set<TrProgramaEspecialVO> trProgramaEspecials = new HashSet<TrProgramaEspecialVO>(0);

    public TrProgramaPresupuestalVO() {
    }

    public TrProgramaPresupuestalVO(String cvePp, String descripcionPp, Integer anio, Set<TrUnidadAdministrativaVO> trUnidadAdministrativas, Set<TrProgramaEspecialVO> trProgramaEspecials) {
        this.cvePp = cvePp;
        this.descripcionPp = descripcionPp;
        this.anio = anio;
        this.trUnidadAdministrativas = trUnidadAdministrativas;
        this.trProgramaEspecials = trProgramaEspecials;
    }

    public Integer getIdProgramaPresupuestal() {
        return this.idProgramaPresupuestal;
    }

    public void setIdProgramaPresupuestal(Integer idProgramaPresupuestal) {
        this.idProgramaPresupuestal = idProgramaPresupuestal;
    }

    public String getCvePp() {
        return this.cvePp;
    }

    public void setCvePp(String cvePp) {
        this.cvePp = cvePp;
    }

    public String getDescripcionPp() {
        return this.descripcionPp;
    }

    public void setDescripcionPp(String descripcionPp) {
        this.descripcionPp = descripcionPp;
    }

    public Integer getAnio() {
        return this.anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }

    public Set<TrUnidadAdministrativaVO> getTrUnidadAdministrativas() {
        return this.trUnidadAdministrativas;
    }

    public void setTrUnidadAdministrativas(Set<TrUnidadAdministrativaVO> trUnidadAdministrativas) {
        this.trUnidadAdministrativas = trUnidadAdministrativas;
    }

    public Set<TrProgramaEspecialVO> getTrProgramaEspecials() {
        return this.trProgramaEspecials;
    }

    public void setTrProgramaEspecials(Set<TrProgramaEspecialVO> trProgramaEspecials) {
        this.trProgramaEspecials = trProgramaEspecials;
    }
}
