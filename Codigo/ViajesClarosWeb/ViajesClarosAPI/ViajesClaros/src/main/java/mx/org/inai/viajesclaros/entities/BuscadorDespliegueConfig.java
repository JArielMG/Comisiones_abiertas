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
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "buscador_despliegue_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BuscadorDespliegueConfig.findAll", query = "SELECT b FROM BuscadorDespliegueConfig b"),
    @NamedQuery(name = "BuscadorDespliegueConfig.findByIdDependencia", query = "SELECT b FROM BuscadorDespliegueConfig b WHERE b.buscadorDespliegueConfigPK.idDependencia = :idDependencia"),
    @NamedQuery(name = "BuscadorDespliegueConfig.findByTabla", query = "SELECT b FROM BuscadorDespliegueConfig b WHERE b.buscadorDespliegueConfigPK.tabla = :tabla"),
    @NamedQuery(name = "BuscadorDespliegueConfig.findByCampo", query = "SELECT b FROM BuscadorDespliegueConfig b WHERE b.buscadorDespliegueConfigPK.campo = :campo"),
    @NamedQuery(name = "BuscadorDespliegueConfig.findByOrden", query = "SELECT b FROM BuscadorDespliegueConfig b WHERE b.orden = :orden"),
    @NamedQuery(name = "BuscadorDespliegueConfig.findByMostrar", query = "SELECT b FROM BuscadorDespliegueConfig b WHERE b.mostrar = :mostrar")})
public class BuscadorDespliegueConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected BuscadorDespliegueConfigPK buscadorDespliegueConfigPK;
    @Column(name = "orden")
    private Short orden;
    @Column(name = "mostrar")
    private Boolean mostrar;
    @JoinColumns({
        @JoinColumn(name = "tabla", referencedColumnName = "tabla", insertable = false, updatable = false),
        @JoinColumn(name = "campo", referencedColumnName = "campo", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private ViajesClarosConfig viajesClarosConfig;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Dependencias dependencias;

    public BuscadorDespliegueConfig() {
    }

    public BuscadorDespliegueConfig(BuscadorDespliegueConfigPK buscadorDespliegueConfigPK) {
        this.buscadorDespliegueConfigPK = buscadorDespliegueConfigPK;
    }

    public BuscadorDespliegueConfig(int idDependencia, String tabla, String campo) {
        this.buscadorDespliegueConfigPK = new BuscadorDespliegueConfigPK(idDependencia, tabla, campo);
    }

    public BuscadorDespliegueConfigPK getBuscadorDespliegueConfigPK() {
        return buscadorDespliegueConfigPK;
    }

    public void setBuscadorDespliegueConfigPK(BuscadorDespliegueConfigPK buscadorDespliegueConfigPK) {
        this.buscadorDespliegueConfigPK = buscadorDespliegueConfigPK;
    }

    public Short getOrden() {
        return orden;
    }

    public void setOrden(Short orden) {
        this.orden = orden;
    }

    public Boolean getMostrar() {
        return mostrar;
    }

    public void setMostrar(Boolean mostrar) {
        this.mostrar = mostrar;
    }

    public ViajesClarosConfig getViajesClarosConfig() {
        return viajesClarosConfig;
    }

    public void setViajesClarosConfig(ViajesClarosConfig viajesClarosConfig) {
        this.viajesClarosConfig = viajesClarosConfig;
    }

    public Dependencias getDependencias() {
        return dependencias;
    }

    public void setDependencias(Dependencias dependencias) {
        this.dependencias = dependencias;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (buscadorDespliegueConfigPK != null ? buscadorDespliegueConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BuscadorDespliegueConfig)) {
            return false;
        }
        BuscadorDespliegueConfig other = (BuscadorDespliegueConfig) object;
        if ((this.buscadorDespliegueConfigPK == null && other.buscadorDespliegueConfigPK != null) || (this.buscadorDespliegueConfigPK != null && !this.buscadorDespliegueConfigPK.equals(other.buscadorDespliegueConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.BuscadorDespliegueConfig[ buscadorDespliegueConfigPK=" + buscadorDespliegueConfigPK + " ]";
    }
    
}
