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
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
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
@Table(name = "viajes_claros_detalle")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ViajesClarosDetalle.findAll", query = "SELECT v FROM ViajesClarosDetalle v"),
    @NamedQuery(name = "ViajesClarosDetalle.findByIdViaje", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.viajesClarosDetallePK.idViaje = :idViaje"),
    @NamedQuery(name = "ViajesClarosDetalle.findByTabla", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.viajesClarosDetallePK.tabla = :tabla"),
    @NamedQuery(name = "ViajesClarosDetalle.findByCampo", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.viajesClarosDetallePK.campo = :campo"),
    @NamedQuery(name = "ViajesClarosDetalle.findByValorTexto", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.valorTexto = :valorTexto"),
    @NamedQuery(name = "ViajesClarosDetalle.findByValorNumerico", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.valorNumerico = :valorNumerico"),
    @NamedQuery(name = "ViajesClarosDetalle.findByValorFecha", query = "SELECT v FROM ViajesClarosDetalle v WHERE v.valorFecha = :valorFecha")})
public class ViajesClarosDetalle implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ViajesClarosDetallePK viajesClarosDetallePK;
    @Column(name = "valor_texto")
    private String valorTexto;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor_numerico")
    private Double valorNumerico;
    @Column(name = "valor_fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date valorFecha;
    @JoinColumn(name = "id_viaje", referencedColumnName = "id_viaje", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ViajesClarosInstancias viajesClarosInstancias;

    public ViajesClarosDetalle() {
    }

    public ViajesClarosDetalle(ViajesClarosDetallePK viajesClarosDetallePK) {
        this.viajesClarosDetallePK = viajesClarosDetallePK;
    }

    public ViajesClarosDetalle(int idViaje, String tabla, String campo) {
        this.viajesClarosDetallePK = new ViajesClarosDetallePK(idViaje, tabla, campo);
    }

    public ViajesClarosDetallePK getViajesClarosDetallePK() {
        return viajesClarosDetallePK;
    }

    public void setViajesClarosDetallePK(ViajesClarosDetallePK viajesClarosDetallePK) {
        this.viajesClarosDetallePK = viajesClarosDetallePK;
    }

    public String getValorTexto() {
        return valorTexto;
    }

    public void setValorTexto(String valorTexto) {
        this.valorTexto = valorTexto;
    }

    public Double getValorNumerico() {
        return valorNumerico;
    }

    public void setValorNumerico(Double valorNumerico) {
        this.valorNumerico = valorNumerico;
    }

    public Date getValorFecha() {
        return valorFecha;
    }

    public void setValorFecha(Date valorFecha) {
        this.valorFecha = valorFecha;
    }

    public ViajesClarosInstancias getViajesClarosInstancias() {
        return viajesClarosInstancias;
    }

    public void setViajesClarosInstancias(ViajesClarosInstancias viajesClarosInstancias) {
        this.viajesClarosInstancias = viajesClarosInstancias;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (viajesClarosDetallePK != null ? viajesClarosDetallePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ViajesClarosDetalle)) {
            return false;
        }
        ViajesClarosDetalle other = (ViajesClarosDetalle) object;
        if ((this.viajesClarosDetallePK == null && other.viajesClarosDetallePK != null) || (this.viajesClarosDetallePK != null && !this.viajesClarosDetallePK.equals(other.viajesClarosDetallePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ViajesClarosDetalle[ viajesClarosDetallePK=" + viajesClarosDetallePK + " ]";
    }
    
}
