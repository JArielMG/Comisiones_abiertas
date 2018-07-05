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
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
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
@Table(name = "flujos_instancias")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FlujosInstancias.findAll", query = "SELECT f FROM FlujosInstancias f"),
    @NamedQuery(name = "FlujosInstancias.findByIdInstancia", query = "SELECT f FROM FlujosInstancias f WHERE f.flujosInstanciasPK.idInstancia = :idInstancia"),
    @NamedQuery(name = "FlujosInstancias.findByIdFlujo", query = "SELECT f FROM FlujosInstancias f WHERE f.flujosInstanciasPK.idFlujo = :idFlujo"),
    @NamedQuery(name = "FlujosInstancias.findByIdComision", query = "SELECT f FROM FlujosInstancias f WHERE f.flujosInstanciasPK.idComision = :idComision"),
    @NamedQuery(name = "FlujosInstancias.findByFechaInicio", query = "SELECT f FROM FlujosInstancias f WHERE f.fechaInicio = :fechaInicio"),
    @NamedQuery(name = "FlujosInstancias.findByFechaFin", query = "SELECT f FROM FlujosInstancias f WHERE f.fechaFin = :fechaFin"),
    @NamedQuery(name = "FlujosInstancias.findByAsignado", query = "SELECT f FROM FlujosInstancias f WHERE f.asignado = :asignado")})
public class FlujosInstancias implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected FlujosInstanciasPK flujosInstanciasPK;
    @Column(name = "fecha_inicio")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaInicio;
    @Column(name = "fecha_fin")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaFin;
    @Column(name = "asignado")
    private Boolean asignado;
    @JoinColumn(name = "id_flujo", referencedColumnName = "id_flujo", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private FlujosTrabajo flujosTrabajo;
    @JoinColumn(name = "id_comision", referencedColumnName = "id_comision", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Comisiones comisiones;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "flujosInstancias")
    private Collection<AprobacionesBitacora> aprobacionesBitacoraCollection;

    public FlujosInstancias() {
    }

    public FlujosInstancias(FlujosInstanciasPK flujosInstanciasPK) {
        this.flujosInstanciasPK = flujosInstanciasPK;
    }

    public FlujosInstancias(long idInstancia, int idFlujo, int idComision) {
        this.flujosInstanciasPK = new FlujosInstanciasPK(idInstancia, idFlujo, idComision);
    }

    public FlujosInstanciasPK getFlujosInstanciasPK() {
        return flujosInstanciasPK;
    }

    public void setFlujosInstanciasPK(FlujosInstanciasPK flujosInstanciasPK) {
        this.flujosInstanciasPK = flujosInstanciasPK;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Boolean getAsignado() {
        return asignado;
    }

    public void setAsignado(Boolean asignado) {
        this.asignado = asignado;
    }

    public FlujosTrabajo getFlujosTrabajo() {
        return flujosTrabajo;
    }

    public void setFlujosTrabajo(FlujosTrabajo flujosTrabajo) {
        this.flujosTrabajo = flujosTrabajo;
    }

    public Comisiones getComisiones() {
        return comisiones;
    }

    public void setComisiones(Comisiones comisiones) {
        this.comisiones = comisiones;
    }

    @XmlTransient
    public Collection<AprobacionesBitacora> getAprobacionesBitacoraCollection() {
        return aprobacionesBitacoraCollection;
    }

    public void setAprobacionesBitacoraCollection(Collection<AprobacionesBitacora> aprobacionesBitacoraCollection) {
        this.aprobacionesBitacoraCollection = aprobacionesBitacoraCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (flujosInstanciasPK != null ? flujosInstanciasPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FlujosInstancias)) {
            return false;
        }
        FlujosInstancias other = (FlujosInstancias) object;
        if ((this.flujosInstanciasPK == null && other.flujosInstanciasPK != null) || (this.flujosInstanciasPK != null && !this.flujosInstanciasPK.equals(other.flujosInstanciasPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.FlujosInstancias[ flujosInstanciasPK=" + flujosInstanciasPK + " ]";
    }
    
}
