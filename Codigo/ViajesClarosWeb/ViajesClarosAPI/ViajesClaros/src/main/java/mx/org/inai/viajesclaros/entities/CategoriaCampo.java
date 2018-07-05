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
@Table(name = "categoria_campo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CategoriaCampo.findAll", query = "SELECT c FROM CategoriaCampo c"),
    @NamedQuery(name = "CategoriaCampo.findByCategoria", query = "SELECT c FROM CategoriaCampo c WHERE c.categoria = :categoria"),
    @NamedQuery(name = "CategoriaCampo.findByDescripcion", query = "SELECT c FROM CategoriaCampo c WHERE c.descripcion = :descripcion")})
public class CategoriaCampo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "categoria")
    private String categoria;
    @Basic(optional = false)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(mappedBy = "categoria")
    private Collection<CamposDinamicos> camposDinamicosCollection;

    public CategoriaCampo() {
    }

    public CategoriaCampo(String categoria) {
        this.categoria = categoria;
    }

    public CategoriaCampo(String categoria, String descripcion) {
        this.categoria = categoria;
        this.descripcion = descripcion;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public Collection<CamposDinamicos> getCamposDinamicosCollection() {
        return camposDinamicosCollection;
    }

    public void setCamposDinamicosCollection(Collection<CamposDinamicos> camposDinamicosCollection) {
        this.camposDinamicosCollection = camposDinamicosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (categoria != null ? categoria.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CategoriaCampo)) {
            return false;
        }
        CategoriaCampo other = (CategoriaCampo) object;
        if ((this.categoria == null && other.categoria != null) || (this.categoria != null && !this.categoria.equals(other.categoria))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.CategoriaCampo[ categoria=" + categoria + " ]";
    }
    
}
