package mx.org.inai.viajesclaros.admin.model;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

public class TrPlaneacionPresupuestalVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idPlaneacion;
    private String cvePlaneacion;
    private Set<TrProgramaEspecialVO> trProgramaEspecials = new HashSet<TrProgramaEspecialVO>(0);

    public TrPlaneacionPresupuestalVO() {
    }

    public TrPlaneacionPresupuestalVO(String cvePlaneacion, Set<TrProgramaEspecialVO> trProgramaEspecials) {
        this.cvePlaneacion = cvePlaneacion;
        this.trProgramaEspecials = trProgramaEspecials;
    }

    public Integer getIdPlaneacion() {
        return this.idPlaneacion;
    }

    public void setIdPlaneacion(Integer idPlaneacion) {
        this.idPlaneacion = idPlaneacion;
    }

    public String getCvePlaneacion() {
        return this.cvePlaneacion;
    }

    public void setCvePlaneacion(String cvePlaneacion) {
        this.cvePlaneacion = cvePlaneacion;
    }

    public Set<TrProgramaEspecialVO> getTrProgramaEspecials() {
        return this.trProgramaEspecials;
    }

    public void setTrProgramaEspecials(Set<TrProgramaEspecialVO> trProgramaEspecials) {
        this.trProgramaEspecials = trProgramaEspecials;
    }
}
