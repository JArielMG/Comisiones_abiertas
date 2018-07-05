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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jmcortes
 */
@Entity
@Table(name = "archivos_procesados")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ArchivosProcesados.findAll", query = "SELECT a FROM ArchivosProcesados a"),
    @NamedQuery(name = "ArchivosProcesados.findByIdArchivo", query = "SELECT a FROM ArchivosProcesados a WHERE a.idArchivo = :idArchivo"),
    @NamedQuery(name = "ArchivosProcesados.findByNombreArchivo", query = "SELECT a FROM ArchivosProcesados a WHERE a.nombreArchivo = :nombreArchivo"),
    @NamedQuery(name = "ArchivosProcesados.findByFechaCarga", query = "SELECT a FROM ArchivosProcesados a WHERE a.fechaCarga = :fechaCarga"),
    @NamedQuery(name = "ArchivosProcesados.findByTotalRegistros", query = "SELECT a FROM ArchivosProcesados a WHERE a.totalRegistros = :totalRegistros"),
    @NamedQuery(name = "ArchivosProcesados.findByTotalAceptados", query = "SELECT a FROM ArchivosProcesados a WHERE a.totalAceptados = :totalAceptados"),
    @NamedQuery(name = "ArchivosProcesados.findByTotalRechazados", query = "SELECT a FROM ArchivosProcesados a WHERE a.totalRechazados = :totalRechazados")})
public class ArchivosProcesados implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "id_archivo")
    private Long idArchivo;
    @Basic(optional = false)
    @Column(name = "nombre_archivo")
    private String nombreArchivo;
    @Basic(optional = false)
    @Column(name = "fecha_carga")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaCarga;
    @Column(name = "total_registros")
    private Integer totalRegistros;
    @Column(name = "total_aceptados")
    private Integer totalAceptados;
    @Column(name = "total_rechazados")
    private Integer totalRechazados;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idArchivo")
    private Collection<ArchivoLineas> archivoLineasCollection;

    public ArchivosProcesados() {
    }

    public ArchivosProcesados(Long idArchivo) {
        this.idArchivo = idArchivo;
    }

    public ArchivosProcesados(Long idArchivo, String nombreArchivo, Date fechaCarga) {
        this.idArchivo = idArchivo;
        this.nombreArchivo = nombreArchivo;
        this.fechaCarga = fechaCarga;
    }

    public Long getIdArchivo() {
        return idArchivo;
    }

    public void setIdArchivo(Long idArchivo) {
        this.idArchivo = idArchivo;
    }

    public String getNombreArchivo() {
        return nombreArchivo;
    }

    public void setNombreArchivo(String nombreArchivo) {
        this.nombreArchivo = nombreArchivo;
    }

    public Date getFechaCarga() {
        return fechaCarga;
    }

    public void setFechaCarga(Date fechaCarga) {
        this.fechaCarga = fechaCarga;
    }

    public Integer getTotalRegistros() {
        return totalRegistros;
    }

    public void setTotalRegistros(Integer totalRegistros) {
        this.totalRegistros = totalRegistros;
    }

    public Integer getTotalAceptados() {
        return totalAceptados;
    }

    public void setTotalAceptados(Integer totalAceptados) {
        this.totalAceptados = totalAceptados;
    }

    public Integer getTotalRechazados() {
        return totalRechazados;
    }

    public void setTotalRechazados(Integer totalRechazados) {
        this.totalRechazados = totalRechazados;
    }

    @XmlTransient
    public Collection<ArchivoLineas> getArchivoLineasCollection() {
        return archivoLineasCollection;
    }

    public void setArchivoLineasCollection(Collection<ArchivoLineas> archivoLineasCollection) {
        this.archivoLineasCollection = archivoLineasCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idArchivo != null ? idArchivo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ArchivosProcesados)) {
            return false;
        }
        ArchivosProcesados other = (ArchivosProcesados) object;
        if ((this.idArchivo == null && other.idArchivo != null) || (this.idArchivo != null && !this.idArchivo.equals(other.idArchivo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ArchivosProcesados[ idArchivo=" + idArchivo + " ]";
    }
    
}
