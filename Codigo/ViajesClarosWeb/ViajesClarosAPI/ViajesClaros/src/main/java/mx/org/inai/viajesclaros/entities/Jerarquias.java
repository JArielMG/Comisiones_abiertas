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
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "jerarquias")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Jerarquias.findAll", query = "SELECT j FROM Jerarquias j"),
    @NamedQuery(name = "Jerarquias.findByIdJerarquia", query = "SELECT j FROM Jerarquias j WHERE j.idJerarquia = :idJerarquia"),
    @NamedQuery(name = "Jerarquias.findByNombreJerarquia", query = "SELECT j FROM Jerarquias j WHERE j.nombreJerarquia = :nombreJerarquia"),
    @NamedQuery(name = "Jerarquias.findByEditable", query = "SELECT j FROM Jerarquias j WHERE j.editable = :editable")})
public class Jerarquias implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_jerarquia")
    private Integer idJerarquia;
    @Column(name = "nombre_jerarquia")
    private String nombreJerarquia;
    @Column(name = "editable")
    private Boolean editable;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idJerarquia")
    private Collection<JerarquiaMiembros> jerarquiaMiembrosCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idJerarquia")
    private Collection<ConfiguracionAprobacion> configuracionAprobacionCollection;

    public Jerarquias() {
    }

    public Jerarquias(Integer idJerarquia) {
        this.idJerarquia = idJerarquia;
    }

    public Integer getIdJerarquia() {
        return idJerarquia;
    }

    public void setIdJerarquia(Integer idJerarquia) {
        this.idJerarquia = idJerarquia;
    }

    public String getNombreJerarquia() {
        return nombreJerarquia;
    }

    public void setNombreJerarquia(String nombreJerarquia) {
        this.nombreJerarquia = nombreJerarquia;
    }

    public Boolean getEditable() {
        return editable;
    }

    public void setEditable(Boolean editable) {
        this.editable = editable;
    }

    @XmlTransient
    public Collection<JerarquiaMiembros> getJerarquiaMiembrosCollection() {
        return jerarquiaMiembrosCollection;
    }

    public void setJerarquiaMiembrosCollection(Collection<JerarquiaMiembros> jerarquiaMiembrosCollection) {
        this.jerarquiaMiembrosCollection = jerarquiaMiembrosCollection;
    }

    @XmlTransient
    public Collection<ConfiguracionAprobacion> getConfiguracionAprobacionCollection() {
        return configuracionAprobacionCollection;
    }

    public void setConfiguracionAprobacionCollection(Collection<ConfiguracionAprobacion> configuracionAprobacionCollection) {
        this.configuracionAprobacionCollection = configuracionAprobacionCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idJerarquia != null ? idJerarquia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Jerarquias)) {
            return false;
        }
        Jerarquias other = (Jerarquias) object;
        if ((this.idJerarquia == null && other.idJerarquia != null) || (this.idJerarquia != null && !this.idJerarquia.equals(other.idJerarquia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Jerarquias[ idJerarquia=" + idJerarquia + " ]";
    }
    
}
