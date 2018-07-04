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
import mx.org.inai.viajesclaros.admin.ejb.FiltroBusquedaService;
import mx.org.inai.viajesclaros.admin.ejb.TablaCampoService;
import mx.org.inai.viajesclaros.admin.ejb.ViajeService;
import mx.org.inai.viajesclaros.domain.CampoDomain;
import mx.org.inai.viajesclaros.domain.DependenciaDomain;
import mx.org.inai.viajesclaros.domain.DespliegueBusquedaDomain;
import mx.org.inai.viajesclaros.domain.FiltroBusquedaDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;

/**
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class FiltroBusquedaController implements java.io.Serializable {

    @EJB
    FiltroBusquedaService filtroService;
    @EJB
    DependenciaService dependenciaService;
    @EJB
    ViajeService viajeService;
    @EJB
    TablaCampoService tablaCampoService;
    private List<ViajeDomain> viajes;
    private List<DespliegueBusquedaDomain> headers;
    private List<FiltroBusquedaDomain> filtros;
    private List<DependenciaDomain> dependencias;
    private List<SimpleElementDomain> comparadores;
    private List<SimpleElementDomain> tablas;
    private List<SimpleElementDomain> tablasDespliegue; // sólo las tablas que tienen campos disponibles
    private List<CampoDomain> campos;
    private List<CampoDomain> camposDespliegue;
    private Integer idDependencia;
    private DependenciaDomain selectedDependencia;
    private FiltroBusquedaDomain selectedFiltro;
    private FiltroBusquedaDomain insertFiltro;
    private FiltroBusquedaDomain filtroToDelete;
    private CampoDomain selectedCampo;
    private DespliegueBusquedaDomain despliegueToDelete;
    private DespliegueBusquedaDomain despliegueInsert;

    @PostConstruct
    public void init() {
        idDependencia = 1;
        insertFiltro = new FiltroBusquedaDomain();
        filtroToDelete = new FiltroBusquedaDomain();
        despliegueInsert = new DespliegueBusquedaDomain();
        try {
            setViajes(viajeService.findAllByDependencia(idDependencia));
            setHeaders(viajeService.getEncabezadoViajes(idDependencia));
            setFiltros(filtroService.getFiltrosByDependencia(idDependencia));
            setDependencias(dependenciaService.findAll());
            setSelectedDependencia(dependencias.get(0));
            setTablas(tablaCampoService.findTablasFiltrosDisponibles(idDependencia));
            setTablasDespliegue(tablaCampoService.findTablasDespliegueDisponibles(idDependencia));
            setCampos(tablaCampoService.findFiltrosDispobibles(idDependencia, tablas.get(0).getDescripcion()));
            setCamposDespliegue(tablaCampoService.findCamposDespliegueDispobibles(idDependencia, tablas.get(0).getDescripcion()));
            setSelectedCampo(campos.get(0));
            setComparadores(filtroService.getCatalogoComparador());
        } catch (Exception e) {
            System.out.println("Error en el postconstructor. " + e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. " + e.getMessage()));
        }
    }

    /**
     * Se ejecuta cuando se cambia la dependencia
     */
    public void changeDependencia() {
        for (DependenciaDomain dep : dependencias) {
            if (dep.getId().equals(this.idDependencia)) {
                setSelectedDependencia(dep);
                insertFiltro = new FiltroBusquedaDomain();
                filtroToDelete = new FiltroBusquedaDomain();
                try {
                    /* Reiniciar todos los datos */
                    setViajes(viajeService.findAllByDependencia(idDependencia));
                    setHeaders(viajeService.getEncabezadoViajes(idDependencia));
                    setFiltros(filtroService.getFiltrosByDependencia(idDependencia));
                    setTablas(tablaCampoService.findTablasFiltrosDisponibles(idDependencia));
                    setTablasDespliegue(tablaCampoService.findTablasDespliegueDisponibles(idDependencia));
                    setCampos(tablaCampoService.findFiltrosDispobibles(idDependencia, tablas.get(0).getDescripcion()));
                    setCamposDespliegue(tablaCampoService.findCamposDespliegueDispobibles(idDependencia, tablas.get(0).getDescripcion()));
                    setSelectedCampo(campos.get(0));
                } catch (Exception e) {
                    System.out.println("Error al consultar los datos de la dependencia. " + e.getMessage());
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los datos de la dependencia. " + e.getMessage()));
                }
            }
        }
    }

    /**
     * Se ejecuta cuando se selecciona una tabla; para actualizar la lista de campos
     */
    public void changeTabla() {
        if (this.insertFiltro.getTabla() == null) {
            this.insertFiltro.setTabla("");
        }
        try {
            setCampos(tablaCampoService.findFiltrosDispobibles(idDependencia, this.insertFiltro.getTabla()));
            setSelectedCampo(campos.get(0));
            this.insertFiltro.setCampo(campos.get(0).getCampo());
        } catch (Exception e) {
            System.out.println("Error al consultar los campos disponibles. " + e.getMessage());
        }
    }

    /**
     * Se ejecuta cuando se selecciona una tabla, en el dialog de agregar campo de resultado
     */
    public void changeTablaDespliegue() {
        if (this.despliegueInsert.getTabla() == null) {
            this.despliegueInsert.setTabla("");
        }
        try {
            setCamposDespliegue(tablaCampoService.findCamposDespliegueDispobibles(idDependencia, this.despliegueInsert.getTabla()));
            this.despliegueInsert.setCampo(campos.get(0).getCampo());
        } catch (Exception e) {
            System.out.println("Error al consultar los campos disponibles. " + e.getMessage());
        }
    }

    /**
     * Se ejcecuta cuando se selecciona un campo; para actualizar el tipo de dato y tipo de control
     */
    public void changeCampo() {
        for (CampoDomain campo : campos) {
            if (campo.getCampo().equals(this.insertFiltro.getCampo())) {
                setSelectedCampo(campo);
            }
        }
    }

    /**
     * Guarda el nuevo filtro de búsqueda
     */
    public void saveFiltro() {
        try {
            if (this.insertFiltro.getTabla() == null) {
                this.insertFiltro.setTabla("");
            }
            insertFiltro.setIdDependencia(idDependencia);
            filtroService.saveFiltroBusqueda(insertFiltro);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se agregó el filtro de búsqueda."));
            /* Volver a consultar los filtros */
            setFiltros(filtroService.getFiltrosByDependencia(this.idDependencia));
            /* Actualizar las listas de filtros disponibles y campos */
            insertFiltro = new FiltroBusquedaDomain();
            setTablas(tablaCampoService.findTablasFiltrosDisponibles(idDependencia));
            setCampos(tablaCampoService.findFiltrosDispobibles(idDependencia, tablas.get(0).getDescripcion()));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al guardar el filtro de búsqueda. " + e.getMessage()));
        }
    }

    /**
     * Elimina el filtro de búsqueda para la dependencia seleccionada
     */
    public void deleteFiltro() {
        try {
            this.filtroToDelete.setIdDependencia(idDependencia);
            this.filtroService.deleteFiltroBusqueda(filtroToDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó el filtro de búsqueda."));
            /* Volver a consultar los filtros */
            setFiltros(filtroService.getFiltrosByDependencia(this.idDependencia));
            /* Actualizar las listas de tablas y campos disponibles */
            setTablas(tablaCampoService.findTablasFiltrosDisponibles(idDependencia));
            setCampos(tablaCampoService.findFiltrosDispobibles(idDependencia, tablas.get(0).getDescripcion()));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al eliminar el filtro de búsqueda. " + e.getMessage()));
        }
    }

    /**
     * Elimina la columna de resultados parametrizada para la dependencia seleccionada
     */
    public void deleteResult() {
        try {
            this.filtroService.deleteDespliegueBusqueda(despliegueToDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó la columna de resultados."));
            /* Volver a consultar los viajes */
            setHeaders(viajeService.getEncabezadoViajes(idDependencia));
            setViajes(viajeService.findAllByDependencia(idDependencia));
            /* Actualizar las tablas y campos disponibles */
            setTablasDespliegue(tablaCampoService.findTablasDespliegueDisponibles(idDependencia));
            setCamposDespliegue(tablaCampoService.findCamposDespliegueDispobibles(idDependencia, tablas.get(0).getDescripcion()));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al eliminar la columna de resultados. " + e.getMessage()));
        }
    }

    /**
     * Agrega una columna de resultados parametrizada para la dependencia seleccionada
     */
    public void addResult() {
        try {
            despliegueInsert.setIdDependencia(idDependencia);
            if (this.despliegueInsert.getTabla() == null) {
                this.despliegueInsert.setTabla("");
            }
            this.filtroService.saveDespliegueBusqueda(despliegueInsert);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se agregó la columna de resultados."));
            /* Volver a consultar los viajes */
            setHeaders(viajeService.getEncabezadoViajes(idDependencia));
            setViajes(viajeService.findAllByDependencia(idDependencia));
            /* Actualizar las tablas y campos disponibles */
            this.despliegueInsert = new DespliegueBusquedaDomain();
            setTablasDespliegue(tablaCampoService.findTablasDespliegueDisponibles(idDependencia));
            setCamposDespliegue(tablaCampoService.findCamposDespliegueDispobibles(idDependencia, tablas.get(0).getDescripcion()));

        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al agregar la columna de resultados. " + e.getMessage()));
        }
    }

    /**
     * @return the filtros
     */
    public List<FiltroBusquedaDomain> getFiltros() {
        return filtros;
    }

    /**
     * @param filtros the filtros to set
     */
    public void setFiltros(List<FiltroBusquedaDomain> filtros) {
        this.filtros = filtros;
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
     * @return the selectedFiltro
     */
    public FiltroBusquedaDomain getSelectedFiltro() {
        return selectedFiltro;
    }

    /**
     * @param selectedFiltro the selectedFiltro to set
     */
    public void setSelectedFiltro(FiltroBusquedaDomain selectedFiltro) {
        this.selectedFiltro = selectedFiltro;
    }

    /**
     * @return the viajes
     */
    public List<ViajeDomain> getViajes() {
        return viajes;
    }

    /**
     * @param viajes the viajes to set
     */
    public void setViajes(List<ViajeDomain> viajes) {
        this.viajes = viajes;
    }

    /**
     * @return the headers
     */
    public List<DespliegueBusquedaDomain> getHeaders() {
        return headers;
    }

    /**
     * @param headers the headers to set
     */
    public void setHeaders(List<DespliegueBusquedaDomain> headers) {
        this.headers = headers;
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
     * @return the tablas
     */
    public List<SimpleElementDomain> getTablas() {
        return tablas;
    }

    /**
     * @param tablas the tablas to set
     */
    public void setTablas(List<SimpleElementDomain> tablas) {
        this.tablas = tablas;
    }

    /**
     * @return the campos
     */
    public List<CampoDomain> getCampos() {
        return campos;
    }

    /**
     * @param campos the campos to set
     */
    public void setCampos(List<CampoDomain> campos) {
        this.campos = campos;
    }

    /**
     * @return the selectedCampo
     */
    public CampoDomain getSelectedCampo() {
        return selectedCampo;
    }

    /**
     * @param selectedCampo the selectedCampo to set
     */
    public void setSelectedCampo(CampoDomain selectedCampo) {
        this.selectedCampo = selectedCampo;
    }

    /**
     * @return the comparadores
     */
    public List<SimpleElementDomain> getComparadores() {
        return comparadores;
    }

    /**
     * @param comparadores the comparadores to set
     */
    public void setComparadores(List<SimpleElementDomain> comparadores) {
        this.comparadores = comparadores;
    }

    /**
     * @return the insertFiltro
     */
    public FiltroBusquedaDomain getInsertFiltro() {
        return insertFiltro;
    }

    /**
     * @param insertFiltro the insertFiltro to set
     */
    public void setInsertFiltro(FiltroBusquedaDomain insertFiltro) {
        this.insertFiltro = insertFiltro;
    }

    /**
     * @return the deleteFiltro
     */
    public FiltroBusquedaDomain getFiltroToDelete() {
        return filtroToDelete;
    }

    /**
     * @param filtroToDelete the deleteFiltro to set
     */
    public void setFiltroToDelete(FiltroBusquedaDomain filtroToDelete) {
        this.filtroToDelete = filtroToDelete;
    }

    /**
     * @return the despliegueToDelete
     */
    public DespliegueBusquedaDomain getDespliegueToDelete() {
        return despliegueToDelete;
    }

    /**
     * @param despliegueToDelete the despliegueToDelete to set
     */
    public void setDespliegueToDelete(DespliegueBusquedaDomain despliegueToDelete) {
        this.despliegueToDelete = despliegueToDelete;
    }

    /**
     * @return the despliegueInsert
     */
    public DespliegueBusquedaDomain getDespliegueInsert() {
        return despliegueInsert;
    }

    /**
     * @param despliegueInsert the despliegueInsert to set
     */
    public void setDespliegueInsert(DespliegueBusquedaDomain despliegueInsert) {
        this.despliegueInsert = despliegueInsert;
    }

    /**
     * @return the camposDespliegue
     */
    public List<CampoDomain> getCamposDespliegue() {
        return camposDespliegue;
    }

    /**
     * @param camposDespliegue the camposDespliegue to set
     */
    public void setCamposDespliegue(List<CampoDomain> camposDespliegue) {
        this.camposDespliegue = camposDespliegue;
    }

    /**
     * @return the tablasDespliegue
     */
    public List<SimpleElementDomain> getTablasDespliegue() {
        return tablasDespliegue;
    }

    /**
     * @param tablasDespliegue the tablasDespliegue to set
     */
    public void setTablasDespliegue(List<SimpleElementDomain> tablasDespliegue) {
        this.tablasDespliegue = tablasDespliegue;
    }

}
