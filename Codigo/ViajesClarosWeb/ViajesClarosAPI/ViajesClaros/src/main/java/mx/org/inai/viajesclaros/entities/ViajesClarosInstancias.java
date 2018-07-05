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
import java.math.BigInteger;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "viajes_claros_instancias")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ViajesClarosInstancias.findAll", query = "SELECT v FROM ViajesClarosInstancias v"),
    @NamedQuery(name = "ViajesClarosInstancias.findByIdViaje", query = "SELECT v FROM ViajesClarosInstancias v WHERE v.idViaje = :idViaje"),
    @NamedQuery(name = "ViajesClarosInstancias.findByFechaPublicacion", query = "SELECT v FROM ViajesClarosInstancias v WHERE v.fechaPublicacion = :fechaPublicacion"),
    @NamedQuery(name = "ViajesClarosInstancias.findByIdArchivo", query = "SELECT v FROM ViajesClarosInstancias v WHERE v.idArchivo = :idArchivo")})
public class ViajesClarosInstancias implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_viaje")
    private Integer idViaje;
    @Column(name = "fecha_publicacion")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaPublicacion;
    @Column(name = "id_archivo")
    private BigInteger idArchivo;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")
    @ManyToOne(optional = false)
    private Dependencias idDependencia;
    @JoinColumn(name = "id_comision", referencedColumnName = "id_comision")
    @ManyToOne
    private Comisiones idComision;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "viajesClarosInstancias")
    private Collection<ViajesClarosDetalle> viajesClarosDetalleCollection;

    public ViajesClarosInstancias() {
    }

    public ViajesClarosInstancias(Integer idViaje) {
        this.idViaje = idViaje;
    }

    public Integer getIdViaje() {
        return idViaje;
    }

    public void setIdViaje(Integer idViaje) {
        this.idViaje = idViaje;
    }

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public BigInteger getIdArchivo() {
        return idArchivo;
    }

    public void setIdArchivo(BigInteger idArchivo) {
        this.idArchivo = idArchivo;
    }

    public Dependencias getIdDependencia() {
        return idDependencia;
    }

    public void setIdDependencia(Dependencias idDependencia) {
        this.idDependencia = idDependencia;
    }

    public Comisiones getIdComision() {
        return idComision;
    }

    public void setIdComision(Comisiones idComision) {
        this.idComision = idComision;
    }

    @XmlTransient
    public Collection<ViajesClarosDetalle> getViajesClarosDetalleCollection() {
        return viajesClarosDetalleCollection;
    }

    public void setViajesClarosDetalleCollection(Collection<ViajesClarosDetalle> viajesClarosDetalleCollection) {
        this.viajesClarosDetalleCollection = viajesClarosDetalleCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idViaje != null ? idViaje.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ViajesClarosInstancias)) {
            return false;
        }
        ViajesClarosInstancias other = (ViajesClarosInstancias) object;
        if ((this.idViaje == null && other.idViaje != null) || (this.idViaje != null && !this.idViaje.equals(other.idViaje))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ViajesClarosInstancias[ idViaje=" + idViaje + " ]";
    }
    
}
