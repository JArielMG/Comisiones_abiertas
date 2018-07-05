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
import mx.org.inai.viajesclaros.admin.ejb.DependenciaService;
import mx.org.inai.viajesclaros.admin.ejb.GraficaService;
import mx.org.inai.viajesclaros.domain.DependenciaDomain;
import mx.org.inai.viajesclaros.domain.GraficaDependenciaDomain;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class GraficasController {
    
    @EJB
    DependenciaService dependenciaService;
    @EJB
    GraficaService graficaService;
    private List<DependenciaDomain> dependencias;
    private List<GraficaDependenciaDomain> graficasDependencia;
    private DependenciaDomain selectedDependencia;
    private Integer idDependencia;
    private Boolean disabledGuardar;
    
    @PostConstruct
    public void init() {
        idDependencia = 4;
        setDisabledGuardar((Boolean) true);
        try {
            setDependencias(dependenciaService.findAll());
            setSelectedDependencia(dependencias.get(0));
            setGraficasDependencia(graficaService.findByDependencia(idDependencia));
        } catch(Exception e) {
            System.out.println("ERROR EN EL POSTCONSTRUCTOR. " + e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. "));
        }
    }
    
    public void changeDependencia() {
        this.disabledGuardar = true;
        for (DependenciaDomain dep : dependencias) {
            if (dep.getId().equals(this.getIdDependencia())) {
                setSelectedDependencia(dep);
                try {
                    setGraficasDependencia(graficaService.findByDependencia(idDependencia));
                } catch(Exception e) {
                    System.out.println("Error al consultar las gráficas de la dependencia." + e.getMessage());
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los datos de la dependencia. "));
                }
            }
        }
    }
    
    public void onClickCheckbox() {
        this.disabledGuardar = false;
    }
    
    /**
     * Guarda el listado de gráficas activas para la dependencia seleccionada
     */
    public void saveGraficasDependencia() {
        try {
            graficaService.saveGraficasDependencia(graficasDependencia);
            this.disabledGuardar = true;
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se guardó la parmetrización de gráficas para esta dependencia."));
        } catch(Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al guardar la parametrización de gráficas."));
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
     * @return the graficasDependencia
     */
    public List<GraficaDependenciaDomain> getGraficasDependencia() {
        return graficasDependencia;
    }

    /**
     * @param graficasDependencia the graficasDependencia to set
     */
    public void setGraficasDependencia(List<GraficaDependenciaDomain> graficasDependencia) {
        this.graficasDependencia = graficasDependencia;
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
