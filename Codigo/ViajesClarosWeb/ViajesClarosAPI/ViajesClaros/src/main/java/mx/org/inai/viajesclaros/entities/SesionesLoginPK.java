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
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author jmcortes
 */
@Embeddable
public class SesionesLoginPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_usuario")
    private int idUsuario;
    @Basic(optional = false)
    @Column(name = "id_session")
    private int idSession;

    public SesionesLoginPK() {
    }

    public SesionesLoginPK(int idUsuario, int idSession) {
        this.idUsuario = idUsuario;
        this.idSession = idSession;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdSession() {
        return idSession;
    }

    public void setIdSession(int idSession) {
        this.idSession = idSession;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idUsuario;
        hash += (int) idSession;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SesionesLoginPK)) {
            return false;
        }
        SesionesLoginPK other = (SesionesLoginPK) object;
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        if (this.idSession != other.idSession) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SesionesLoginPK[ idUsuario=" + idUsuario + ", idSession=" + idSession + " ]";
    }
    
}
