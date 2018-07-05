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
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "campos_dinamicos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CamposDinamicos.findAll", query = "SELECT c FROM CamposDinamicos c"),
    @NamedQuery(name = "CamposDinamicos.findByNombreCampo", query = "SELECT c FROM CamposDinamicos c WHERE c.nombreCampo = :nombreCampo"),
    @NamedQuery(name = "CamposDinamicos.findByTipoDato", query = "SELECT c FROM CamposDinamicos c WHERE c.tipoDato = :tipoDato"),
    @NamedQuery(name = "CamposDinamicos.findByDescripcion", query = "SELECT c FROM CamposDinamicos c WHERE c.descripcion = :descripcion"),
    @NamedQuery(name = "CamposDinamicos.findByDespliegue", query = "SELECT c FROM CamposDinamicos c WHERE c.despliegue = :despliegue"),
    @NamedQuery(name = "CamposDinamicos.findByBusquedaDefecto", query = "SELECT c FROM CamposDinamicos c WHERE c.busquedaDefecto = :busquedaDefecto"),
    @NamedQuery(name = "CamposDinamicos.findByTipoControl", query = "SELECT c FROM CamposDinamicos c WHERE c.tipoControl = :tipoControl")})
public class CamposDinamicos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "nombre_campo")
    private String nombreCampo;
    @Column(name = "tipo_dato")
    private Integer tipoDato;
    @Column(name = "descripcion")
    private String descripcion;
    @Column(name = "despliegue")
    private String despliegue;
    @Column(name = "busqueda_defecto")
    private Boolean busquedaDefecto;
    @Column(name = "tipo_control")
    private Integer tipoControl;
    @JoinTable(name = "suscripcion_config", joinColumns = {
        @JoinColumn(name = "campo", referencedColumnName = "nombre_campo")}, inverseJoinColumns = {
        @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")})
    @ManyToMany
    private Collection<Dependencias> dependenciasCollection;
    @JoinColumn(name = "id_lista", referencedColumnName = "id_lista")
    @ManyToOne
    private ListasValores idLista;
    @JoinColumn(name = "categoria", referencedColumnName = "categoria")
    @ManyToOne
    private CategoriaCampo categoria;

    public CamposDinamicos() {
    }

    public CamposDinamicos(String nombreCampo) {
        this.nombreCampo = nombreCampo;
    }

    public String getNombreCampo() {
        return nombreCampo;
    }

    public void setNombreCampo(String nombreCampo) {
        this.nombreCampo = nombreCampo;
    }

    public Integer getTipoDato() {
        return tipoDato;
    }

    public void setTipoDato(Integer tipoDato) {
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

    @XmlTransient
    public Collection<Dependencias> getDependenciasCollection() {
        return dependenciasCollection;
    }

    public void setDependenciasCollection(Collection<Dependencias> dependenciasCollection) {
        this.dependenciasCollection = dependenciasCollection;
    }

    public ListasValores getIdLista() {
        return idLista;
    }

    public void setIdLista(ListasValores idLista) {
        this.idLista = idLista;
    }

    public CategoriaCampo getCategoria() {
        return categoria;
    }

    public void setCategoria(CategoriaCampo categoria) {
        this.categoria = categoria;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nombreCampo != null ? nombreCampo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CamposDinamicos)) {
            return false;
        }
        CamposDinamicos other = (CamposDinamicos) object;
        if ((this.nombreCampo == null && other.nombreCampo != null) || (this.nombreCampo != null && !this.nombreCampo.equals(other.nombreCampo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.CamposDinamicos[ nombreCampo=" + nombreCampo + " ]";
    }
    
}
