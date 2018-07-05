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
@Table(name = "comisiones")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Comisiones.findAll", query = "SELECT c FROM Comisiones c"),
    @NamedQuery(name = "Comisiones.findByIdComision", query = "SELECT c FROM Comisiones c WHERE c.idComision = :idComision"),
    @NamedQuery(name = "Comisiones.findByEstatus", query = "SELECT c FROM Comisiones c WHERE c.estatus = :estatus")})
public class Comisiones implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_comision")
    private Integer idComision;
    @Column(name = "estatus")
    private String estatus;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuarios idUsuario;
    @JoinColumn(name = "id_persona", referencedColumnName = "id_persona")
    @ManyToOne(optional = false)
    private Personas idPersona;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")
    @ManyToOne(optional = false)
    private Dependencias idDependencia;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "comisiones")
    private Collection<FlujosInstancias> flujosInstanciasCollection;
    @OneToMany(mappedBy = "idComision")
    private Collection<ViajesClarosInstancias> viajesClarosInstanciasCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idComision")
    private Collection<ComisionesDetalle> comisionesDetalleCollection;
    @OneToMany(mappedBy = "idComision")
    private Collection<RegistrosGastosComision> registrosGastosComisionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idComision")
    private Collection<ComisionesDesgloseGastos> comisionesDesgloseGastosCollection;

    public Comisiones() {
    }

    public Comisiones(Integer idComision) {
        this.idComision = idComision;
    }

    public Integer getIdComision() {
        return idComision;
    }

    public void setIdComision(Integer idComision) {
        this.idComision = idComision;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Personas getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(Personas idPersona) {
        this.idPersona = idPersona;
    }

    public Dependencias getIdDependencia() {
        return idDependencia;
    }

    public void setIdDependencia(Dependencias idDependencia) {
        this.idDependencia = idDependencia;
    }

    @XmlTransient
    public Collection<FlujosInstancias> getFlujosInstanciasCollection() {
        return flujosInstanciasCollection;
    }

    public void setFlujosInstanciasCollection(Collection<FlujosInstancias> flujosInstanciasCollection) {
        this.flujosInstanciasCollection = flujosInstanciasCollection;
    }

    @XmlTransient
    public Collection<ViajesClarosInstancias> getViajesClarosInstanciasCollection() {
        return viajesClarosInstanciasCollection;
    }

    public void setViajesClarosInstanciasCollection(Collection<ViajesClarosInstancias> viajesClarosInstanciasCollection) {
        this.viajesClarosInstanciasCollection = viajesClarosInstanciasCollection;
    }

    @XmlTransient
    public Collection<ComisionesDetalle> getComisionesDetalleCollection() {
        return comisionesDetalleCollection;
    }

    public void setComisionesDetalleCollection(Collection<ComisionesDetalle> comisionesDetalleCollection) {
        this.comisionesDetalleCollection = comisionesDetalleCollection;
    }

    @XmlTransient
    public Collection<RegistrosGastosComision> getRegistrosGastosComisionCollection() {
        return registrosGastosComisionCollection;
    }

    public void setRegistrosGastosComisionCollection(Collection<RegistrosGastosComision> registrosGastosComisionCollection) {
        this.registrosGastosComisionCollection = registrosGastosComisionCollection;
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
        hash += (idComision != null ? idComision.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Comisiones)) {
            return false;
        }
        Comisiones other = (Comisiones) object;
        if ((this.idComision == null && other.idComision != null) || (this.idComision != null && !this.idComision.equals(other.idComision))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Comisiones[ idComision=" + idComision + " ]";
    }
    
}
