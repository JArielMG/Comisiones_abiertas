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
import javax.persistence.ManyToMany;
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
@Table(name = "graficas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Graficas.findAll", query = "SELECT g FROM Graficas g"),
    @NamedQuery(name = "Graficas.findByGrafica", query = "SELECT g FROM Graficas g WHERE g.grafica = :grafica"),
    @NamedQuery(name = "Graficas.findByDescripcion", query = "SELECT g FROM Graficas g WHERE g.descripcion = :descripcion"),
    @NamedQuery(name = "Graficas.findByIdGrafica", query = "SELECT g FROM Graficas g WHERE g.idGrafica = :idGrafica")})
public class Graficas implements Serializable {
    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @Column(name = "grafica")
    private String grafica;
    @Basic(optional = false)
    @Column(name = "descripcion")
    private String descripcion;
    @Id
    @Basic(optional = false)
    @Column(name = "id_grafica")
    private Integer idGrafica;
    @ManyToMany(mappedBy = "graficasCollection")
    private Collection<Dependencias> dependenciasCollection;

    public Graficas() {
    }

    public Graficas(Integer idGrafica) {
        this.idGrafica = idGrafica;
    }

    public Graficas(Integer idGrafica, String grafica, String descripcion) {
        this.idGrafica = idGrafica;
        this.grafica = grafica;
        this.descripcion = descripcion;
    }

    public String getGrafica() {
        return grafica;
    }

    public void setGrafica(String grafica) {
        this.grafica = grafica;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getIdGrafica() {
        return idGrafica;
    }

    public void setIdGrafica(Integer idGrafica) {
        this.idGrafica = idGrafica;
    }

    @XmlTransient
    public Collection<Dependencias> getDependenciasCollection() {
        return dependenciasCollection;
    }

    public void setDependenciasCollection(Collection<Dependencias> dependenciasCollection) {
        this.dependenciasCollection = dependenciasCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idGrafica != null ? idGrafica.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Graficas)) {
            return false;
        }
        Graficas other = (Graficas) object;
        if ((this.idGrafica == null && other.idGrafica != null) || (this.idGrafica != null && !this.idGrafica.equals(other.idGrafica))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Graficas[ idGrafica=" + idGrafica + " ]";
    }
    
}
