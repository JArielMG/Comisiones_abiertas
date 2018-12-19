package mx.org.inai.viajesclaros.admin.model;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

public class TrProgramaEspecialVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idProgramaEspecial;
    private TrPlaneacionPresupuestalVO trPlaneacionPresupuestal;
    private TrProgramaPresupuestalVO trProgramaPresupuestal;
    private String cvePe;
    private String nombrePe;
    private Set<TrActividadPresupuestalVO> trActividadPresupuestals = new HashSet<TrActividadPresupuestalVO>(0);

    public TrProgramaEspecialVO() {
    }

    public TrProgramaEspecialVO(TrPlaneacionPresupuestalVO trPlaneacionPresupuestal, TrProgramaPresupuestalVO trProgramaPresupuestal) {
        this.trPlaneacionPresupuestal = trPlaneacionPresupuestal;
        this.trProgramaPresupuestal = trProgramaPresupuestal;
    }

    public TrProgramaEspecialVO(TrPlaneacionPresupuestalVO trPlaneacionPresupuestal, TrProgramaPresupuestalVO trProgramaPresupuestal, String cvePe, String nombrePe, Set<TrActividadPresupuestalVO> trActividadPresupuestals) {
        this.trPlaneacionPresupuestal = trPlaneacionPresupuestal;
        this.trProgramaPresupuestal = trProgramaPresupuestal;
        this.cvePe = cvePe;
        this.nombrePe = nombrePe;
        this.trActividadPresupuestals = trActividadPresupuestals;
    }

    public Integer getIdProgramaEspecial() {
        return this.idProgramaEspecial;
    }

    public void setIdProgramaEspecial(Integer idProgramaEspecial) {
        this.idProgramaEspecial = idProgramaEspecial;
    }

    public TrPlaneacionPresupuestalVO getTrPlaneacionPresupuestal() {
        return this.trPlaneacionPresupuestal;
    }

    public void setTrPlaneacionPresupuestal(TrPlaneacionPresupuestalVO trPlaneacionPresupuestal) {
        this.trPlaneacionPresupuestal = trPlaneacionPresupuestal;
    }

    public TrProgramaPresupuestalVO getTrProgramaPresupuestal() {
        return this.trProgramaPresupuestal;
    }

    public void setTrProgramaPresupuestal(TrProgramaPresupuestalVO trProgramaPresupuestal) {
        this.trProgramaPresupuestal = trProgramaPresupuestal;
    }

    public String getCvePe() {
        return this.cvePe;
    }

    public void setCvePe(String cvePe) {
        this.cvePe = cvePe;
    }

    public String getNombrePe() {
        return this.nombrePe;
    }

    public void setNombrePe(String nombrePe) {
        this.nombrePe = nombrePe;
    }

    public Set<TrActividadPresupuestalVO> getTrActividadPresupuestals() {
        return this.trActividadPresupuestals;
    }

    public void setTrActividadPresupuestals(Set<TrActividadPresupuestalVO> trActividadPresupuestals) {
        this.trActividadPresupuestals = trActividadPresupuestals;
    }
}
