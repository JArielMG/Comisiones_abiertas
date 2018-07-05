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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "archivo_lineas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ArchivoLineas.findAll", query = "SELECT a FROM ArchivoLineas a"),
    @NamedQuery(name = "ArchivoLineas.findByIdError", query = "SELECT a FROM ArchivoLineas a WHERE a.idError = :idError"),
    @NamedQuery(name = "ArchivoLineas.findByIdLinea", query = "SELECT a FROM ArchivoLineas a WHERE a.idLinea = :idLinea"),
    @NamedQuery(name = "ArchivoLineas.findByEstatus", query = "SELECT a FROM ArchivoLineas a WHERE a.estatus = :estatus"),
    @NamedQuery(name = "ArchivoLineas.findByComentarios", query = "SELECT a FROM ArchivoLineas a WHERE a.comentarios = :comentarios")})
public class ArchivoLineas implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_error")
    private Integer idError;
    @Basic(optional = false)
    @Column(name = "id_linea")
    private int idLinea;
    @Column(name = "estatus")
    private String estatus;
    @Column(name = "comentarios")
    private String comentarios;
    @JoinColumn(name = "id_archivo", referencedColumnName = "id_archivo")
    @ManyToOne(optional = false)
    private ArchivosProcesados idArchivo;

    public ArchivoLineas() {
    }

    public ArchivoLineas(Integer idError) {
        this.idError = idError;
    }

    public ArchivoLineas(Integer idError, int idLinea) {
        this.idError = idError;
        this.idLinea = idLinea;
    }

    public Integer getIdError() {
        return idError;
    }

    public void setIdError(Integer idError) {
        this.idError = idError;
    }

    public int getIdLinea() {
        return idLinea;
    }

    public void setIdLinea(int idLinea) {
        this.idLinea = idLinea;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public ArchivosProcesados getIdArchivo() {
        return idArchivo;
    }

    public void setIdArchivo(ArchivosProcesados idArchivo) {
        this.idArchivo = idArchivo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idError != null ? idError.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ArchivoLineas)) {
            return false;
        }
        ArchivoLineas other = (ArchivoLineas) object;
        if ((this.idError == null && other.idError != null) || (this.idError != null && !this.idError.equals(other.idError))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.ArchivoLineas[ idError=" + idError + " ]";
    }
    
}
