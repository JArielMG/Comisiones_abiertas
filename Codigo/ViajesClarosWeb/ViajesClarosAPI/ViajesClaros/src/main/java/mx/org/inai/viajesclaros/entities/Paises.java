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
@Table(name = "paises")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Paises.findAll", query = "SELECT p FROM Paises p"),
    @NamedQuery(name = "Paises.findByIdPais", query = "SELECT p FROM Paises p WHERE p.idPais = :idPais"),
    @NamedQuery(name = "Paises.findByClavePais", query = "SELECT p FROM Paises p WHERE p.clavePais = :clavePais"),
    @NamedQuery(name = "Paises.findByNombrePais", query = "SELECT p FROM Paises p WHERE p.nombrePais = :nombrePais"),
    @NamedQuery(name = "Paises.findByPredeterminado", query = "SELECT p FROM Paises p WHERE p.predeterminado = :predeterminado")})
public class Paises implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_pais")
    private Integer idPais;
    @Basic(optional = false)
    @Column(name = "clave_pais")
    private String clavePais;
    @Basic(optional = false)
    @Column(name = "nombre_pais")
    private String nombrePais;
    @Basic(optional = false)
    @Column(name = "predeterminado")
    private boolean predeterminado;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPais")
    private Collection<Estados> estadosCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPais")
    private Collection<Ciudades> ciudadesCollection;

    public Paises() {
    }

    public Paises(Integer idPais) {
        this.idPais = idPais;
    }

    public Paises(Integer idPais, String clavePais, String nombrePais, boolean predeterminado) {
        this.idPais = idPais;
        this.clavePais = clavePais;
        this.nombrePais = nombrePais;
        this.predeterminado = predeterminado;
    }

    public Integer getIdPais() {
        return idPais;
    }

    public void setIdPais(Integer idPais) {
        this.idPais = idPais;
    }

    public String getClavePais() {
        return clavePais;
    }

    public void setClavePais(String clavePais) {
        this.clavePais = clavePais;
    }

    public String getNombrePais() {
        return nombrePais;
    }

    public void setNombrePais(String nombrePais) {
        this.nombrePais = nombrePais;
    }

    public boolean getPredeterminado() {
        return predeterminado;
    }

    public void setPredeterminado(boolean predeterminado) {
        this.predeterminado = predeterminado;
    }

    @XmlTransient
    public Collection<Estados> getEstadosCollection() {
        return estadosCollection;
    }

    public void setEstadosCollection(Collection<Estados> estadosCollection) {
        this.estadosCollection = estadosCollection;
    }

    @XmlTransient
    public Collection<Ciudades> getCiudadesCollection() {
        return ciudadesCollection;
    }

    public void setCiudadesCollection(Collection<Ciudades> ciudadesCollection) {
        this.ciudadesCollection = ciudadesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPais != null ? idPais.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Paises)) {
            return false;
        }
        Paises other = (Paises) object;
        if ((this.idPais == null && other.idPais != null) || (this.idPais != null && !this.idPais.equals(other.idPais))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Paises[ idPais=" + idPais + " ]";
    }
    
}
