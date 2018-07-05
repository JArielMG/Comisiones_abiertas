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
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "smtp_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SmtpConfig.findAll", query = "SELECT s FROM SmtpConfig s"),
    @NamedQuery(name = "SmtpConfig.findById", query = "SELECT s FROM SmtpConfig s WHERE s.id = :id"),
    @NamedQuery(name = "SmtpConfig.findByHost", query = "SELECT s FROM SmtpConfig s WHERE s.host = :host"),
    @NamedQuery(name = "SmtpConfig.findByPuerto", query = "SELECT s FROM SmtpConfig s WHERE s.puerto = :puerto"),
    @NamedQuery(name = "SmtpConfig.findByUsuario", query = "SELECT s FROM SmtpConfig s WHERE s.usuario = :usuario"),
    @NamedQuery(name = "SmtpConfig.findByPassword", query = "SELECT s FROM SmtpConfig s WHERE s.password = :password")})
public class SmtpConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "host")
    private String host;
    @Column(name = "puerto")
    private String puerto;
    @Column(name = "usuario")
    private String usuario;
    @Column(name = "password")
    private String password;

    public SmtpConfig() {
    }

    public SmtpConfig(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPuerto() {
        return puerto;
    }

    public void setPuerto(String puerto) {
        this.puerto = puerto;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SmtpConfig)) {
            return false;
        }
        SmtpConfig other = (SmtpConfig) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SmtpConfig[ id=" + id + " ]";
    }
    
}
