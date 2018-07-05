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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "gastos_campos_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "GastosCamposConfig.findAll", query = "SELECT g FROM GastosCamposConfig g"),
    @NamedQuery(name = "GastosCamposConfig.findByIdGastoCampoConfig", query = "SELECT g FROM GastosCamposConfig g WHERE g.gastosCamposConfigPK.idGastoCampoConfig = :idGastoCampoConfig"),
    @NamedQuery(name = "GastosCamposConfig.findByTabla", query = "SELECT g FROM GastosCamposConfig g WHERE g.gastosCamposConfigPK.tabla = :tabla"),
    @NamedQuery(name = "GastosCamposConfig.findByCampo", query = "SELECT g FROM GastosCamposConfig g WHERE g.gastosCamposConfigPK.campo = :campo"),
    @NamedQuery(name = "GastosCamposConfig.findByEtiqueta", query = "SELECT g FROM GastosCamposConfig g WHERE g.etiqueta = :etiqueta"),
    @NamedQuery(name = "GastosCamposConfig.findByListaHabilitada", query = "SELECT g FROM GastosCamposConfig g WHERE g.listaHabilitada = :listaHabilitada"),
    @NamedQuery(name = "GastosCamposConfig.findByObligatorio", query = "SELECT g FROM GastosCamposConfig g WHERE g.obligatorio = :obligatorio"),
    @NamedQuery(name = "GastosCamposConfig.findByOrden", query = "SELECT g FROM GastosCamposConfig g WHERE g.orden = :orden"),
    @NamedQuery(name = "GastosCamposConfig.findBySubtipo", query = "SELECT g FROM GastosCamposConfig g WHERE g.subtipo = :subtipo")})
public class GastosCamposConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected GastosCamposConfigPK gastosCamposConfigPK;
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

    public GastosCamposConfig() {
    }

    public GastosCamposConfig(GastosCamposConfigPK gastosCamposConfigPK) {
        this.gastosCamposConfigPK = gastosCamposConfigPK;
    }

    public GastosCamposConfig(int idGastoCampoConfig, String tabla, String campo) {
        this.gastosCamposConfigPK = new GastosCamposConfigPK(idGastoCampoConfig, tabla, campo);
    }

    public GastosCamposConfigPK getGastosCamposConfigPK() {
        return gastosCamposConfigPK;
    }

    public void setGastosCamposConfigPK(GastosCamposConfigPK gastosCamposConfigPK) {
        this.gastosCamposConfigPK = gastosCamposConfigPK;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (gastosCamposConfigPK != null ? gastosCamposConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof GastosCamposConfig)) {
            return false;
        }
        GastosCamposConfig other = (GastosCamposConfig) object;
        if ((this.gastosCamposConfigPK == null && other.gastosCamposConfigPK != null) || (this.gastosCamposConfigPK != null && !this.gastosCamposConfigPK.equals(other.gastosCamposConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.GastosCamposConfig[ gastosCamposConfigPK=" + gastosCamposConfigPK + " ]";
    }
    
}
