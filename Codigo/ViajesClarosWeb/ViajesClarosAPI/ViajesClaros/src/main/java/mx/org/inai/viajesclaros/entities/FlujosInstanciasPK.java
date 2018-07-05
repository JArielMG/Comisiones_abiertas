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
public class FlujosInstanciasPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_instancia")
    private long idInstancia;
    @Basic(optional = false)
    @Column(name = "id_flujo")
    private int idFlujo;
    @Basic(optional = false)
    @Column(name = "id_comision")
    private int idComision;

    public FlujosInstanciasPK() {
    }

    public FlujosInstanciasPK(long idInstancia, int idFlujo, int idComision) {
        this.idInstancia = idInstancia;
        this.idFlujo = idFlujo;
        this.idComision = idComision;
    }

    public long getIdInstancia() {
        return idInstancia;
    }

    public void setIdInstancia(long idInstancia) {
        this.idInstancia = idInstancia;
    }

    public int getIdFlujo() {
        return idFlujo;
    }

    public void setIdFlujo(int idFlujo) {
        this.idFlujo = idFlujo;
    }

    public int getIdComision() {
        return idComision;
    }

    public void setIdComision(int idComision) {
        this.idComision = idComision;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idInstancia;
        hash += (int) idFlujo;
        hash += (int) idComision;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FlujosInstanciasPK)) {
            return false;
        }
        FlujosInstanciasPK other = (FlujosInstanciasPK) object;
        if (this.idInstancia != other.idInstancia) {
            return false;
        }
        if (this.idFlujo != other.idFlujo) {
            return false;
        }
        if (this.idComision != other.idComision) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.FlujosInstanciasPK[ idInstancia=" + idInstancia + ", idFlujo=" + idFlujo + ", idComision=" + idComision + " ]";
    }
    
}
