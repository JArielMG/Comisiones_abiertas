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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "aprobaciones_bitacora")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AprobacionesBitacora.findAll", query = "SELECT a FROM AprobacionesBitacora a"),
    @NamedQuery(name = "AprobacionesBitacora.findByIdInstancia", query = "SELECT a FROM AprobacionesBitacora a WHERE a.aprobacionesBitacoraPK.idInstancia = :idInstancia"),
    @NamedQuery(name = "AprobacionesBitacora.findByIdFlujo", query = "SELECT a FROM AprobacionesBitacora a WHERE a.aprobacionesBitacoraPK.idFlujo = :idFlujo"),
    @NamedQuery(name = "AprobacionesBitacora.findByIdComision", query = "SELECT a FROM AprobacionesBitacora a WHERE a.aprobacionesBitacoraPK.idComision = :idComision"),
    @NamedQuery(name = "AprobacionesBitacora.findByIdFuncionario", query = "SELECT a FROM AprobacionesBitacora a WHERE a.aprobacionesBitacoraPK.idFuncionario = :idFuncionario"),
    @NamedQuery(name = "AprobacionesBitacora.findByRespuesta", query = "SELECT a FROM AprobacionesBitacora a WHERE a.respuesta = :respuesta"),
    @NamedQuery(name = "AprobacionesBitacora.findByFechaEvento", query = "SELECT a FROM AprobacionesBitacora a WHERE a.fechaEvento = :fechaEvento")})
public class AprobacionesBitacora implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AprobacionesBitacoraPK aprobacionesBitacoraPK;
    @Basic(optional = false)
    @Column(name = "respuesta")
    private String respuesta;
    @Basic(optional = false)
    @Column(name = "fecha_evento")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaEvento;
    @JoinColumn(name = "id_funcionario", referencedColumnName = "id_persona", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Personas personas;
    @JoinColumns({
        @JoinColumn(name = "id_instancia", referencedColumnName = "id_instancia", insertable = false, updatable = false),
        @JoinColumn(name = "id_flujo", referencedColumnName = "id_flujo", insertable = false, updatable = false),
        @JoinColumn(name = "id_comision", referencedColumnName = "id_comision", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private FlujosInstancias flujosInstancias;

    public AprobacionesBitacora() {
    }

    public AprobacionesBitacora(AprobacionesBitacoraPK aprobacionesBitacoraPK) {
        this.aprobacionesBitacoraPK = aprobacionesBitacoraPK;
    }

    public AprobacionesBitacora(AprobacionesBitacoraPK aprobacionesBitacoraPK, String respuesta, Date fechaEvento) {
        this.aprobacionesBitacoraPK = aprobacionesBitacoraPK;
        this.respuesta = respuesta;
        this.fechaEvento = fechaEvento;
    }

    public AprobacionesBitacora(long idInstancia, int idFlujo, int idComision, int idFuncionario) {
        this.aprobacionesBitacoraPK = new AprobacionesBitacoraPK(idInstancia, idFlujo, idComision, idFuncionario);
    }

    public AprobacionesBitacoraPK getAprobacionesBitacoraPK() {
        return aprobacionesBitacoraPK;
    }

    public void setAprobacionesBitacoraPK(AprobacionesBitacoraPK aprobacionesBitacoraPK) {
        this.aprobacionesBitacoraPK = aprobacionesBitacoraPK;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public Date getFechaEvento() {
        return fechaEvento;
    }

    public void setFechaEvento(Date fechaEvento) {
        this.fechaEvento = fechaEvento;
    }

    public Personas getPersonas() {
        return personas;
    }

    public void setPersonas(Personas personas) {
        this.personas = personas;
    }

    public FlujosInstancias getFlujosInstancias() {
        return flujosInstancias;
    }

    public void setFlujosInstancias(FlujosInstancias flujosInstancias) {
        this.flujosInstancias = flujosInstancias;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (aprobacionesBitacoraPK != null ? aprobacionesBitacoraPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AprobacionesBitacora)) {
            return false;
        }
        AprobacionesBitacora other = (AprobacionesBitacora) object;
        if ((this.aprobacionesBitacoraPK == null && other.aprobacionesBitacoraPK != null) || (this.aprobacionesBitacoraPK != null && !this.aprobacionesBitacoraPK.equals(other.aprobacionesBitacoraPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.AprobacionesBitacora[ aprobacionesBitacoraPK=" + aprobacionesBitacoraPK + " ]";
    }
    
}
