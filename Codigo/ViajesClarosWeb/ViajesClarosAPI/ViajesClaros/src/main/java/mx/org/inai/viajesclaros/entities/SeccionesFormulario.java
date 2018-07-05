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
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "secciones_formulario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SeccionesFormulario.findAll", query = "SELECT s FROM SeccionesFormulario s"),
    @NamedQuery(name = "SeccionesFormulario.findByIdSeccion", query = "SELECT s FROM SeccionesFormulario s WHERE s.idSeccion = :idSeccion"),
    @NamedQuery(name = "SeccionesFormulario.findByEtiqueta", query = "SELECT s FROM SeccionesFormulario s WHERE s.etiqueta = :etiqueta"),
    @NamedQuery(name = "SeccionesFormulario.findByNombreSeccion", query = "SELECT s FROM SeccionesFormulario s WHERE s.nombreSeccion = :nombreSeccion"),
    @NamedQuery(name = "SeccionesFormulario.findByOrdenSeccion", query = "SELECT s FROM SeccionesFormulario s WHERE s.ordenSeccion = :ordenSeccion")})
public class SeccionesFormulario implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "id_seccion")
    private Integer idSeccion;
    @Column(name = "etiqueta")
    private String etiqueta;
    @Basic(optional = false)
    @Column(name = "nombre_seccion")
    private String nombreSeccion;
    @Column(name = "orden_seccion")
    private Integer ordenSeccion;
    @OneToMany(mappedBy = "idSeccionFormulario")
    private Collection<FlujosCamposConfig> flujosCamposConfigCollection;
    @JoinColumn(name = "id_flujo", referencedColumnName = "id_flujo")
    @ManyToOne(optional = false)
    private FlujosTrabajo idFlujo;

    public SeccionesFormulario() {
    }

    public SeccionesFormulario(Integer idSeccion) {
        this.idSeccion = idSeccion;
    }

    public SeccionesFormulario(Integer idSeccion, String nombreSeccion) {
        this.idSeccion = idSeccion;
        this.nombreSeccion = nombreSeccion;
    }

    public Integer getIdSeccion() {
        return idSeccion;
    }

    public void setIdSeccion(Integer idSeccion) {
        this.idSeccion = idSeccion;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public String getNombreSeccion() {
        return nombreSeccion;
    }

    public void setNombreSeccion(String nombreSeccion) {
        this.nombreSeccion = nombreSeccion;
    }

    public Integer getOrdenSeccion() {
        return ordenSeccion;
    }

    public void setOrdenSeccion(Integer ordenSeccion) {
        this.ordenSeccion = ordenSeccion;
    }

    @XmlTransient
    public Collection<FlujosCamposConfig> getFlujosCamposConfigCollection() {
        return flujosCamposConfigCollection;
    }

    public void setFlujosCamposConfigCollection(Collection<FlujosCamposConfig> flujosCamposConfigCollection) {
        this.flujosCamposConfigCollection = flujosCamposConfigCollection;
    }

    public FlujosTrabajo getIdFlujo() {
        return idFlujo;
    }

    public void setIdFlujo(FlujosTrabajo idFlujo) {
        this.idFlujo = idFlujo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idSeccion != null ? idSeccion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SeccionesFormulario)) {
            return false;
        }
        SeccionesFormulario other = (SeccionesFormulario) object;
        if ((this.idSeccion == null && other.idSeccion != null) || (this.idSeccion != null && !this.idSeccion.equals(other.idSeccion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.SeccionesFormulario[ idSeccion=" + idSeccion + " ]";
    }
    
}
