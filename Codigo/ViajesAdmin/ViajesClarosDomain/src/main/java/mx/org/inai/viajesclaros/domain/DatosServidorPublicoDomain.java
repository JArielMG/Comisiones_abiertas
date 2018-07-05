package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author victor.huerta
 */
public class DatosServidorPublicoDomain {
    private static final long serialVersionUID = 1L;
    
    /* primary key: tabla-campo */
    private String nombreCompleto;
    private String dependencia;
   
    /**
     * @return the nombreCompleto
     */
    public String getNombreCompleto() {
        return nombreCompleto;
    }

    /**
     * @param nombreCompleto the nombreCompleto to set
     */
    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    /**
     * @return the dependencia
     */
    public String getDependencia() {
        return dependencia;
    }

    /**
     * @param dependencia the dependencia to set
     */
    public void setDependencia(String dependencia) {
        this.dependencia = dependencia;
    }
}
