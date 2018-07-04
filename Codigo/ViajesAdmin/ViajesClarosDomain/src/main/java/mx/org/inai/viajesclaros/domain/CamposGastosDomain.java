/*
 * Copyright (C) 2016 victor.huerta
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
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author victor.huerta
 */
public class CamposGastosDomain implements java.io.Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Integer idGastoCampoConfig;
    private String tabla;
    private String campo;
    private String etiqueta;
    private Boolean listaHabilitada;
    private Boolean obligatorio;
    private Integer orden;
    private Integer idLista;
    private String tipoControl;
    private String tipoDato;
    private String subtipo;

    /**
     * @return the idGastoCampoConfig
     */
    public Integer getIdGastoCampoConfig() {
        return idGastoCampoConfig;
    }

    /**
     * @param idGastoCampoConfig the idGastoCampoConfig to set
     */
    public void setIdGastoCampoConfig(Integer idGastoCampoConfig) {
        this.idGastoCampoConfig = idGastoCampoConfig;
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
     * @return the etiqueta
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * @param etiqueta the etiqueta to set
     */
    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    /**
     * @return the listaHabilitada
     */
    public Boolean getListaHabilitada() {
        return listaHabilitada;
    }

    /**
     * @param listaHabilitada the listaHabilitada to set
     */
    public void setListaHabilitada(Boolean listaHabilitada) {
        this.listaHabilitada = listaHabilitada;
    }

    /**
     * @return the obligatorio
     */
    public Boolean getObligatorio() {
        return obligatorio;
    }

    /**
     * @param obligatorio the obligatorio to set
     */
    public void setObligatorio(Boolean obligatorio) {
        this.obligatorio = obligatorio;
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
     * @return the orden
     */
    public Integer getOrden() {
        return orden;
    }

    /**
     * @param orden the orden to set
     */
    public void setOrden(Integer orden) {
        this.orden = orden;
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
     * @return the subtipo
     */
    public String getSubtipo() {
        return subtipo;
    }

    /**
     * @param subtipo the subtipo to set
     */
    public void setSubtipo(String subtipo) {
        this.subtipo = subtipo;
    }    
}
