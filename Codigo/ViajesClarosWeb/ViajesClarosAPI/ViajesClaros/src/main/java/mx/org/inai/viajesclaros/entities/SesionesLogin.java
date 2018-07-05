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
@Table(name = "sesiones_login")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SesionesLogin.findAll", query = "SELECT s FROM SesionesLogin s"),
    @NamedQuery(name = "SesionesLogin.findByIdUsuario", query = "SELECT s FROM SesionesLogin s WHERE s.sesionesLoginPK.idUsuario = :idUsuario"),
    @NamedQuery(name = "SesionesLogin.findByIdSession", query = "SELECT s FROM SesionesLogin s WHERE s.sesionesLoginPK.idSession = :idSession"),
    @NamedQuery(name = "SesionesLogin.findByFecha", query = "SELECT s FROM SesionesLogin s WHERE s.fecha = :fecha")})
public class SesionesLogin implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected SesionesLoginPK sesionesLoginPK;
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuarios usuarios;

    public SesionesLogin() {
    }

    public SesionesLogin(SesionesLoginPK sesionesLoginPK) {
        this.sesionesLoginPK = sesionesLoginPK;
    }

    public SesionesLogin(int idUsuario, int idSession) {
        this.sesionesLoginPK = new SesionesLoginPK(idUsuario, idSession);
    }

    public SesionesLoginPK getSesionesLoginPK() {
        return sesionesLoginPK;
    }

    public void setSesionesLoginPK(SesionesLoginPK sesionesLoginPK) {
        this.sesionesLoginPK = sesionesLoginPK;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Usuarios getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (sesionesLoginPK != null ? sesionesLoginPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SesionesLogin)) {
            return false;
        }
        SesionesLogin other = (SesionesLogin) object;
        if ((this.sesionesLoginPK == null && other.sesionesLoginPK != null) || (this.sesionesLoginPK != null && !this.sesionesLoginPK.equals(other.sesionesLoginPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SesionesLogin[ sesionesLoginPK=" + sesionesLoginPK + " ]";
    }
    
}
