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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "comisiones_desglose_gastos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ComisionesDesgloseGastos.findAll", query = "SELECT c FROM ComisionesDesgloseGastos c"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByIdDesgloseGastos", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.idDesgloseGastos = :idDesgloseGastos"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByTabla", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.tabla = :tabla"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByCampo", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.campo = :campo"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByValorTexto", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.valorTexto = :valorTexto"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByValorNumerico", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.valorNumerico = :valorNumerico"),
    @NamedQuery(name = "ComisionesDesgloseGastos.findByValorFecha", query = "SELECT c FROM ComisionesDesgloseGastos c WHERE c.valorFecha = :valorFecha")})
public class ComisionesDesgloseGastos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_desglose_gastos")
    private Integer idDesgloseGastos;
    @Column(name = "tabla")
    private String tabla;
    @Column(name = "campo")
    private String campo;
    @Column(name = "valor_texto")
    private String valorTexto;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor_numerico")
    private Double valorNumerico;
    @Column(name = "valor_fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date valorFecha;
    @JoinColumn(name = "id_registro_gasto_comision", referencedColumnName = "id_registro_gasto_comision")
    @ManyToOne
    private RegistrosGastosComision idRegistroGastoComision;
    @JoinColumn(name = "id_comision", referencedColumnName = "id_comision")
    @ManyToOne(optional = false)
    private Comisiones idComision;

    public ComisionesDesgloseGastos() {
    }

    public ComisionesDesgloseGastos(Integer idDesgloseGastos) {
        this.idDesgloseGastos = idDesgloseGastos;
    }

    public Integer getIdDesgloseGastos() {
        return idDesgloseGastos;
    }

    public void setIdDesgloseGastos(Integer idDesgloseGastos) {
        this.idDesgloseGastos = idDesgloseGastos;
    }

    public String getTabla() {
        return tabla;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getCampo() {
        return campo;
    }

    public void setCampo(String campo) {
        this.campo = campo;
    }

    public String getValorTexto() {
        return valorTexto;
    }

    public void setValorTexto(String valorTexto) {
        this.valorTexto = valorTexto;
    }

    public Double getValorNumerico() {
        return valorNumerico;
    }

    public void setValorNumerico(Double valorNumerico) {
        this.valorNumerico = valorNumerico;
    }

    public Date getValorFecha() {
        return valorFecha;
    }

    public void setValorFecha(Date valorFecha) {
        this.valorFecha = valorFecha;
    }

    public RegistrosGastosComision getIdRegistroGastoComision() {
        return idRegistroGastoComision;
    }

    public void setIdRegistroGastoComision(RegistrosGastosComision idRegistroGastoComision) {
        this.idRegistroGastoComision = idRegistroGastoComision;
    }

    public Comisiones getIdComision() {
        return idComision;
    }

    public void setIdComision(Comisiones idComision) {
        this.idComision = idComision;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDesgloseGastos != null ? idDesgloseGastos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ComisionesDesgloseGastos)) {
            return false;
        }
        ComisionesDesgloseGastos other = (ComisionesDesgloseGastos) object;
        if ((this.idDesgloseGastos == null && other.idDesgloseGastos != null) || (this.idDesgloseGastos != null && !this.idDesgloseGastos.equals(other.idDesgloseGastos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ComisionesDesgloseGastos[ idDesgloseGastos=" + idDesgloseGastos + " ]";
    }
    
}
