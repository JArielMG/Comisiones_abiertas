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
import mx.org.inai.viajesclaros.admin.ejb.CargaMasivaService;
import mx.org.inai.viajesclaros.admin.ejb.DependenciaService;
import mx.org.inai.viajesclaros.admin.ejb.TablaCampoService;
import mx.org.inai.viajesclaros.domain.CargaColumnDomain;
import mx.org.inai.viajesclaros.domain.DependenciaDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.TablaCampoDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;
import org.apache.log4j.Logger;

/**
 * Controller para la pantalla de parametrización de carga masiva.
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class CargaController {

    @EJB
    DependenciaService dependenciaService;
    @EJB
    CargaMasivaService cargaMasivaService;
    @EJB
    TablaCampoService tablaCampoService;

    private Integer idDependencia;
    private List<ViajeDomain> viajes;
    private List<TablaCampoDomain> camposPorTabla;
    private List<CargaColumnDomain> headers;
    private List<SimpleElementDomain> tablas;
    private List<DependenciaDomain> dependencias;
    private CargaColumnDomain columnEdit;
    private CargaColumnDomain columnInsert;
    private CargaColumnDomain columnToDelete;
    private DependenciaDomain selectedDependencia;
    final static Logger log = Logger.getLogger(CargaController.class);

    @PostConstruct
    public void init() {
        setIdDependencia((Integer) 1);
        columnEdit = new CargaColumnDomain();
        columnInsert = new CargaColumnDomain();
        columnToDelete = new CargaColumnDomain();
        try {
            setDependencias(dependenciaService.findAll());
            setSelectedDependencia(dependencias.get(0));
            setHeaders(cargaMasivaService.getEncabezadoCarga(idDependencia));
            setTablas(tablaCampoService.findTablasCargaDisponibles(idDependencia));
            setCamposPorTabla(tablaCampoService.findCamposCargaPorTabla(idDependencia, tablas.get(0).getDescripcion()));
            setViajes(cargaMasivaService.findViajesByDependenciaCarga(idDependencia));
        } catch (Exception e) {
            log.error("ERROR EN POSTCONSTRUCTOR", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al cargar los datos."));
        }
    }

    public void reinit() {
        try {
            columnEdit = new CargaColumnDomain();
            columnInsert = new CargaColumnDomain();
            columnToDelete = new CargaColumnDomain();
            setHeaders(cargaMasivaService.getEncabezadoCarga(idDependencia));
            setTablas(tablaCampoService.findTablasCargaDisponibles(idDependencia));
            setCamposPorTabla(tablaCampoService.findCamposCargaPorTabla(idDependencia, tablas.get(0).getDescripcion()));
            setViajes(cargaMasivaService.findViajesByDependenciaCarga(idDependencia));
        } catch (Exception e) {
            log.error("ERROR EN REINIT", e);
        }
    }
    
    public void reinitValorInsert() {
        this.columnInsert = new CargaColumnDomain();
    }

    public void changeDependencia() {
        for (DependenciaDomain dep : dependencias) {
            if (dep.getId().equals(this.getIdDependencia())) {
                setSelectedDependencia(dep);
                /* Reiniciar los datos */
                try {
                    setHeaders(cargaMasivaService.getEncabezadoCarga(idDependencia));
                    setTablas(tablaCampoService.findTablasCargaDisponibles(idDependencia));
                    setCamposPorTabla(tablaCampoService.findCamposCargaPorTabla(idDependencia, tablas.get(0).getDescripcion()));
                    setViajes(cargaMasivaService.findViajesByDependenciaCarga(idDependencia));
                } catch (Exception e) {
                    log.error("ERROR AL CONSULTAR LOS DATOS DE LA DEPENDENCIA", e);
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                            "Error!", "Error al consultar los datos de la dependencia."));
                }
            }
        }
    }

    public void changeTabla() {
        if (this.columnInsert.getTabla() == null) {
            this.columnInsert.setTabla("");
        }
        try {
            setCamposPorTabla(tablaCampoService.findCamposCargaPorTabla(idDependencia, this.columnInsert.getTabla()));
            this.columnInsert.setCampo(camposPorTabla.get(0).getCampo());
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS POR TABLA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los campos de la tabla seleccionada. "));
        }
    }

    /**
     * Guarda la nueva columna
     */
    public void saveColumn() {
        try {
            if (this.columnInsert.getTabla() == null) {
                this.columnInsert.setTabla("");
            }
            this.columnInsert.setIdDependencia(idDependencia);
            this.columnInsert.setEditable(true);
            cargaMasivaService.saveColumn(columnInsert);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se agregó la nueva columna."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch (Exception e) {
            log.error("ERROR AL GUARDAR LA NUEVA COLUMNA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al guardar la nueva columna. "));
        }
    }
    
    public void deleteColumn() {
        try {
            this.columnToDelete.setIdDependencia(idDependencia);
            cargaMasivaService.deleteColumn(columnToDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó la columna " + columnToDelete.getDespliegue() + "."));
            /* Reiniciar la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR LA COLUMNA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al eliminar la columna. "));
        }
    }
    
    public void updateColumn() {
        try {
            if (this.columnEdit.getTabla() == null) {
                this.columnEdit.setTabla("");
            }
            this.columnEdit.setIdDependencia(idDependencia);
            cargaMasivaService.updateColumn(columnEdit);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se actualizó la columna " + columnEdit.getDespliegue() + "."));
            /* Reiniciar la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR LA COLUMNA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al actualizar la columna. "));
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
     * @return the headers
     */
    public List<CargaColumnDomain> getHeaders() {
        return headers;
    }

    /**
     * @param headers the headers to set
     */
    public void setHeaders(List<CargaColumnDomain> headers) {
        this.headers = headers;
    }

    /**
     * @return the columnToDelete
     */
    public CargaColumnDomain getColumnToDelete() {
        return columnToDelete;
    }

    /**
     * @param columnToDelete the columnToDelete to set
     */
    public void setColumnToDelete(CargaColumnDomain columnToDelete) {
        this.columnToDelete = columnToDelete;
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
     * @return the columnInsert
     */
    public CargaColumnDomain getColumnInsert() {
        return columnInsert;
    }

    /**
     * @param columnInsert the columnInsert to set
     */
    public void setColumnInsert(CargaColumnDomain columnInsert) {
        this.columnInsert = columnInsert;
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
     * @return the camposPorTabla
     */
    public List<TablaCampoDomain> getCamposPorTabla() {
        return camposPorTabla;
    }

    /**
     * @param camposPorTabla the camposPorTabla to set
     */
    public void setCamposPorTabla(List<TablaCampoDomain> camposPorTabla) {
        this.camposPorTabla = camposPorTabla;
    }

    /**
     * @return the columnEdit
     */
    public CargaColumnDomain getColumnEdit() {
        return columnEdit;
    }

    /**
     * @param columnEdit the columnEdit to set
     */
    public void setColumnEdit(CargaColumnDomain columnEdit) {
        this.columnEdit = columnEdit;
    }
}
