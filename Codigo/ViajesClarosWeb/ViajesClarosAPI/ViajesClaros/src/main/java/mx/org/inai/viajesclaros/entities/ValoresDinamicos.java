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
@Table(name = "valores_dinamicos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ValoresDinamicos.findAll", query = "SELECT v FROM ValoresDinamicos v"),
    @NamedQuery(name = "ValoresDinamicos.findByIdLista", query = "SELECT v FROM ValoresDinamicos v WHERE v.valoresDinamicosPK.idLista = :idLista"),
    @NamedQuery(name = "ValoresDinamicos.findByCodigo", query = "SELECT v FROM ValoresDinamicos v WHERE v.valoresDinamicosPK.codigo = :codigo"),
    @NamedQuery(name = "ValoresDinamicos.findByValor", query = "SELECT v FROM ValoresDinamicos v WHERE v.valor = :valor"),
    @NamedQuery(name = "ValoresDinamicos.findByActivo", query = "SELECT v FROM ValoresDinamicos v WHERE v.activo = :activo")})
public class ValoresDinamicos implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ValoresDinamicosPK valoresDinamicosPK;
    @Basic(optional = false)
    @Column(name = "valor")
    private String valor;
    @Column(name = "activo")
    private Short activo;
    @JoinColumn(name = "id_lista", referencedColumnName = "id_lista", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ListasValores listasValores;

    public ValoresDinamicos() {
    }

    public ValoresDinamicos(ValoresDinamicosPK valoresDinamicosPK) {
        this.valoresDinamicosPK = valoresDinamicosPK;
    }

    public ValoresDinamicos(ValoresDinamicosPK valoresDinamicosPK, String valor) {
        this.valoresDinamicosPK = valoresDinamicosPK;
        this.valor = valor;
    }

    public ValoresDinamicos(int idLista, String codigo) {
        this.valoresDinamicosPK = new ValoresDinamicosPK(idLista, codigo);
    }

    public ValoresDinamicosPK getValoresDinamicosPK() {
        return valoresDinamicosPK;
    }

    public void setValoresDinamicosPK(ValoresDinamicosPK valoresDinamicosPK) {
        this.valoresDinamicosPK = valoresDinamicosPK;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public Short getActivo() {
        return activo;
    }

    public void setActivo(Short activo) {
        this.activo = activo;
    }

    public ListasValores getListasValores() {
        return listasValores;
    }

    public void setListasValores(ListasValores listasValores) {
        this.listasValores = listasValores;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (valoresDinamicosPK != null ? valoresDinamicosPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ValoresDinamicos)) {
            return false;
        }
        ValoresDinamicos other = (ValoresDinamicos) object;
        if ((this.valoresDinamicosPK == null && other.valoresDinamicosPK != null) || (this.valoresDinamicosPK != null && !this.valoresDinamicosPK.equals(other.valoresDinamicosPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ValoresDinamicos[ valoresDinamicosPK=" + valoresDinamicosPK + " ]";
    }
    
}
