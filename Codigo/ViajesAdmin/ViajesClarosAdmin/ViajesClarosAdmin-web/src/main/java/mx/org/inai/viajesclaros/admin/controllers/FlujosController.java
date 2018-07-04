
package mx.org.inai.viajesclaros.admin.controllers;

import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import mx.org.inai.viajesclaros.admin.ejb.FlujoService;
import mx.org.inai.viajesclaros.admin.ejb.PersonaService;
import mx.org.inai.viajesclaros.admin.ejb.TablaCampoService;
import mx.org.inai.viajesclaros.domain.CampoFlujoDomain;
import mx.org.inai.viajesclaros.domain.FlujoTrabajoDomain;
import mx.org.inai.viajesclaros.domain.SeccionFormularioDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.TablaCampoDomain;
import org.apache.log4j.Logger;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class FlujosController {

    @EJB
    FlujoService flujoService;
    @EJB
    PersonaService personaService;
    @EJB
    TablaCampoService tablaCampoService;

    private Integer idFlujo;
    private Integer idTipoPersona;
    private String categoriaCampoDlg;
    private CampoFlujoDomain campoEdit;
    private CampoFlujoDomain campoInsert;
    private CampoFlujoDomain campoDelete;
    private FlujoTrabajoDomain flujoSelected;
    private SeccionFormularioDomain seccionEdit;
    private SeccionFormularioDomain seccionInsert;
    private SeccionFormularioDomain seccionDelete;
    private List<SimpleElementDomain> tablas;
    private List<TablaCampoDomain> camposPorTabla;
    private List<FlujoTrabajoDomain> flujosTrabajo;
    private List<SimpleElementDomain> tiposPersona;
    private List<SeccionFormularioDomain> secciones;
    final static Logger log = Logger.getLogger(FlujosController.class);

    @PostConstruct
    public void init() {
        setIdFlujo((Integer) 1);
        campoEdit = new CampoFlujoDomain();
        campoInsert = new CampoFlujoDomain();
        campoDelete = new CampoFlujoDomain();
        seccionInsert = new SeccionFormularioDomain();
        seccionDelete = new SeccionFormularioDomain();
        try {
            setTiposPersona(personaService.getTiposPersona());
            setIdTipoPersona(tiposPersona.get(0).getId());
            setFlujosTrabajo(flujoService.getFlujosTrabajo());
            setIdFlujo(flujosTrabajo.get(0).getId());
            setSecciones(flujoService.getFlujoCategoriasCampos(idFlujo, idTipoPersona));
            setFlujoSelected(flujosTrabajo.get(0));
            setTablas(tablaCampoService.findTablasFlujoDisponibles(idFlujo, idTipoPersona));
            setCamposPorTabla(tablaCampoService.findCamposFlujoPorTabla(idFlujo, idTipoPersona, this.tablas.get(0).getDescripcion()));
            setCategoriaCampoDlg(camposPorTabla.get(0).getCategoria());
        } catch (Exception e) {
            log.error("ERROR EN POST CONSTRUCTOR", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. "));
        }
    }

    /* Reinicia los datos de la pantalla */
    private void reinit() throws Exception {
        campoEdit = new CampoFlujoDomain();
        campoInsert = new CampoFlujoDomain();
        campoDelete = new CampoFlujoDomain();
        seccionInsert = new SeccionFormularioDomain();
        seccionDelete = new SeccionFormularioDomain();
        setSecciones(flujoService.getFlujoCategoriasCampos(idFlujo, idTipoPersona));
        setTablas(tablaCampoService.findTablasFlujoDisponibles(idFlujo, idTipoPersona));
        setCamposPorTabla(tablaCampoService.findCamposFlujoPorTabla(idFlujo, idTipoPersona, this.tablas.get(0).getDescripcion()));
        setCategoriaCampoDlg(camposPorTabla.get(0).getCategoria());
    }
    
    public void reinitValorInsert() {
        this.campoInsert = new CampoFlujoDomain();
    }
    
    public void reinitValorEdit() {
        this.campoEdit = new CampoFlujoDomain();
    }
    
    public void reinitValorSeccion() {
       this.seccionInsert = new SeccionFormularioDomain();
    }
    
    public void reinitSeccionEdit() {
       this.seccionEdit = new SeccionFormularioDomain(); 
    }

    /* Al seleccionar un flujo diferente, consultar sus campos */
    public void changeFlujo() {
        try {
            for (FlujoTrabajoDomain f : flujosTrabajo) {
                if (f.getId().equals(this.idFlujo)) {
                    setFlujoSelected(f);
                    /* Actualizar los datos del panatalla */
                    reinit();
                }
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR DATOS DEL FLUJO DE TRABAJO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al cargar los datos. "));
        }
    }

    /* Consultar los campos de la tabla */
    public void changeTabla() {
        if (this.campoInsert.getTabla() == null) {
            this.campoInsert.setTabla("");
        }
        try {
            setCamposPorTabla(tablaCampoService.findCamposFlujoPorTabla(idFlujo, idTipoPersona, this.campoInsert.getTabla()));
            this.campoInsert.setCampo(camposPorTabla.get(0).getCampo());
            this.categoriaCampoDlg = camposPorTabla.get(0).getCategoria();
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS POR TABLA", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error!", "Error al consultar los campos. "));
        }
    }
    
    /* Guarda un nuevo campo */
    public void saveColumn() {
        if (this.campoInsert.getTabla() == null) {
            this.campoInsert.setTabla("");
        }
        try {
            this.campoInsert.setIdFlujo(idFlujo);
            this.campoInsert.setIdTipoPersona(idTipoPersona);
            flujoService.saveFlujoCampoConfig(campoInsert);
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
            this.campoDelete.setIdFlujo(idFlujo);
            this.campoDelete.setIdTipoPersona(idTipoPersona);
            flujoService.deleteFlujoCampoConfig(campoDelete);
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
            this.campoEdit.setIdFlujo(idFlujo);
            this.campoEdit.setIdTipoPersona(idTipoPersona);
            flujoService.updateFlujoCampoConfig(campoEdit);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se actualizó el campo " + campoEdit.getEtiqueta() + "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL CAMPO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al actualizar el campo. "));
        }
    }
    
    /* Guarda una nueva sección */
    public void saveSeccion() {
        try {
            seccionInsert.setIdFlujo(idFlujo);
            flujoService.saveSeccion(seccionInsert);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se agregó la sección " + seccionInsert.getEtiqueta() + "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR LA SECCIÓN", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "Error al guardar la sección. "));
        }
    }
    
    /* Elimina una sección del flujo */
    public void deleteSeccion() {
        try {
            flujoService.deleteSeccion(seccionDelete.getId());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se eliminó la sección " + seccionDelete.getEtiqueta()+ "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR LA SECCIÓN", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "Error al eliminar la sección. "));
        }
    }
    
    /* Actualiza los datos de una sección */
    public void updateSeccion() {
        try {
            seccionEdit.setIdFlujo(idFlujo);
            flujoService.updateSeccion(seccionEdit);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "", "Se actualizó la sección " + seccionEdit.getEtiqueta()+ "."));
            /* Actualizar los datos de la pantalla */
            reinit();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR LA SECCIÓN", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "Error al actualizar la sección. "));
        }
    }
    
    /* Cuando se selecciona un campo mostrar su categoría en la ventana modal */
    public void onSelectCampo() {
        for (TablaCampoDomain c : camposPorTabla) {
            if (c.getCampo().equals(campoInsert.getCampo())) {
                this.categoriaCampoDlg = c.getCategoria();
            }
        }
    }

    /**
     * @return the flujosTrabajo
     */
    public List<FlujoTrabajoDomain> getFlujosTrabajo() {
        return flujosTrabajo;
    }

    /**
     * @param flujosTrabajo the flujosTrabajo to set
     */
    public void setFlujosTrabajo(List<FlujoTrabajoDomain> flujosTrabajo) {
        this.flujosTrabajo = flujosTrabajo;
    }

    /**
     * @return the flujoSelected
     */
    public FlujoTrabajoDomain getFlujoSelected() {
        return flujoSelected;
    }

    /**
     * @param flujoSelected the flujoSelected to set
     */
    public void setFlujoSelected(FlujoTrabajoDomain flujoSelected) {
        this.flujoSelected = flujoSelected;
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
     * @return the campoInsert
     */
    public CampoFlujoDomain getCampoInsert() {
        return campoInsert;
    }

    /**
     * @param campoInsert the campoInsert to set
     */
    public void setCampoInsert(CampoFlujoDomain campoInsert) {
        this.campoInsert = campoInsert;
    }

    /**
     * @return the idFlujo
     */
    public Integer getIdFlujo() {
        return idFlujo;
    }

    /**
     * @param idFlujo the idFlujo to set
     */
    public void setIdFlujo(Integer idFlujo) {
        this.idFlujo = idFlujo;
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
     * @return the categoriaCampoDlg
     */
    public String getCategoriaCampoDlg() {
        return categoriaCampoDlg;
    }

    /**
     * @param categoriaCampoDlg the categoriaCampoDlg to set
     */
    public void setCategoriaCampoDlg(String categoriaCampoDlg) {
        this.categoriaCampoDlg = categoriaCampoDlg;
    }

    /**
     * @return the campoDelete
     */
    public CampoFlujoDomain getCampoDelete() {
        return campoDelete;
    }

    /**
     * @param campoDelete the campoDelete to set
     */
    public void setCampoDelete(CampoFlujoDomain campoDelete) {
        this.campoDelete = campoDelete;
    }

    /**
     * @return the campoEdit
     */
    public CampoFlujoDomain getCampoEdit() {
        return campoEdit;
    }

    /**
     * @param campoEdit the campoEdit to set
     */
    public void setCampoEdit(CampoFlujoDomain campoEdit) {
        this.campoEdit = campoEdit;
    }

    /**
     * @return the tiposPersona
     */
    public List<SimpleElementDomain> getTiposPersona() {
        return tiposPersona;
    }

    /**
     * @param tiposPersona the tiposPersona to set
     */
    public void setTiposPersona(List<SimpleElementDomain> tiposPersona) {
        this.tiposPersona = tiposPersona;
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
     * @return the seccionInsert
     */
    public SeccionFormularioDomain getSeccionInsert() {
        return seccionInsert;
    }

    /**
     * @param seccionInsert the seccionInsert to set
     */
    public void setSeccionInsert(SeccionFormularioDomain seccionInsert) {
        this.seccionInsert = seccionInsert;
    }

    /**
     * @return the seccionDelete
     */
    public SeccionFormularioDomain getSeccionDelete() {
        return seccionDelete;
    }

    /**
     * @param seccionDelete the seccionDelete to set
     */
    public void setSeccionDelete(SeccionFormularioDomain seccionDelete) {
        this.seccionDelete = seccionDelete;
    }

    /**
     * @return the secciones
     */
    public List<SeccionFormularioDomain> getSecciones() {
        return secciones;
    }

    /**
     * @param secciones the secciones to set
     */
    public void setSecciones(List<SeccionFormularioDomain> secciones) {
        this.secciones = secciones;
    }

    /**
     * @return the seccionEdit
     */
    public SeccionFormularioDomain getSeccionEdit() {
        return seccionEdit;
    }

    /**
     * @param seccionEdit the seccionEdit to set
     */
    public void setSeccionEdit(SeccionFormularioDomain seccionEdit) {
        this.seccionEdit = seccionEdit;
    }

}
