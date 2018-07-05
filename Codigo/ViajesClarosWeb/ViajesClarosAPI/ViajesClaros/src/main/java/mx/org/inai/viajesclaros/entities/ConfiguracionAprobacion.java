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
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "configuracion_aprobacion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ConfiguracionAprobacion.findAll", query = "SELECT c FROM ConfiguracionAprobacion c"),
    @NamedQuery(name = "ConfiguracionAprobacion.findByIdConfAprobacion", query = "SELECT c FROM ConfiguracionAprobacion c WHERE c.idConfAprobacion = :idConfAprobacion"),
    @NamedQuery(name = "ConfiguracionAprobacion.findByNombre", query = "SELECT c FROM ConfiguracionAprobacion c WHERE c.nombre = :nombre"),
    @NamedQuery(name = "ConfiguracionAprobacion.findByEditable", query = "SELECT c FROM ConfiguracionAprobacion c WHERE c.editable = :editable")})
public class ConfiguracionAprobacion implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_conf_aprobacion")
    private Integer idConfAprobacion;
    @Basic(optional = false)
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "editable")
    private Boolean editable;
    @JoinColumn(name = "id_jerarquia", referencedColumnName = "id_jerarquia")
    @ManyToOne(optional = false)
    private Jerarquias idJerarquia;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")
    @ManyToOne(optional = false)
    private Dependencias idDependencia;
    @JoinColumn(name = "id_area", referencedColumnName = "id_area")
    @ManyToOne
    private Areas idArea;
    @JoinColumn(name = "id_flujo", referencedColumnName = "id_flujo")
    @ManyToOne(optional = false)
    private FlujosTrabajo idFlujo;

    public ConfiguracionAprobacion() {
    }

    public ConfiguracionAprobacion(Integer idConfAprobacion) {
        this.idConfAprobacion = idConfAprobacion;
    }

    public ConfiguracionAprobacion(Integer idConfAprobacion, String nombre) {
        this.idConfAprobacion = idConfAprobacion;
        this.nombre = nombre;
    }

    public Integer getIdConfAprobacion() {
        return idConfAprobacion;
    }

    public void setIdConfAprobacion(Integer idConfAprobacion) {
        this.idConfAprobacion = idConfAprobacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Boolean getEditable() {
        return editable;
    }

    public void setEditable(Boolean editable) {
        this.editable = editable;
    }

    public Jerarquias getIdJerarquia() {
        return idJerarquia;
    }

    public void setIdJerarquia(Jerarquias idJerarquia) {
        this.idJerarquia = idJerarquia;
    }

    public Dependencias getIdDependencia() {
        return idDependencia;
    }

    public void setIdDependencia(Dependencias idDependencia) {
        this.idDependencia = idDependencia;
    }

    public Areas getIdArea() {
        return idArea;
    }

    public void setIdArea(Areas idArea) {
        this.idArea = idArea;
    }

    public FlujosTrabajo getIdFlujo() {
        return idFlujo;
    }

    public void setIdFlujo(FlujosTrabajo idFlujo) {
        this.idFlujo = idFlujo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idConfAprobacion != null ? idConfAprobacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ConfiguracionAprobacion)) {
            return false;
        }
        ConfiguracionAprobacion other = (ConfiguracionAprobacion) object;
        if ((this.idConfAprobacion == null && other.idConfAprobacion != null) || (this.idConfAprobacion != null && !this.idConfAprobacion.equals(other.idConfAprobacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ConfiguracionAprobacion[ idConfAprobacion=" + idConfAprobacion + " ]";
    }
    
}
