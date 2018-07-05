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
@Table(name = "listas_valores")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ListasValores.findAll", query = "SELECT l FROM ListasValores l"),
    @NamedQuery(name = "ListasValores.findByIdLista", query = "SELECT l FROM ListasValores l WHERE l.idLista = :idLista"),
    @NamedQuery(name = "ListasValores.findByNombreLista", query = "SELECT l FROM ListasValores l WHERE l.nombreLista = :nombreLista"),
    @NamedQuery(name = "ListasValores.findByHabilitada", query = "SELECT l FROM ListasValores l WHERE l.habilitada = :habilitada")})
public class ListasValores implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_lista")
    private Integer idLista;
    @Basic(optional = false)
    @Column(name = "nombre_lista")
    private String nombreLista;
    @Basic(optional = false)
    @Column(name = "habilitada")
    private boolean habilitada;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "listasValores")
    private Collection<ValoresDinamicos> valoresDinamicosCollection;
    @OneToMany(mappedBy = "idLista")
    private Collection<CamposDinamicos> camposDinamicosCollection;

    public ListasValores() {
    }

    public ListasValores(Integer idLista) {
        this.idLista = idLista;
    }

    public ListasValores(Integer idLista, String nombreLista, boolean habilitada) {
        this.idLista = idLista;
        this.nombreLista = nombreLista;
        this.habilitada = habilitada;
    }

    public Integer getIdLista() {
        return idLista;
    }

    public void setIdLista(Integer idLista) {
        this.idLista = idLista;
    }

    public String getNombreLista() {
        return nombreLista;
    }

    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }

    public boolean getHabilitada() {
        return habilitada;
    }

    public void setHabilitada(boolean habilitada) {
        this.habilitada = habilitada;
    }

    @XmlTransient
    public Collection<ValoresDinamicos> getValoresDinamicosCollection() {
        return valoresDinamicosCollection;
    }

    public void setValoresDinamicosCollection(Collection<ValoresDinamicos> valoresDinamicosCollection) {
        this.valoresDinamicosCollection = valoresDinamicosCollection;
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
        hash += (idLista != null ? idLista.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ListasValores)) {
            return false;
        }
        ListasValores other = (ListasValores) object;
        if ((this.idLista == null && other.idLista != null) || (this.idLista != null && !this.idLista.equals(other.idLista))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ListasValores[ idLista=" + idLista + " ]";
    }
    
}
