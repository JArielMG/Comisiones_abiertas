/*
 * Copyright (C) 2015 INAI
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
package mx.org.inai.viajesclaros.admin.controllers;

import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import mx.org.inai.viajesclaros.admin.ejb.CampoDinamicoService;
import mx.org.inai.viajesclaros.admin.ejb.DependenciaService;
import mx.org.inai.viajesclaros.admin.ejb.SuscripcionService;
import mx.org.inai.viajesclaros.domain.DependenciaDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.SuscripcionCampoDomain;
import org.apache.log4j.Logger;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class SuscripcionController {

    @EJB
    DependenciaService dependenciaService;
    @EJB
    CampoDinamicoService campoDinamicoService;
    @EJB
    SuscripcionService suscripcionService;
    private List<DependenciaDomain> dependencias;
    private List<SimpleElementDomain> categorias;
    private DependenciaDomain selectedDependencia;
    private List<SuscripcionCampoDomain> camposComision;
    private List<SuscripcionCampoDomain> camposFuncionario;
    private List<SuscripcionCampoDomain> camposTipoViaje;
    private List<SuscripcionCampoDomain> camposEvento;
    private List<SuscripcionCampoDomain> camposViaticos;
    private List<SuscripcionCampoDomain> camposInforme;
    private List<SuscripcionCampoDomain> camposVuelo;
    private List<SuscripcionCampoDomain> camposObservaciones;
    private Integer idDependencia;
    private Boolean disabledGuardar;
    final static Logger log = Logger.getLogger(SuscripcionController.class);

    @PostConstruct
    public void init() {
        idDependencia = 1;
        setDisabledGuardar((Boolean) true);
        try {
            setDependencias(dependenciaService.findAll());
            setCategorias(campoDinamicoService.gatCategorias());
            setSelectedDependencia(dependencias.get(0));

            /* Consultar los campos por cada categoría */
            configByDependencia();
        } catch (Exception e) {
            log.error("ERROR EN EL POSTCONSTRUCTOR. ", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. "));
        }
    }

    private void scrollToTop() {
        RequestContext.getCurrentInstance().execute("window.scrollTo(0,0);");
    }
    
    /* Consulta los campos configurados por dependencia */
    private void configByDependencia() throws Exception {
        camposComision = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "comision");
        camposFuncionario = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "funcionario");
        camposTipoViaje = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "tipo_viaje");
        camposEvento = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "evento");
        camposViaticos = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "viaticos");
        camposInforme = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "informe_comision");
        camposVuelo = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "informacion_vuelo");
        camposObservaciones = suscripcionService.getCamposSuscripcionPorCat(idDependencia, "observaciones");
    }

    public void changeDependencia() {
        for (DependenciaDomain dep : dependencias) {
            if (dep.getId().equals(this.getIdDependencia())) {
                setSelectedDependencia(dep);
                try {
                    configByDependencia();
                } catch (Exception e) {
                    log.error("Error al consultar los campos de la dependencia.", e);
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                            "Error!", "Error al consultar los campos de la dependencia. "));
                }
            }
        }
    }

    public void onCheckbox() {
        this.disabledGuardar = false;
    }

    /* Guardar la configuración de campos para la dependencia seleccionada */
    public void saveConfig() {
        try {
            suscripcionService.deleteSuscripcionPorDependencia(idDependencia);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposComision);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposFuncionario);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposTipoViaje);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposEvento);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposViaticos);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposInforme);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposVuelo);
            suscripcionService.saveCamposSuscripcion(idDependencia, camposObservaciones);
            scrollToTop();
            disabledGuardar = true;
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se guardó la parmetrización de suscripción para " + selectedDependencia.getSiglas()));
        } catch (Exception e) {
            log.error("Error al consultar los campos de la dependencia.", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los campos de la dependencia. "));
        }
    }

    /**
     * @return the dependencias
     */
    public List<DependenciaDomain> getDependencias() {
        return dependencias;
    }

    /**
     * @param dependencias the dependencias to set
     */
    public void setDependencias(List<DependenciaDomain> dependencias) {
        this.dependencias = dependencias;
    }

    /**
     * @return the categorias
     */
    public List<SimpleElementDomain> getCategorias() {
        return categorias;
    }

    /**
     * @param categorias the categorias to set
     */
    public void setCategorias(List<SimpleElementDomain> categorias) {
        this.categorias = categorias;
    }

    /**
     * @return the selectedDependencia
     */
    public DependenciaDomain getSelectedDependencia() {
        return selectedDependencia;
    }

    /**
     * @param selectedDependencia the selectedDependencia to set
     */
    public void setSelectedDependencia(DependenciaDomain selectedDependencia) {
        this.selectedDependencia = selectedDependencia;
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
     * @return the camposComision
     */
    public List<SuscripcionCampoDomain> getCamposComision() {
        return camposComision;
    }

    /**
     * @param camposComision the camposComision to set
     */
    public void setCamposComision(List<SuscripcionCampoDomain> camposComision) {
        this.camposComision = camposComision;
    }

    /**
     * @return the camposFuncionario
     */
    public List<SuscripcionCampoDomain> getCamposFuncionario() {
        return camposFuncionario;
    }

    /**
     * @param camposFuncionario the camposFuncionario to set
     */
    public void setCamposFuncionario(List<SuscripcionCampoDomain> camposFuncionario) {
        this.camposFuncionario = camposFuncionario;
    }

    /**
     * @return the camposTipoViaje
     */
    public List<SuscripcionCampoDomain> getCamposTipoViaje() {
        return camposTipoViaje;
    }

    /**
     * @param camposTipoViaje the camposTipoViaje to set
     */
    public void setCamposTipoViaje(List<SuscripcionCampoDomain> camposTipoViaje) {
        this.camposTipoViaje = camposTipoViaje;
    }

    /**
     * @return the camposEvento
     */
    public List<SuscripcionCampoDomain> getCamposEvento() {
        return camposEvento;
    }

    /**
     * @param camposEvento the camposEvento to set
     */
    public void setCamposEvento(List<SuscripcionCampoDomain> camposEvento) {
        this.camposEvento = camposEvento;
    }

    /**
     * @return the camposViaticos
     */
    public List<SuscripcionCampoDomain> getCamposViaticos() {
        return camposViaticos;
    }

    /**
     * @param camposViaticos the camposViaticos to set
     */
    public void setCamposViaticos(List<SuscripcionCampoDomain> camposViaticos) {
        this.camposViaticos = camposViaticos;
    }

    /**
     * @return the camposInforme
     */
    public List<SuscripcionCampoDomain> getCamposInforme() {
        return camposInforme;
    }

    /**
     * @param camposInforme the camposInforme to set
     */
    public void setCamposInforme(List<SuscripcionCampoDomain> camposInforme) {
        this.camposInforme = camposInforme;
    }

    /**
     * @return the camposVuelo
     */
    public List<SuscripcionCampoDomain> getCamposVuelo() {
        return camposVuelo;
    }

    /**
     * @param camposVuelo the camposVuelo to set
     */
    public void setCamposVuelo(List<SuscripcionCampoDomain> camposVuelo) {
        this.camposVuelo = camposVuelo;
    }

    /**
     * @return the camposObservaciones
     */
    public List<SuscripcionCampoDomain> getCamposObservaciones() {
        return camposObservaciones;
    }

    /**
     * @param camposObservaciones the camposObservaciones to set
     */
    public void setCamposObservaciones(List<SuscripcionCampoDomain> camposObservaciones) {
        this.camposObservaciones = camposObservaciones;
    }

    /**
     * @return the disabledGuardar
     */
    public Boolean getDisabledGuardar() {
        return disabledGuardar;
    }

    /**
     * @param disabledGuardar the disabledGuardar to set
     */
    public void setDisabledGuardar(Boolean disabledGuardar) {
        this.disabledGuardar = disabledGuardar;
    }

}
