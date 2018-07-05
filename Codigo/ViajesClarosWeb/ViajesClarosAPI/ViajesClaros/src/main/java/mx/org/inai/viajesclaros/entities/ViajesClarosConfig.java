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
import javax.persistence.CascadeType;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
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
@Table(name = "viajes_claros_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ViajesClarosConfig.findAll", query = "SELECT v FROM ViajesClarosConfig v"),
    @NamedQuery(name = "ViajesClarosConfig.findByTabla", query = "SELECT v FROM ViajesClarosConfig v WHERE v.viajesClarosConfigPK.tabla = :tabla"),
    @NamedQuery(name = "ViajesClarosConfig.findByCampo", query = "SELECT v FROM ViajesClarosConfig v WHERE v.viajesClarosConfigPK.campo = :campo")})
public class ViajesClarosConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ViajesClarosConfigPK viajesClarosConfigPK;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "viajesClarosConfig")
    private Collection<BuscadorDespliegueConfig> buscadorDespliegueConfigCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "viajesClarosConfig")
    private Collection<BuscadorFiltrosConfig> buscadorFiltrosConfigCollection;

    public ViajesClarosConfig() {
    }

    public ViajesClarosConfig(ViajesClarosConfigPK viajesClarosConfigPK) {
        this.viajesClarosConfigPK = viajesClarosConfigPK;
    }

    public ViajesClarosConfig(String tabla, String campo) {
        this.viajesClarosConfigPK = new ViajesClarosConfigPK(tabla, campo);
    }

    public ViajesClarosConfigPK getViajesClarosConfigPK() {
        return viajesClarosConfigPK;
    }

    public void setViajesClarosConfigPK(ViajesClarosConfigPK viajesClarosConfigPK) {
        this.viajesClarosConfigPK = viajesClarosConfigPK;
    }

    @XmlTransient
    public Collection<BuscadorDespliegueConfig> getBuscadorDespliegueConfigCollection() {
        return buscadorDespliegueConfigCollection;
    }

    public void setBuscadorDespliegueConfigCollection(Collection<BuscadorDespliegueConfig> buscadorDespliegueConfigCollection) {
        this.buscadorDespliegueConfigCollection = buscadorDespliegueConfigCollection;
    }

    @XmlTransient
    public Collection<BuscadorFiltrosConfig> getBuscadorFiltrosConfigCollection() {
        return buscadorFiltrosConfigCollection;
    }

    public void setBuscadorFiltrosConfigCollection(Collection<BuscadorFiltrosConfig> buscadorFiltrosConfigCollection) {
        this.buscadorFiltrosConfigCollection = buscadorFiltrosConfigCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (viajesClarosConfigPK != null ? viajesClarosConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ViajesClarosConfig)) {
            return false;
        }
        ViajesClarosConfig other = (ViajesClarosConfig) object;
        if ((this.viajesClarosConfigPK == null && other.viajesClarosConfigPK != null) || (this.viajesClarosConfigPK != null && !this.viajesClarosConfigPK.equals(other.viajesClarosConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ViajesClarosConfig[ viajesClarosConfigPK=" + viajesClarosConfigPK + " ]";
    }
    
}
