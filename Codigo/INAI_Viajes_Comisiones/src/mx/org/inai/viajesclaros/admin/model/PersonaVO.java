package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name = "personas")
public class PersonaVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id_persona")
    private Integer id;
    private String nombres;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String titulo;
    private String email;
    private CategoriaVO categoria;
    private TipoPersonaVO tipoPersona;
    private PosicionVO posicion;
    private String cargo;
    private Integer numeroEmpleado;
    private String denominacionPuesto;
    private String clavePuesto;
    private String sexo;
    private String tipoRepresentacion;
    private Date fechaIngreso;
    private Integer tipoIntegrante;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public String getApellidoMaterno() {
        return apellidoMaterno;
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public CategoriaVO getCategoria() {
        return categoria;
    }

    public void setCategoria(CategoriaVO categoria) {
        this.categoria = categoria;
    }

    public TipoPersonaVO getTipoPersona() {
        return tipoPersona;
    }

    public void setTipoPersona(TipoPersonaVO tipoPersona) {
        this.tipoPersona = tipoPersona;
    }

    public PosicionVO getPosicion() {
        return posicion;
    }

    public void setPosicion(PosicionVO posicion) {
        this.posicion = posicion;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public Integer getNumeroEmpleado() {
        return numeroEmpleado;
    }

    public void setNumeroEmpleado(Integer numeroEmpleado) {
        this.numeroEmpleado = numeroEmpleado;
    }

    public String getDenominacionPuesto() {
        return denominacionPuesto;
    }

    public void setDenominacionPuesto(String denominacionPuesto) {
        this.denominacionPuesto = denominacionPuesto;
    }

    public String getClavePuesto() {
        return clavePuesto;
    }

    public void setClavePuesto(String clavePuesto) {
        this.clavePuesto = clavePuesto;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getTipoRepresentacion() {
        return tipoRepresentacion;
    }

    public void setTipoRepresentacion(String tipoRepresentacion) {
        this.tipoRepresentacion = tipoRepresentacion;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Integer getTipoIntegrante() {
        return tipoIntegrante;
    }

    public void setTipoIntegrante(Integer tipoIntegrante) {
        this.tipoIntegrante = tipoIntegrante;
    }
}
