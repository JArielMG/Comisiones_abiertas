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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
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
@Table(name = "dependencias")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Dependencias.findAll", query = "SELECT d FROM Dependencias d"),
    @NamedQuery(name = "Dependencias.findByIdDependencia", query = "SELECT d FROM Dependencias d WHERE d.idDependencia = :idDependencia"),
    @NamedQuery(name = "Dependencias.findBySiglas", query = "SELECT d FROM Dependencias d WHERE d.siglas = :siglas"),
    @NamedQuery(name = "Dependencias.findByNombreDependencia", query = "SELECT d FROM Dependencias d WHERE d.nombreDependencia = :nombreDependencia"),
    @NamedQuery(name = "Dependencias.findByPredeterminada", query = "SELECT d FROM Dependencias d WHERE d.predeterminada = :predeterminada")})
public class Dependencias implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_dependencia")
    private Integer idDependencia;
    @Column(name = "siglas")
    private String siglas;
    @Column(name = "nombre_dependencia")
    private String nombreDependencia;
    @Column(name = "predeterminada")
    private Boolean predeterminada;
    @ManyToMany(mappedBy = "dependenciasCollection")
    private Collection<CamposDinamicos> camposDinamicosCollection;
    @JoinTable(name = "graficas_config", joinColumns = {
        @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")}, inverseJoinColumns = {
        @JoinColumn(name = "id_grafica", referencedColumnName = "id_grafica")})
    @ManyToMany
    private Collection<Graficas> graficasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDependencia")
    private Collection<Comisiones> comisionesCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dependencias")
    private Collection<BuscadorDespliegueConfig> buscadorDespliegueConfigCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDependencia")
    private Collection<ViajesClarosInstancias> viajesClarosInstanciasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dependencias")
    private Collection<BuscadorFiltrosConfig> buscadorFiltrosConfigCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDependencia")
    private Collection<ConfiguracionAprobacion> configuracionAprobacionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dependencias")
    private Collection<InterfazConfig> interfazConfigCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDependencia")
    private Collection<Areas> areasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDependencia")
    private Collection<Usuarios> usuariosCollection;

    public Dependencias() {
    }

    public Dependencias(Integer idDependencia) {
        this.idDependencia = idDependencia;
    }

    public Integer getIdDependencia() {
        return idDependencia;
    }

    public void setIdDependencia(Integer idDependencia) {
        this.idDependencia = idDependencia;
    }

    public String getSiglas() {
        return siglas;
    }

    public void setSiglas(String siglas) {
        this.siglas = siglas;
    }

    public String getNombreDependencia() {
        return nombreDependencia;
    }

    public void setNombreDependencia(String nombreDependencia) {
        this.nombreDependencia = nombreDependencia;
    }

    public Boolean getPredeterminada() {
        return predeterminada;
    }

    public void setPredeterminada(Boolean predeterminada) {
        this.predeterminada = predeterminada;
    }

    @XmlTransient
    public Collection<CamposDinamicos> getCamposDinamicosCollection() {
        return camposDinamicosCollection;
    }

    public void setCamposDinamicosCollection(Collection<CamposDinamicos> camposDinamicosCollection) {
        this.camposDinamicosCollection = camposDinamicosCollection;
    }

    @XmlTransient
    public Collection<Graficas> getGraficasCollection() {
        return graficasCollection;
    }

    public void setGraficasCollection(Collection<Graficas> graficasCollection) {
        this.graficasCollection = graficasCollection;
    }

    @XmlTransient
    public Collection<Comisiones> getComisionesCollection() {
        return comisionesCollection;
    }

    public void setComisionesCollection(Collection<Comisiones> comisionesCollection) {
        this.comisionesCollection = comisionesCollection;
    }

    @XmlTransient
    public Collection<BuscadorDespliegueConfig> getBuscadorDespliegueConfigCollection() {
        return buscadorDespliegueConfigCollection;
    }

    public void setBuscadorDespliegueConfigCollection(Collection<BuscadorDespliegueConfig> buscadorDespliegueConfigCollection) {
        this.buscadorDespliegueConfigCollection = buscadorDespliegueConfigCollection;
    }

    @XmlTransient
    public Collection<ViajesClarosInstancias> getViajesClarosInstanciasCollection() {
        return viajesClarosInstanciasCollection;
    }

    public void setViajesClarosInstanciasCollection(Collection<ViajesClarosInstancias> viajesClarosInstanciasCollection) {
        this.viajesClarosInstanciasCollection = viajesClarosInstanciasCollection;
    }

    @XmlTransient
    public Collection<BuscadorFiltrosConfig> getBuscadorFiltrosConfigCollection() {
        return buscadorFiltrosConfigCollection;
    }

    public void setBuscadorFiltrosConfigCollection(Collection<BuscadorFiltrosConfig> buscadorFiltrosConfigCollection) {
        this.buscadorFiltrosConfigCollection = buscadorFiltrosConfigCollection;
    }

    @XmlTransient
    public Collection<ConfiguracionAprobacion> getConfiguracionAprobacionCollection() {
        return configuracionAprobacionCollection;
    }

    public void setConfiguracionAprobacionCollection(Collection<ConfiguracionAprobacion> configuracionAprobacionCollection) {
        this.configuracionAprobacionCollection = configuracionAprobacionCollection;
    }

    @XmlTransient
    public Collection<InterfazConfig> getInterfazConfigCollection() {
        return interfazConfigCollection;
    }

    public void setInterfazConfigCollection(Collection<InterfazConfig> interfazConfigCollection) {
        this.interfazConfigCollection = interfazConfigCollection;
    }

    @XmlTransient
    public Collection<Areas> getAreasCollection() {
        return areasCollection;
    }

    public void setAreasCollection(Collection<Areas> areasCollection) {
        this.areasCollection = areasCollection;
    }

    @XmlTransient
    public Collection<Usuarios> getUsuariosCollection() {
        return usuariosCollection;
    }

    public void setUsuariosCollection(Collection<Usuarios> usuariosCollection) {
        this.usuariosCollection = usuariosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDependencia != null ? idDependencia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dependencias)) {
            return false;
        }
        Dependencias other = (Dependencias) object;
        if ((this.idDependencia == null && other.idDependencia != null) || (this.idDependencia != null && !this.idDependencia.equals(other.idDependencia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Dependencias[ idDependencia=" + idDependencia + " ]";
    }
    
}
