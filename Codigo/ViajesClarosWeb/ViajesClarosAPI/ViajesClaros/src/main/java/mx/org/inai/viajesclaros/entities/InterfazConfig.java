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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
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
@Table(name = "interfaz_config")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "InterfazConfig.findAll", query = "SELECT i FROM InterfazConfig i"),
    @NamedQuery(name = "InterfazConfig.findByTabla", query = "SELECT i FROM InterfazConfig i WHERE i.interfazConfigPK.tabla = :tabla"),
    @NamedQuery(name = "InterfazConfig.findByCampo", query = "SELECT i FROM InterfazConfig i WHERE i.interfazConfigPK.campo = :campo"),
    @NamedQuery(name = "InterfazConfig.findByListaHabilitada", query = "SELECT i FROM InterfazConfig i WHERE i.listaHabilitada = :listaHabilitada"),
    @NamedQuery(name = "InterfazConfig.findByEtiqueta", query = "SELECT i FROM InterfazConfig i WHERE i.etiqueta = :etiqueta"),
    @NamedQuery(name = "InterfazConfig.findBySecuencia", query = "SELECT i FROM InterfazConfig i WHERE i.secuencia = :secuencia"),
    @NamedQuery(name = "InterfazConfig.findByIdDependencia", query = "SELECT i FROM InterfazConfig i WHERE i.interfazConfigPK.idDependencia = :idDependencia"),
    @NamedQuery(name = "InterfazConfig.findByEditable", query = "SELECT i FROM InterfazConfig i WHERE i.editable = :editable")})
public class InterfazConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected InterfazConfigPK interfazConfigPK;
    @Basic(optional = false)
    @Column(name = "lista_habilitada")
    private boolean listaHabilitada;
    @Column(name = "etiqueta")
    private String etiqueta;
    @Basic(optional = false)
    @Column(name = "secuencia")
    private int secuencia;
    @Column(name = "editable")
    private Boolean editable;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Dependencias dependencias;

    public InterfazConfig() {
    }

    public InterfazConfig(InterfazConfigPK interfazConfigPK) {
        this.interfazConfigPK = interfazConfigPK;
    }

    public InterfazConfig(InterfazConfigPK interfazConfigPK, boolean listaHabilitada, int secuencia) {
        this.interfazConfigPK = interfazConfigPK;
        this.listaHabilitada = listaHabilitada;
        this.secuencia = secuencia;
    }

    public InterfazConfig(String tabla, String campo, int idDependencia) {
        this.interfazConfigPK = new InterfazConfigPK(tabla, campo, idDependencia);
    }

    public InterfazConfigPK getInterfazConfigPK() {
        return interfazConfigPK;
    }

    public void setInterfazConfigPK(InterfazConfigPK interfazConfigPK) {
        this.interfazConfigPK = interfazConfigPK;
    }

    public boolean getListaHabilitada() {
        return listaHabilitada;
    }

    public void setListaHabilitada(boolean listaHabilitada) {
        this.listaHabilitada = listaHabilitada;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public Boolean getEditable() {
        return editable;
    }

    public void setEditable(Boolean editable) {
        this.editable = editable;
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
        hash += (interfazConfigPK != null ? interfazConfigPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof InterfazConfig)) {
            return false;
        }
        InterfazConfig other = (InterfazConfig) object;
        if ((this.interfazConfigPK == null && other.interfazConfigPK != null) || (this.interfazConfigPK != null && !this.interfazConfigPK.equals(other.interfazConfigPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.InterfazConfig[ interfazConfigPK=" + interfazConfigPK + " ]";
    }
    
}
