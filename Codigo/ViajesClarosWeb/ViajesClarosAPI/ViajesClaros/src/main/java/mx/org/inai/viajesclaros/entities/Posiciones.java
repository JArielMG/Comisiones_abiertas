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
@Table(name = "posiciones")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Posiciones.findAll", query = "SELECT p FROM Posiciones p"),
    @NamedQuery(name = "Posiciones.findByIdPosicion", query = "SELECT p FROM Posiciones p WHERE p.idPosicion = :idPosicion"),
    @NamedQuery(name = "Posiciones.findByNombrePosicion", query = "SELECT p FROM Posiciones p WHERE p.nombrePosicion = :nombrePosicion")})
public class Posiciones implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_posicion")
    private Integer idPosicion;
    @Basic(optional = false)
    @Column(name = "nombre_posicion")
    private String nombrePosicion;
    @OneToMany(mappedBy = "idPosicion")
    private Collection<Personas> personasCollection;

    public Posiciones() {
    }

    public Posiciones(Integer idPosicion) {
        this.idPosicion = idPosicion;
    }

    public Posiciones(Integer idPosicion, String nombrePosicion) {
        this.idPosicion = idPosicion;
        this.nombrePosicion = nombrePosicion;
    }

    public Integer getIdPosicion() {
        return idPosicion;
    }

    public void setIdPosicion(Integer idPosicion) {
        this.idPosicion = idPosicion;
    }

    public String getNombrePosicion() {
        return nombrePosicion;
    }

    public void setNombrePosicion(String nombrePosicion) {
        this.nombrePosicion = nombrePosicion;
    }

    @XmlTransient
    public Collection<Personas> getPersonasCollection() {
        return personasCollection;
    }

    public void setPersonasCollection(Collection<Personas> personasCollection) {
        this.personasCollection = personasCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPosicion != null ? idPosicion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Posiciones)) {
            return false;
        }
        Posiciones other = (Posiciones) object;
        if ((this.idPosicion == null && other.idPosicion != null) || (this.idPosicion != null && !this.idPosicion.equals(other.idPosicion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Posiciones[ idPosicion=" + idPosicion + " ]";
    }
    
}
