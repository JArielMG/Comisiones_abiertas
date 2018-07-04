/*
 * Copyright (C) 2016 victor.huerta
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
import mx.org.inai.viajesclaros.admin.ejb.GastosService;
import mx.org.inai.viajesclaros.admin.ejb.TablaCampoService;
import mx.org.inai.viajesclaros.domain.CamposGastosDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.TablaCampoDomain;
import org.apache.log4j.Logger;

/**
 *
 * @author victor.huerta
 */
@ManagedBean
@ViewScoped
public class GastosController {
    
    
    @EJB
    TablaCampoService tablaCampoService;
    @EJB
    GastosService gastosService;
    
    private CamposGastosDomain campoEdit;
    private CamposGastosDomain campoInsert;
    private CamposGastosDomain campoDelete;
    private List<TablaCampoDomain> camposPorTabla;
    private List<SimpleElementDomain> tablas;
    
    private List<CamposGastosDomain> camposEnTabla;
    
    final static Logger log = Logger.getLogger(GastosController.class);
    
    @PostConstruct
    public void init() {
        campoEdit = new CamposGastosDomain();
        campoInsert = new CamposGastosDomain();
        campoDelete = new CamposGastosDomain();
        try {
            setTablas(tablaCampoService.findTablas());
            setCamposPorTabla(tablaCampoService.findCamposConfigPorTabla(tablas.get(0).getDescripcion()));
            setCamposEnTabla(gastosService.getGastosCamposConfig());
        } catch (Exception e) {
            log.error("ERROR EN POST CONSTRUCTOR", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. "));
        }
    }
    
     /* Reinicia los datos de la pantalla */
    private void reinit() throws Exception {
        campoEdit = new CamposGastosDomain();
        campoInsert = new CamposGastosDomain();
        campoDelete = new CamposGastosDomain();
        setTablas(tablaCampoService.findTablas());
        setCamposPorTabla(tablaCampoService.findCamposConfigDisponiblesPorTabla(tablas.get(0).getDescripcion()));
        setCamposEnTabla(gastosService.getGastosCamposConfig());
    }
    
    public void reinitValorInsert() {
        this.campoInsert = new CamposGastosDomain();
    }
    
    public void reinitValorEdit() {
        this.campoEdit = new CamposGastosDomain();
    }
    
    /* Guarda un nuevo campo */
    public void saveColumn() {
        if (this.campoInsert.getTabla() == null) {
            this.campoInsert.setTabla("");
        }
        try {
            gastosService.saveGastoCampoConfig(campoInsert);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se agregó el campo " + campoInsert.getEtiqueta() + "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR EL CAMPO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al guardar el campo. "));
        }
    }
    
    /* Elimina un campo */
    public void deleteColumn() {
        if (this.campoDelete.getTabla() == null) {
            this.campoDelete.setTabla("");
        }
        try {
            gastosService.deleteGastoCampoConfig(campoDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se eliminó el campo " + campoDelete.getEtiqueta() + "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR EL CAMPO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al eliminar el campo. "));
        }
    }
    
    /* Actualiza los datos del campo */
    public void updateColumn() {
        if (this.campoEdit.getTabla() == null) {
            this.campoEdit.setTabla("");
        }
        try {
            gastosService.updateGastoCampoConfig(campoEdit);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se actualizó el campo " + campoEdit.getEtiqueta() + "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL CAMPO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al actualizar el campo. "));
        }
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
     * @return the camposPorTabla
     */
    public List<CamposGastosDomain> getCamposEnTabla() {
        return camposEnTabla;
    }

    /**
     * @param camposEnTabla the camposPorTabla to set
     */
    public void setCamposEnTabla(List<CamposGastosDomain> camposEnTabla) {
        this.camposEnTabla = camposEnTabla;
    }
    
    /**
     * @return the campoInsert
     */
    public CamposGastosDomain getCampoInsert() {
        return campoInsert;
    }

    /**
     * @param campoInsert the campoInsert to set
     */
    public void setCampoInsert(CamposGastosDomain campoInsert) {
        this.campoInsert = campoInsert;
    }
    
    /**
     * @return the campoEdit
     */
    public CamposGastosDomain getCampoEdit() {
        return campoEdit;
    }

    /**
     * @param campoEdit the campoInsert to set
     */
    public void setCampoEdit(CamposGastosDomain campoEdit) {
        this.campoEdit = campoEdit;
    }
    
    /**
     * @return the campoDelete
     */
    public CamposGastosDomain getCampoDelete() {
        return campoDelete;
    }

    /**
     * @param campoDelete the campoInsert to set
     */
    public void setCampoDelete(CamposGastosDomain campoDelete) {
        this.campoDelete = campoDelete;
    }
    
    /* Consultar los campos de la tabla */
    public void changeTabla() {
        if (this.campoInsert.getTabla() == null) {
            this.campoInsert.setTabla("");
        }
        try {
            setCamposPorTabla(tablaCampoService.findCamposConfigPorTabla(this.campoInsert.getTabla()));
            this.campoInsert.setCampo(camposPorTabla.get(0).getCampo());
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS POR TABLA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los campos. "));
        }
    }
}
