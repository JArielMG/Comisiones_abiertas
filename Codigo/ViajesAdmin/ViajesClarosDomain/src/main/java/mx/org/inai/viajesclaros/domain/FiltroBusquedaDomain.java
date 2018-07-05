
package mx.org.inai.viajesclaros.domain;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author Sandro Alejandro
 */
public class FiltroBusquedaDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id; 
    private Integer idDependencia;
    private String tabla;
    private String campo;
    private String descripcion;
    private String tipoControl;
    private String tipoDato;
    private Integer idCatalogo;
    private String comparador;
    private List<SimpleElementDomain> catalogo;
    private String valor;
    private Integer idValor;
    private Date fecha;
    private Integer idLista; // id de catálogo para campos dinámicos
    private Byte orden;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the tipoControl
     */
    public String getTipoControl() {
        return tipoControl;
    }

    /**
     * @param tipoControl the tipoControl to set
     */
    public void setTipoControl(String tipoControl) {
        this.tipoControl = tipoControl;
    }

    /**
     * @return the tipoDato
     */
    public String getTipoDato() {
        return tipoDato;
    }

    /**
     * @param tipoDato the tipoDato to set
     */
    public void setTipoDato(String tipoDato) {
        this.tipoDato = tipoDato;
    }

    /**
     * @return the idCatalogo
     */
    public Integer getIdCatalogo() {
        return idCatalogo;
    }

    /**
     * @param idCatalogo the idCatalogo to set
     */
    public void setIdCatalogo(Integer idCatalogo) {
        this.idCatalogo = idCatalogo;
    }

    /**
     * @return the comparador
     */
    public String getComparador() {
        return comparador;
    }

    /**
     * @param comparador the comparador to set
     */
    public void setComparador(String comparador) {
        this.comparador = comparador;
    }

    /**
     * @return the catalogo
     */
    public List<SimpleElementDomain> getCatalogo() {
        return catalogo;
    }

    /**
     * @param catalogo the catalogo to set
     */
    public void setCatalogo(List<SimpleElementDomain> catalogo) {
        this.catalogo = catalogo;
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
     * @return the idValor
     */
    public Integer getIdValor() {
        return idValor;
    }

    /**
     * @param idValor the idValor to set
     */
    public void setIdValor(Integer idValor) {
        this.idValor = idValor;
    }

    /**
     * @return the fecha
     */
    public Date getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the tabla
     */
    public String getTabla() {
        return tabla;
    }

    /**
     * @param tabla the tabla to set
     */
    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    /**
     * @return the campo
     */
    public String getCampo() {
        return campo;
    }

    /**
     * @param campo the campo to set
     */
    public void setCampo(String campo) {
        this.campo = campo;
    }

    /**
     * @return the idDependencia
     */
    public Integer getIdDependencia() {
        return idDependencia;
    }

    /**
     * @param idDependencia the idDependencia to set
     */
    public void setIdDependencia(Integer idDependencia) {
        this.idDependencia = idDependencia;
    }

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
     * @param orden the orden to set
     */
    public void setOrden(Byte orden) {
        this.orden = orden;
    }
    
    /**
     * @return the orden
     */
    public Byte getOrden() {
        return orden;
    }
}
