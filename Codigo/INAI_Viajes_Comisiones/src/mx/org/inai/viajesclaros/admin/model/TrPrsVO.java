package mx.org.inai.viajesclaros.admin.model;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

public class TrPrsVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idPrs;
    private String prs;
    private Set<TrActividadPresupuestalVO> trActividadPresupuestals = new HashSet<TrActividadPresupuestalVO>(0);

    public TrPrsVO() {
    }

    public TrPrsVO(String prs, Set<TrActividadPresupuestalVO> trActividadPresupuestals) {
        this.prs = prs;
        this.trActividadPresupuestals = trActividadPresupuestals;
    }

    public Integer getIdPrs() {
        return this.idPrs;
    }

    public void setIdPrs(Integer idPrs) {
        this.idPrs = idPrs;
    }

    public String getPrs() {
        return this.prs;
    }

    public void setPrs(String prs) {
        this.prs = prs;
    }

    public Set<TrActividadPresupuestalVO> getTrActividadPresupuestals() {
        return this.trActividadPresupuestals;
    }

    public void setTrActividadPresupuestals(Set<TrActividadPresupuestalVO> trActividadPresupuestals) {
        this.trActividadPresupuestals = trActividadPresupuestals;
    }

}
