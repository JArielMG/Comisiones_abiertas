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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "registros_gastos_comision")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RegistrosGastosComision.findAll", query = "SELECT r FROM RegistrosGastosComision r"),
    @NamedQuery(name = "RegistrosGastosComision.findByIdRegistroGastoComision", query = "SELECT r FROM RegistrosGastosComision r WHERE r.idRegistroGastoComision = :idRegistroGastoComision")})
public class RegistrosGastosComision implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_registro_gasto_comision")
    private Integer idRegistroGastoComision;
    @JoinColumn(name = "id_comision", referencedColumnName = "id_comision")
    @ManyToOne
    private Comisiones idComision;
    @OneToMany(mappedBy = "idRegistroGastoComision")
    private Collection<ComisionesDesgloseGastos> comisionesDesgloseGastosCollection;

    public RegistrosGastosComision() {
    }

    public RegistrosGastosComision(Integer idRegistroGastoComision) {
        this.idRegistroGastoComision = idRegistroGastoComision;
    }

    public Integer getIdRegistroGastoComision() {
        return idRegistroGastoComision;
    }

    public void setIdRegistroGastoComision(Integer idRegistroGastoComision) {
        this.idRegistroGastoComision = idRegistroGastoComision;
    }

    public Comisiones getIdComision() {
        return idComision;
    }

    public void setIdComision(Comisiones idComision) {
        this.idComision = idComision;
    }

    @XmlTransient
    public Collection<ComisionesDesgloseGastos> getComisionesDesgloseGastosCollection() {
        return comisionesDesgloseGastosCollection;
    }

    public void setComisionesDesgloseGastosCollection(Collection<ComisionesDesgloseGastos> comisionesDesgloseGastosCollection) {
        this.comisionesDesgloseGastosCollection = comisionesDesgloseGastosCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRegistroGastoComision != null ? idRegistroGastoComision.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RegistrosGastosComision)) {
            return false;
        }
        RegistrosGastosComision other = (RegistrosGastosComision) object;
        if ((this.idRegistroGastoComision == null && other.idRegistroGastoComision != null) || (this.idRegistroGastoComision != null && !this.idRegistroGastoComision.equals(other.idRegistroGastoComision))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.RegistrosGastosComision[ idRegistroGastoComision=" + idRegistroGastoComision + " ]";
    }
    
}
