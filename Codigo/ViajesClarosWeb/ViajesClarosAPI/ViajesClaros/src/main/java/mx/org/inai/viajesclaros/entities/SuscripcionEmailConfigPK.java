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
public class SuscripcionEmailConfigPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_persona")
    private int idPersona;
    @Basic(optional = false)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @Column(name = "nombres")
    private String nombres;
    @Basic(optional = false)
    @Column(name = "apellido1")
    private String apellido1;
    @Basic(optional = false)
    @Column(name = "apellido2")
    private String apellido2;

    public SuscripcionEmailConfigPK() {
    }

    public SuscripcionEmailConfigPK(int idPersona, String email, String nombres, String apellido1, String apellido2) {
        this.idPersona = idPersona;
        this.email = email;
        this.nombres = nombres;
        this.apellido1 = apellido1;
        this.apellido2 = apellido2;
    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idPersona;
        hash += (email != null ? email.hashCode() : 0);
        hash += (nombres != null ? nombres.hashCode() : 0);
        hash += (apellido1 != null ? apellido1.hashCode() : 0);
        hash += (apellido2 != null ? apellido2.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SuscripcionEmailConfigPK)) {
            return false;
        }
        SuscripcionEmailConfigPK other = (SuscripcionEmailConfigPK) object;
        if (this.idPersona != other.idPersona) {
            return false;
        }
        if ((this.email == null && other.email != null) || (this.email != null && !this.email.equals(other.email))) {
            return false;
        }
        if ((this.nombres == null && other.nombres != null) || (this.nombres != null && !this.nombres.equals(other.nombres))) {
            return false;
        }
        if ((this.apellido1 == null && other.apellido1 != null) || (this.apellido1 != null && !this.apellido1.equals(other.apellido1))) {
            return false;
        }
        if ((this.apellido2 == null && other.apellido2 != null) || (this.apellido2 != null && !this.apellido2.equals(other.apellido2))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SuscripcionEmailConfigPK[ idPersona=" + idPersona + ", email=" + email + ", nombres=" + nombres + ", apellido1=" + apellido1 + ", apellido2=" + apellido2 + " ]";
    }
    
}
