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
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "comisiones_detalle")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ComisionesDetalle.findAll", query = "SELECT c FROM ComisionesDetalle c"),
    @NamedQuery(name = "ComisionesDetalle.findByIdDetalle", query = "SELECT c FROM ComisionesDetalle c WHERE c.idDetalle = :idDetalle"),
    @NamedQuery(name = "ComisionesDetalle.findByTabla", query = "SELECT c FROM ComisionesDetalle c WHERE c.tabla = :tabla"),
    @NamedQuery(name = "ComisionesDetalle.findByCampo", query = "SELECT c FROM ComisionesDetalle c WHERE c.campo = :campo"),
    @NamedQuery(name = "ComisionesDetalle.findByValorTexto", query = "SELECT c FROM ComisionesDetalle c WHERE c.valorTexto = :valorTexto"),
    @NamedQuery(name = "ComisionesDetalle.findByValorNumerico", query = "SELECT c FROM ComisionesDetalle c WHERE c.valorNumerico = :valorNumerico"),
    @NamedQuery(name = "ComisionesDetalle.findByValorFecha", query = "SELECT c FROM ComisionesDetalle c WHERE c.valorFecha = :valorFecha")})
public class ComisionesDetalle implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_detalle")
    private Integer idDetalle;
    @Column(name = "tabla")
    private String tabla;
    @Column(name = "campo")
    private String campo;
    @Column(name = "valor_texto")
    private String valorTexto;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor_numerico")
    private Double valorNumerico;
    @Column(name = "valor_fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date valorFecha;
    @JoinColumn(name = "id_comision", referencedColumnName = "id_comision")
    @ManyToOne(optional = false)
    private Comisiones idComision;

    public ComisionesDetalle() {
    }

    public ComisionesDetalle(Integer idDetalle) {
        this.idDetalle = idDetalle;
    }

    public Integer getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(Integer idDetalle) {
        this.idDetalle = idDetalle;
    }

    public String getTabla() {
        return tabla;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getCampo() {
        return campo;
    }

    public void setCampo(String campo) {
        this.campo = campo;
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

    public Comisiones getIdComision() {
        return idComision;
    }

    public void setIdComision(Comisiones idComision) {
        this.idComision = idComision;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDetalle != null ? idDetalle.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ComisionesDetalle)) {
            return false;
        }
        ComisionesDetalle other = (ComisionesDetalle) object;
        if ((this.idDetalle == null && other.idDetalle != null) || (this.idDetalle != null && !this.idDetalle.equals(other.idDetalle))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ComisionesDetalle[ idDetalle=" + idDetalle + " ]";
    }
    
}
