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
@Table(name = "buscador_filtros_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BuscadorFiltrosConfig.findAll", query = "SELECT b FROM BuscadorFiltrosConfig b"),
    @NamedQuery(name = "BuscadorFiltrosConfig.findByIdDependencia", query = "SELECT b FROM BuscadorFiltrosConfig b WHERE b.buscadorFiltrosConfigPK.idDependencia = :idDependencia"),
    @NamedQuery(name = "BuscadorFiltrosConfig.findByTabla", query = "SELECT b FROM BuscadorFiltrosConfig b WHERE b.buscadorFiltrosConfigPK.tabla = :tabla"),
    @NamedQuery(name = "BuscadorFiltrosConfig.findByCampo", query = "SELECT b FROM BuscadorFiltrosConfig b WHERE b.buscadorFiltrosConfigPK.campo = :campo"),
    @NamedQuery(name = "BuscadorFiltrosConfig.findByOperador", query = "SELECT b FROM BuscadorFiltrosConfig b WHERE b.operador = :operador"),
    @NamedQuery(name = "BuscadorFiltrosConfig.findByOrden", query = "SELECT b FROM BuscadorFiltrosConfig b WHERE b.orden = :orden")})
public class BuscadorFiltrosConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected BuscadorFiltrosConfigPK buscadorFiltrosConfigPK;
    @Column(name = "operador")
    private String operador;
    @Column(name = "orden")
    private Short orden;
    @JoinColumns({
        @JoinColumn(name = "tabla", referencedColumnName = "tabla", insertable = false, updatable = false),
        @JoinColumn(name = "campo", referencedColumnName = "campo", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private ViajesClarosConfig viajesClarosConfig;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Dependencias dependencias;

    public BuscadorFiltrosConfig() {
    }

    public BuscadorFiltrosConfig(BuscadorFiltrosConfigPK buscadorFiltrosConfigPK) {
        this.buscadorFiltrosConfigPK = buscadorFiltrosConfigPK;
    }

    public BuscadorFiltrosConfig(int idDependencia, String tabla, String campo) {
        this.buscadorFiltrosConfigPK = new BuscadorFiltrosConfigPK(idDependencia, tabla, campo);
    }

    public BuscadorFiltrosConfigPK getBuscadorFiltrosConfigPK() {
        return buscadorFiltrosConfigPK;
    }

    public void setBuscadorFiltrosConfigPK(BuscadorFiltrosConfigPK buscadorFiltrosConfigPK) {
        this.buscadorFiltrosConfigPK = buscadorFiltrosConfigPK;
    }

    public String getOperador() {
        return operador;
    }

    public void setOperador(String operador) {
        this.operador = operador;
    }

    public Short getOrden() {
        return orden;
    }

    public void setOrden(Short orden) {
        this.orden = orden;
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
        hash += (buscadorFiltrosConfigPK != null ? buscadorFiltrosConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BuscadorFiltrosConfig)) {
            return false;
        }
        BuscadorFiltrosConfig other = (BuscadorFiltrosConfig) object;
        if ((this.buscadorFiltrosConfigPK == null && other.buscadorFiltrosConfigPK != null) || (this.buscadorFiltrosConfigPK != null && !this.buscadorFiltrosConfigPK.equals(other.buscadorFiltrosConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.BuscadorFiltrosConfig[ buscadorFiltrosConfigPK=" + buscadorFiltrosConfigPK + " ]";
    }
    
}
