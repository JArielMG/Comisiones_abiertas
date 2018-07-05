/*
 * Copyright (C) 2016 jmcortes
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
package mx.org.inai.viajesclaros.entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "flujos_campos_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FlujosCamposConfig.findAll", query = "SELECT f FROM FlujosCamposConfig f"),
    @NamedQuery(name = "FlujosCamposConfig.findByIdFlujo", query = "SELECT f FROM FlujosCamposConfig f WHERE f.flujosCamposConfigPK.idFlujo = :idFlujo"),
    @NamedQuery(name = "FlujosCamposConfig.findByTabla", query = "SELECT f FROM FlujosCamposConfig f WHERE f.flujosCamposConfigPK.tabla = :tabla"),
    @NamedQuery(name = "FlujosCamposConfig.findByCampo", query = "SELECT f FROM FlujosCamposConfig f WHERE f.flujosCamposConfigPK.campo = :campo"),
    @NamedQuery(name = "FlujosCamposConfig.findByEtiqueta", query = "SELECT f FROM FlujosCamposConfig f WHERE f.etiqueta = :etiqueta"),
    @NamedQuery(name = "FlujosCamposConfig.findByListaHabilitada", query = "SELECT f FROM FlujosCamposConfig f WHERE f.listaHabilitada = :listaHabilitada"),
    @NamedQuery(name = "FlujosCamposConfig.findByObligatorio", query = "SELECT f FROM FlujosCamposConfig f WHERE f.obligatorio = :obligatorio"),
    @NamedQuery(name = "FlujosCamposConfig.findByIdTipoPersona", query = "SELECT f FROM FlujosCamposConfig f WHERE f.flujosCamposConfigPK.idTipoPersona = :idTipoPersona"),
    @NamedQuery(name = "FlujosCamposConfig.findByOrden", query = "SELECT f FROM FlujosCamposConfig f WHERE f.orden = :orden"),
    @NamedQuery(name = "FlujosCamposConfig.findBySubtipo", query = "SELECT f FROM FlujosCamposConfig f WHERE f.subtipo = :subtipo"),
    @NamedQuery(name = "FlujosCamposConfig.findBySoloLectura", query = "SELECT f FROM FlujosCamposConfig f WHERE f.soloLectura = :soloLectura"),
    @NamedQuery(name = "FlujosCamposConfig.findByClase", query = "SELECT f FROM FlujosCamposConfig f WHERE f.clase = :clase")})
public class FlujosCamposConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected FlujosCamposConfigPK flujosCamposConfigPK;
    @Column(name = "etiqueta")
    private String etiqueta;
    @Column(name = "lista_habilitada")
    private Boolean listaHabilitada;
    @Column(name = "obligatorio")
    private Short obligatorio;
    @Column(name = "orden")
    private Integer orden;
    @Column(name = "subtipo")
    private String subtipo;
    @Column(name = "solo_lectura")
    private Boolean soloLectura;
    @Column(name = "clase")
    private String clase;
    @JoinColumn(name = "id_seccion_formulario", referencedColumnName = "id_seccion")
    @ManyToOne
    private SeccionesFormulario idSeccionFormulario;
    @JoinColumn(name = "id_flujo", referencedColumnName = "id_flujo", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private FlujosTrabajo flujosTrabajo;

    public FlujosCamposConfig() {
    }

    public FlujosCamposConfig(FlujosCamposConfigPK flujosCamposConfigPK) {
        this.flujosCamposConfigPK = flujosCamposConfigPK;
    }

    public FlujosCamposConfig(int idFlujo, String tabla, String campo, int idTipoPersona) {
        this.flujosCamposConfigPK = new FlujosCamposConfigPK(idFlujo, tabla, campo, idTipoPersona);
    }

    public FlujosCamposConfigPK getFlujosCamposConfigPK() {
        return flujosCamposConfigPK;
    }

    public void setFlujosCamposConfigPK(FlujosCamposConfigPK flujosCamposConfigPK) {
        this.flujosCamposConfigPK = flujosCamposConfigPK;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public Boolean getListaHabilitada() {
        return listaHabilitada;
    }

    public void setListaHabilitada(Boolean listaHabilitada) {
        this.listaHabilitada = listaHabilitada;
    }

    public Short getObligatorio() {
        return obligatorio;
    }

    public void setObligatorio(Short obligatorio) {
        this.obligatorio = obligatorio;
    }

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    public String getSubtipo() {
        return subtipo;
    }

    public void setSubtipo(String subtipo) {
        this.subtipo = subtipo;
    }

    public Boolean getSoloLectura() {
        return soloLectura;
    }

    public void setSoloLectura(Boolean soloLectura) {
        this.soloLectura = soloLectura;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public SeccionesFormulario getIdSeccionFormulario() {
        return idSeccionFormulario;
    }

    public void setIdSeccionFormulario(SeccionesFormulario idSeccionFormulario) {
        this.idSeccionFormulario = idSeccionFormulario;
    }

    public FlujosTrabajo getFlujosTrabajo() {
        return flujosTrabajo;
    }

    public void setFlujosTrabajo(FlujosTrabajo flujosTrabajo) {
        this.flujosTrabajo = flujosTrabajo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (flujosCamposConfigPK != null ? flujosCamposConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FlujosCamposConfig)) {
            return false;
        }
        FlujosCamposConfig other = (FlujosCamposConfig) object;
        if ((this.flujosCamposConfigPK == null && other.flujosCamposConfigPK != null) || (this.flujosCamposConfigPK != null && !this.flujosCamposConfigPK.equals(other.flujosCamposConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.FlujosCamposConfig[ flujosCamposConfigPK=" + flujosCamposConfigPK + " ]";
    }
    
}
