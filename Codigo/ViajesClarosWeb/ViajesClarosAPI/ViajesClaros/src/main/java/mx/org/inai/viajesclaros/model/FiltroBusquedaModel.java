/*
 * Copyright (C) 2015 INAI
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package mx.org.inai.viajesclaros.model;

import java.sql.Date;
import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Sandro Alejandro
 */
@XmlRootElement
public class FiltroBusquedaModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private Integer id;     // Id del par+ametro
    private String campo;
    private String descripcion;
    private String tipoControl;
    private String tipoDato;
    private Integer idCatalogo;
    private String comparador;
//    private List<ElementoCatalogoModel> catalogo;
    private List<ValorListaModel> valoresLista;
    private String valor;
    private Integer idValor;
    private Date fecha;
            
    public FiltroBusquedaModel() {
        // required for JAXB
    }
    
    public FiltroBusquedaModel(Integer id, String campo, String descripcion, String tipoControl, String tipoDato, 
            Integer idCatalogo, String comparador) {
        this.id = id;
        this.campo = campo;
        this.descripcion = descripcion;
        this.tipoControl = tipoControl;
        this.tipoDato = tipoDato;
        this.idCatalogo = idCatalogo;
        this.comparador = comparador;
    }

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
     * @return the valoresLista
     */
    public List<ValorListaModel> getValoresLista() {
        return valoresLista;
    }

    /**
     * @param valoresLista the valoresLista to set
     */
    public void setValoresLista(List<ValorListaModel> valoresLista) {
        this.valoresLista = valoresLista;
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

}
