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
@Table(name = "flujos_trabajo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FlujosTrabajo.findAll", query = "SELECT f FROM FlujosTrabajo f"),
    @NamedQuery(name = "FlujosTrabajo.findByIdFlujo", query = "SELECT f FROM FlujosTrabajo f WHERE f.idFlujo = :idFlujo"),
    @NamedQuery(name = "FlujosTrabajo.findByNombreFlujo", query = "SELECT f FROM FlujosTrabajo f WHERE f.nombreFlujo = :nombreFlujo"),
    @NamedQuery(name = "FlujosTrabajo.findByDescripcion", query = "SELECT f FROM FlujosTrabajo f WHERE f.descripcion = :descripcion"),
    @NamedQuery(name = "FlujosTrabajo.findByVersion", query = "SELECT f FROM FlujosTrabajo f WHERE f.version = :version")})
public class FlujosTrabajo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_flujo")
    private Integer idFlujo;
    @Column(name = "nombre_flujo")
    private String nombreFlujo;
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @Column(name = "version")
    private String version;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "flujosTrabajo")
    private Collection<FlujosInstancias> flujosInstanciasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "flujosTrabajo")
    private Collection<FlujosCamposConfig> flujosCamposConfigCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idFlujo")
    private Collection<SeccionesFormulario> seccionesFormularioCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idFlujo")
    private Collection<ConfiguracionAprobacion> configuracionAprobacionCollection;

    public FlujosTrabajo() {
    }

    public FlujosTrabajo(Integer idFlujo) {
        this.idFlujo = idFlujo;
    }

    public FlujosTrabajo(Integer idFlujo, String version) {
        this.idFlujo = idFlujo;
        this.version = version;
    }

    public Integer getIdFlujo() {
        return idFlujo;
    }

    public void setIdFlujo(Integer idFlujo) {
        this.idFlujo = idFlujo;
    }

    public String getNombreFlujo() {
        return nombreFlujo;
    }

    public void setNombreFlujo(String nombreFlujo) {
        this.nombreFlujo = nombreFlujo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    @XmlTransient
    public Collection<FlujosInstancias> getFlujosInstanciasCollection() {
        return flujosInstanciasCollection;
    }

    public void setFlujosInstanciasCollection(Collection<FlujosInstancias> flujosInstanciasCollection) {
        this.flujosInstanciasCollection = flujosInstanciasCollection;
    }

    @XmlTransient
    public Collection<FlujosCamposConfig> getFlujosCamposConfigCollection() {
        return flujosCamposConfigCollection;
    }

    public void setFlujosCamposConfigCollection(Collection<FlujosCamposConfig> flujosCamposConfigCollection) {
        this.flujosCamposConfigCollection = flujosCamposConfigCollection;
    }

    @XmlTransient
    public Collection<SeccionesFormulario> getSeccionesFormularioCollection() {
        return seccionesFormularioCollection;
    }

    public void setSeccionesFormularioCollection(Collection<SeccionesFormulario> seccionesFormularioCollection) {
        this.seccionesFormularioCollection = seccionesFormularioCollection;
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
        hash += (idFlujo != null ? idFlujo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FlujosTrabajo)) {
            return false;
        }
        FlujosTrabajo other = (FlujosTrabajo) object;
        if ((this.idFlujo == null && other.idFlujo != null) || (this.idFlujo != null && !this.idFlujo.equals(other.idFlujo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.FlujosTrabajo[ idFlujo=" + idFlujo + " ]";
    }
    
}
