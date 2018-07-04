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
import mx.org.inai.viajesclaros.admin.ejb.TablaCampoService;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.TablaCampoDomain;
import org.apache.log4j.Logger;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class TablaCampoController {
    
    @EJB
    TablaCampoService tablaCampoService;
    private List<TablaCampoDomain> tablaCampoList;
    private List<TablaCampoDomain> camposConfig;
    private List<SimpleElementDomain> tablas;
    private TablaCampoDomain tablaCampoInsert;
    private TablaCampoDomain tablaCampoDelete;
    private String tablaSelected;
    final static Logger log = Logger.getLogger(TablaCampoController.class);
    
    @PostConstruct
    public void init() {
        try {
            tablaCampoInsert = new TablaCampoDomain();
            setTablas(tablaCampoService.findTablas());
            setTablaCampoList(tablaCampoService.findAll());
            setCamposConfig(tablaCampoService.findCamposConfigDisponibles());
        } catch(Exception e) {
            log.error("Error al cargar los datos iniciales. ", e);
        }
    }
    
    /** 
     * Lógica para actualizar los datos de la pantalla, 
     * dependiendo de si se ha seleccionado o no una tabla
     */
    private void reinit() {
        try {
            tablaCampoInsert = new TablaCampoDomain();
            tablaCampoDelete = new TablaCampoDomain();
            if (tablaSelected == null) {
                setTablaCampoList(tablaCampoService.findAll());
                setCamposConfig(tablaCampoService.findCamposConfigDisponibles());
            } else {
                setTablaCampoList(tablaCampoService.findCamposConfigPorTabla(
                        tablaSelected.equals("CAMPOS_DINAMICOS")?"":tablaSelected));
                setCamposConfig(tablaCampoService.findCamposConfigDisponiblesPorTabla(
                        tablaSelected.equals("CAMPOS_DINAMICOS")?"":tablaSelected));
            }
        } catch(Exception e) {
            log.error("ERROR AL REINICIAR LOS VALORES DE LA PANTALLA (reinit).");
        }
    }
    
    /**
     * Se ejecuta al seleccionar del filtro por tablas
     */
    public void changeTabla() {
        reinit();
    }
    
    /**
     * Agrega un registro tabla-campo
     */
    public void insertTablaCampo() {
        try {
            if (tablaCampoInsert.getTabla() == null) {
                tablaCampoInsert.setTabla("");
            }
            tablaCampoService.save(tablaCampoInsert);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se agregó el campo."));
            /* Reiniciar */
            reinit();
        } catch(Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al guardar el campo."));
        }
    }
    
    /**
     * Elimina un registro tabla-campo
     */
    public void removeTablaCampo() {
        try {
            if (tablaCampoInsert.getTabla() == null) {
                tablaCampoInsert.setTabla("");
            }
            tablaCampoService.delete(tablaCampoDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó el campo."));
            /* Reiniciar */
            reinit();
        } catch(Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", e.getMessage()));
        }
    }
    
    /**
     * @return the tablaCampoList
     */
    public List<TablaCampoDomain> getTablaCampoList() {
        return tablaCampoList;
    }

    /**
     * @param tablaCampoList the tablaCampoList to set
     */
    public void setTablaCampoList(List<TablaCampoDomain> tablaCampoList) {
        this.tablaCampoList = tablaCampoList;
    }

    /**
     * @return the camposConfig
     */
    public List<TablaCampoDomain> getCamposConfig() {
        return camposConfig;
    }

    /**
     * @param camposConfig the camposConfig to set
     */
    public void setCamposConfig(List<TablaCampoDomain> camposConfig) {
        this.camposConfig = camposConfig;
    }

    /**
     * @return the tablaCampoInsert
     */
    public TablaCampoDomain getTablaCampoInsert() {
        return tablaCampoInsert;
    }

    /**
     * @param tablaCampoInsert the tablaCampoInsert to set
     */
    public void setTablaCampoInsert(TablaCampoDomain tablaCampoInsert) {
        this.tablaCampoInsert = tablaCampoInsert;
    }

    /**
     * @return the tablaCampoDelete
     */
    public TablaCampoDomain getTablaCampoDelete() {
        return tablaCampoDelete;
    }

    /**
     * @param tablaCampoDelete the tablaCampoDelete to set
     */
    public void setTablaCampoDelete(TablaCampoDomain tablaCampoDelete) {
        this.tablaCampoDelete = tablaCampoDelete;
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
     * @return the tablaSelected
     */
    public String getTablaSelected() {
        return tablaSelected;
    }

    /**
     * @param tablaSelected the tablaSelected to set
     */
    public void setTablaSelected(String tablaSelected) {
        this.tablaSelected = tablaSelected;
    }

}
