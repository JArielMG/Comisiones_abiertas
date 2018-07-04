
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class ValorListaDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idLista;
    private String nombreLista;
    private String codigo;
    private String valor;

    /**
     * @return the idLista
     */
    public Integer getIdLista() {
        return idLista;
    }

    /**
     * @param idLista the idLista to set
     */
    public void setIdLista(Integer idLista) {
        this.idLista = idLista;
    }

    /**
     * @return the codigo
     */
    public String getCodigo() {
        return codigo;
    }

    /**
     * @param codigo the codigo to set
     */
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    /**
     * @return the valor
     */
    public String getValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(String valor) {
        this.valor = valor;
    }

    /**
     * @return the nombreLista
     */
    public String getNombreLista() {
        return nombreLista;
    }

    /**
     * @param nombreLista the nombreLista to set
     */
    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }
    
}
