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
import javax.persistence.Basic;
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
@Table(name = "campos_base")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CamposBase.findAll", query = "SELECT c FROM CamposBase c"),
    @NamedQuery(name = "CamposBase.findByTabla", query = "SELECT c FROM CamposBase c WHERE c.camposBasePK.tabla = :tabla"),
    @NamedQuery(name = "CamposBase.findByCampo", query = "SELECT c FROM CamposBase c WHERE c.camposBasePK.campo = :campo"),
    @NamedQuery(name = "CamposBase.findByTipoDato", query = "SELECT c FROM CamposBase c WHERE c.tipoDato = :tipoDato"),
    @NamedQuery(name = "CamposBase.findByDescripcion", query = "SELECT c FROM CamposBase c WHERE c.descripcion = :descripcion"),
    @NamedQuery(name = "CamposBase.findByDespliegue", query = "SELECT c FROM CamposBase c WHERE c.despliegue = :despliegue"),
    @NamedQuery(name = "CamposBase.findByBusquedaDefecto", query = "SELECT c FROM CamposBase c WHERE c.busquedaDefecto = :busquedaDefecto"),
    @NamedQuery(name = "CamposBase.findByTipoControl", query = "SELECT c FROM CamposBase c WHERE c.tipoControl = :tipoControl"),
    @NamedQuery(name = "CamposBase.findByCategoria", query = "SELECT c FROM CamposBase c WHERE c.categoria = :categoria")})
public class CamposBase implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected CamposBasePK camposBasePK;
    @Basic(optional = false)
    @Column(name = "tipo_dato")
    private int tipoDato;
    @Column(name = "descripcion")
    private String descripcion;
    @Column(name = "despliegue")
    private String despliegue;
    @Column(name = "busqueda_defecto")
    private Boolean busquedaDefecto;
    @Column(name = "tipo_control")
    private Integer tipoControl;
    @Column(name = "categoria")
    private String categoria;

    public CamposBase() {
    }

    public CamposBase(CamposBasePK camposBasePK) {
        this.camposBasePK = camposBasePK;
    }

    public CamposBase(CamposBasePK camposBasePK, int tipoDato) {
        this.camposBasePK = camposBasePK;
        this.tipoDato = tipoDato;
    }

    public CamposBase(String tabla, String campo) {
        this.camposBasePK = new CamposBasePK(tabla, campo);
    }

    public CamposBasePK getCamposBasePK() {
        return camposBasePK;
    }

    public void setCamposBasePK(CamposBasePK camposBasePK) {
        this.camposBasePK = camposBasePK;
    }

    public int getTipoDato() {
        return tipoDato;
    }

    public void setTipoDato(int tipoDato) {
        this.tipoDato = tipoDato;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDespliegue() {
        return despliegue;
    }

    public void setDespliegue(String despliegue) {
        this.despliegue = despliegue;
    }

    public Boolean getBusquedaDefecto() {
        return busquedaDefecto;
    }

    public void setBusquedaDefecto(Boolean busquedaDefecto) {
        this.busquedaDefecto = busquedaDefecto;
    }

    public Integer getTipoControl() {
        return tipoControl;
    }

    public void setTipoControl(Integer tipoControl) {
        this.tipoControl = tipoControl;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (camposBasePK != null ? camposBasePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CamposBase)) {
            return false;
        }
        CamposBase other = (CamposBase) object;
        if ((this.camposBasePK == null && other.camposBasePK != null) || (this.camposBasePK != null && !this.camposBasePK.equals(other.camposBasePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.CamposBase[ camposBasePK=" + camposBasePK + " ]";
    }
    
}
