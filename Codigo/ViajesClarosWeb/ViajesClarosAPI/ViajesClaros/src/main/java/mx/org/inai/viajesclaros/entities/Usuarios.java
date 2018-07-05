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
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
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
@Table(name = "usuarios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuarios.findAll", query = "SELECT u FROM Usuarios u"),
    @NamedQuery(name = "Usuarios.findByIdUsuario", query = "SELECT u FROM Usuarios u WHERE u.idUsuario = :idUsuario"),
    @NamedQuery(name = "Usuarios.findByUsuario", query = "SELECT u FROM Usuarios u WHERE u.usuario = :usuario"),
    @NamedQuery(name = "Usuarios.findByContrasena", query = "SELECT u FROM Usuarios u WHERE u.contrasena = :contrasena"),
    @NamedQuery(name = "Usuarios.findBySalt", query = "SELECT u FROM Usuarios u WHERE u.salt = :salt"),
    @NamedQuery(name = "Usuarios.findByDescripcion", query = "SELECT u FROM Usuarios u WHERE u.descripcion = :descripcion"),
    @NamedQuery(name = "Usuarios.findByHabilitado", query = "SELECT u FROM Usuarios u WHERE u.habilitado = :habilitado"),
    @NamedQuery(name = "Usuarios.findByIntentos", query = "SELECT u FROM Usuarios u WHERE u.intentos = :intentos"),
    @NamedQuery(name = "Usuarios.findByJefeArea", query = "SELECT u FROM Usuarios u WHERE u.jefeArea = :jefeArea")})
public class Usuarios implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_usuario")
    private Integer idUsuario;
    @Basic(optional = false)
    @Column(name = "usuario")
    private String usuario;
    @Basic(optional = false)
    @Column(name = "contrasena")
    private String contrasena;
    @Column(name = "salt")
    private String salt;
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @Column(name = "habilitado")
    private boolean habilitado;
    @Column(name = "intentos")
    private Integer intentos;
    @Column(name = "jefe_area")
    private Boolean jefeArea;
    @Lob
    @Column(name = "id_bonita")
    private String idBonita;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idUsuario")
    private Collection<Comisiones> comisionesCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idUsuario")
    private Collection<JerarquiaMiembros> jerarquiaMiembrosCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "usuarios")
    private Collection<SesionesLogin> sesionesLoginCollection;
    @JoinColumn(name = "id_perfil", referencedColumnName = "id_perfil")
    @ManyToOne(optional = false)
    private Perfiles idPerfil;
    @JoinColumn(name = "id_persona", referencedColumnName = "id_persona")
    @ManyToOne(optional = false)
    private Personas idPersona;
    @JoinColumn(name = "id_dependencia", referencedColumnName = "id_dependencia")
    @ManyToOne(optional = false)
    private Dependencias idDependencia;
    @JoinColumn(name = "id_area", referencedColumnName = "id_area")
    @ManyToOne(optional = false)
    private Areas idArea;

    public Usuarios() {
    }

    public Usuarios(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Usuarios(Integer idUsuario, String usuario, String contrasena, boolean habilitado) {
        this.idUsuario = idUsuario;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.habilitado = habilitado;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean getHabilitado() {
        return habilitado;
    }

    public void setHabilitado(boolean habilitado) {
        this.habilitado = habilitado;
    }

    public Integer getIntentos() {
        return intentos;
    }

    public void setIntentos(Integer intentos) {
        this.intentos = intentos;
    }

    public Boolean getJefeArea() {
        return jefeArea;
    }

    public void setJefeArea(Boolean jefeArea) {
        this.jefeArea = jefeArea;
    }

    public String getIdBonita() {
        return idBonita;
    }

    public void setIdBonita(String idBonita) {
        this.idBonita = idBonita;
    }

    @XmlTransient
    public Collection<Comisiones> getComisionesCollection() {
        return comisionesCollection;
    }

    public void setComisionesCollection(Collection<Comisiones> comisionesCollection) {
        this.comisionesCollection = comisionesCollection;
    }

    @XmlTransient
    public Collection<JerarquiaMiembros> getJerarquiaMiembrosCollection() {
        return jerarquiaMiembrosCollection;
    }

    public void setJerarquiaMiembrosCollection(Collection<JerarquiaMiembros> jerarquiaMiembrosCollection) {
        this.jerarquiaMiembrosCollection = jerarquiaMiembrosCollection;
    }

    @XmlTransient
    public Collection<SesionesLogin> getSesionesLoginCollection() {
        return sesionesLoginCollection;
    }

    public void setSesionesLoginCollection(Collection<SesionesLogin> sesionesLoginCollection) {
        this.sesionesLoginCollection = sesionesLoginCollection;
    }

    public Perfiles getIdPerfil() {
        return idPerfil;
    }

    public void setIdPerfil(Perfiles idPerfil) {
        this.idPerfil = idPerfil;
    }

    public Personas getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(Personas idPersona) {
        this.idPersona = idPersona;
    }

    public Dependencias getIdDependencia() {
        return idDependencia;
    }

    public void setIdDependencia(Dependencias idDependencia) {
        this.idDependencia = idDependencia;
    }

    public Areas getIdArea() {
        return idArea;
    }

    public void setIdArea(Areas idArea) {
        this.idArea = idArea;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idUsuario != null ? idUsuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuarios)) {
            return false;
        }
        Usuarios other = (Usuarios) object;
        if ((this.idUsuario == null && other.idUsuario != null) || (this.idUsuario != null && !this.idUsuario.equals(other.idUsuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mx.org.inai.viajesclaros.entities.Usuarios[ idUsuario=" + idUsuario + " ]";
    }
    
}
