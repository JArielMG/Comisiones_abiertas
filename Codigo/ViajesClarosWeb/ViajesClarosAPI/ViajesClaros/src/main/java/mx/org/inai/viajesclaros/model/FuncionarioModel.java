/*
 * Copyright (C) 2015 sandro
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
package mx.org.inai.viajesclaros.model;

import java.sql.Date;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author sandro
 */
@XmlRootElement
public class FuncionarioModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private Integer idDependencia;
    private String dependencia;
    private String nombres;
    private String apellido1;
    private String apellido2;
    private String nombreCompleto;
    private String titulo;
    private String email;
    private Integer idCategoria;
    private String categoria;
    private Integer idTipoPersona;
    private String tipoPersona;
    private Integer idArea;
    private String area;
    private String cargo;
    private Integer totalViajes;
    private Double totalGasto;
    private Date fechaIngreso;
    private Double viajeMasCostoso;
    private Integer idViajeMasCostoso;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the nombres
     */
    public String getNombres() {
        return nombres;
    }

    /**
     * @param nombres the nombres to set
     */
    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    /**
     * @return the apellido1
     */
    public String getApellido1() {
        return apellido1;
    }

    /**
     * @param apellido1 the apellido1 to set
     */
    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    /**
     * @return the apellido2
     */
    public String getApellido2() {
        return apellido2;
    }

    /**
     * @param apellido2 the apellido2 to set
     */
    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the idCategoria
     */
    public Integer getIdCategoria() {
        return idCategoria;
    }

    /**
     * @param idCategoria the idCategoria to set
     */
    public void setIdCategoria(Integer idCategoria) {
        this.idCategoria = idCategoria;
    }

    /**
     * @return the categoria
     */
    public String getCategoria() {
        return categoria;
    }

    /**
     * @param categoria the categoria to set
     */
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    /**
     * @return the idTipoPersona
     */
    public Integer getIdTipoPersona() {
        return idTipoPersona;
    }

    /**
     * @param idTipoPersona the idTipoPersona to set
     */
    public void setIdTipoPersona(Integer idTipoPersona) {
        this.idTipoPersona = idTipoPersona;
    }

    /**
     * @return the tipoPersona
     */
    public String getTipoPersona() {
        return tipoPersona;
    }

    /**
     * @param tipoPersona the tipoPersona to set
     */
    public void setTipoPersona(String tipoPersona) {
        this.tipoPersona = tipoPersona;
    }

    /**
     * @return the idArea
     */
    public Integer getIdArea() {
        return idArea;
    }

    /**
     * @param idArea the idArea to set
     */
    public void setIdArea(Integer idArea) {
        this.idArea = idArea;
    }

    /**
     * @return the area
     */
    public String getArea() {
        return area;
    }

    /**
     * @param area the area to set
     */
    public void setArea(String area) {
        this.area = area;
    }

    /**
     * @return the idDependencia
     */
    public Integer getIdDependencia() {
        return idDependencia;
    }

    /**
     * @param idDependencia the idDependencia to set
     */
    public void setIdDependencia(Integer idDependencia) {
        this.idDependencia = idDependencia;
    }

    /**
     * @return the cargo
     */
    public String getCargo() {
        return cargo;
    }

    /**
     * @param cargo the cargo to set
     */
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    /**
     * @return the totalViajes
     */
    public Integer getTotalViajes() {
        return totalViajes;
    }

    /**
     * @param totalViajes the totalViajes to set
     */
    public void setTotalViajes(Integer totalViajes) {
        this.totalViajes = totalViajes;
    }

    /**
     * @return the totalGasto
     */
    public Double getTotalGasto() {
        return totalGasto;
    }

    /**
     * @param totalGasto the totalGasto to set
     */
    public void setTotalGasto(Double totalGasto) {
        this.totalGasto = totalGasto;
    }

    /**
     * @return the dependencia
     */
    public String getDependencia() {
        return dependencia;
    }

    /**
     * @param dependencia the dependencia to set
     */
    public void setDependencia(String dependencia) {
        this.dependencia = dependencia;
    }

    /**
     * @return the nombreCompleto
     */
    public String getNombreCompleto() {
        return nombreCompleto;
    }

    /**
     * @param nombreCompleto the nombreCompleto to set
     */
    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    /**
     * @return the fechaIngreso
     */
    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    /**
     * @param fechaIngreso the fechaIngreso to set
     */
    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    /**
     * @return the viajeMasCostoso
     */
    public Double getViajeMasCostoso() {
        return viajeMasCostoso;
    }

    /**
     * @param viajeMasCostoso the viajeMasCostoso to set
     */
    public void setViajeMasCostoso(Double viajeMasCostoso) {
        this.viajeMasCostoso = viajeMasCostoso;
    }

    /**
     * @return the idViajeMasCostoso
     */
    public Integer getIdViajeMasCostoso() {
        return idViajeMasCostoso;
    }

    /**
     * @param idViajeMasCostoso the idViajeMasCostoso to set
     */
    public void setIdViajeMasCostoso(Integer idViajeMasCostoso) {
        this.idViajeMasCostoso = idViajeMasCostoso;
    }
}
