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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "suscripcion_email_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SuscripcionEmailConfig.findAll", query = "SELECT s FROM SuscripcionEmailConfig s"),
    @NamedQuery(name = "SuscripcionEmailConfig.findByIdPersona", query = "SELECT s FROM SuscripcionEmailConfig s WHERE s.suscripcionEmailConfigPK.idPersona = :idPersona"),
    @NamedQuery(name = "SuscripcionEmailConfig.findByEmail", query = "SELECT s FROM SuscripcionEmailConfig s WHERE s.suscripcionEmailConfigPK.email = :email"),
    @NamedQuery(name = "SuscripcionEmailConfig.findByNombres", query = "SELECT s FROM SuscripcionEmailConfig s WHERE s.suscripcionEmailConfigPK.nombres = :nombres"),
    @NamedQuery(name = "SuscripcionEmailConfig.findByApellido1", query = "SELECT s FROM SuscripcionEmailConfig s WHERE s.suscripcionEmailConfigPK.apellido1 = :apellido1"),
    @NamedQuery(name = "SuscripcionEmailConfig.findByApellido2", query = "SELECT s FROM SuscripcionEmailConfig s WHERE s.suscripcionEmailConfigPK.apellido2 = :apellido2")})
public class SuscripcionEmailConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected SuscripcionEmailConfigPK suscripcionEmailConfigPK;

    public SuscripcionEmailConfig() {
    }

    public SuscripcionEmailConfig(SuscripcionEmailConfigPK suscripcionEmailConfigPK) {
        this.suscripcionEmailConfigPK = suscripcionEmailConfigPK;
    }

    public SuscripcionEmailConfig(int idPersona, String email, String nombres, String apellido1, String apellido2) {
        this.suscripcionEmailConfigPK = new SuscripcionEmailConfigPK(idPersona, email, nombres, apellido1, apellido2);
    }

    public SuscripcionEmailConfigPK getSuscripcionEmailConfigPK() {
        return suscripcionEmailConfigPK;
    }

    public void setSuscripcionEmailConfigPK(SuscripcionEmailConfigPK suscripcionEmailConfigPK) {
        this.suscripcionEmailConfigPK = suscripcionEmailConfigPK;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (suscripcionEmailConfigPK != null ? suscripcionEmailConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SuscripcionEmailConfig)) {
            return false;
        }
        SuscripcionEmailConfig other = (SuscripcionEmailConfig) object;
        if ((this.suscripcionEmailConfigPK == null && other.suscripcionEmailConfigPK != null) || (this.suscripcionEmailConfigPK != null && !this.suscripcionEmailConfigPK.equals(other.suscripcionEmailConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SuscripcionEmailConfig[ suscripcionEmailConfigPK=" + suscripcionEmailConfigPK + " ]";
    }
    
}
