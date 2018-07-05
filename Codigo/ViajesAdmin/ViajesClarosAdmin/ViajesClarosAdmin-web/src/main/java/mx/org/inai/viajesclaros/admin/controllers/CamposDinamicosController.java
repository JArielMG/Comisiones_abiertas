
package mx.org.inai.viajesclaros.admin.controllers;

import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import static mx.org.inai.viajesclaros.admin.controllers.ListasController.log;
import mx.org.inai.viajesclaros.admin.ejb.CampoDinamicoService;
import mx.org.inai.viajesclaros.admin.ejb.ListaService;
import mx.org.inai.viajesclaros.domain.CampoDomain;
import mx.org.inai.viajesclaros.domain.ListaValoresDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class CamposDinamicosController {
    
    @EJB
    CampoDinamicoService campoDinamicoService;
    @EJB
    ListaService listaService;
    private List<CampoDomain> camposDinamicos;
    private List<ListaValoresDomain> listas;
    private List<SimpleElementDomain> tiposDato;
    private List<SimpleElementDomain> tiposControl;
    private List<SimpleElementDomain> categorias;
    private CampoDomain campoInsert;
    private CampoDomain campoDelete;
    private Boolean edicionCampo; // Para identificar si es edición o es un nuevo campo
    private String filtroCampo = "";
    private String editLista = "";
    private String editCategoria = "";
    final static Logger log = Logger.getLogger(ListasController.class);
    
    @PostConstruct
    public void init() {
        try {
            campoInsert = new CampoDomain();
            campoDelete = new CampoDomain();
            edicionCampo = false;
            setCamposDinamicos(campoDinamicoService.findAll());
            setListas(listaService.findAllOrdenada());
            setTiposDato(campoDinamicoService.getTiposDato());
            setTiposControl(campoDinamicoService.getTiposControl());
            setCategorias(campoDinamicoService.gatCategorias());
        } catch(Exception e) {
            System.out.println("ERROR EN POSTCONSTRUCTOR. " + e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al consultar los datos. " + e.getMessage()));
        }
    }
    
    public void reinitCampoInsert() {
        edicionCampo = false;
        campoInsert = new CampoDomain();
    }
    
    /**
     * Guarda o actualiza el campo dinámico
     */
    public void saveCampo() {
        try {
            if(campoInsert.getIdTipoDato() == null)
                campoInsert.setIdTipoDato(1);
            if(campoInsert.getIdTipoControl() == null)
                campoInsert.setIdTipoControl(1);
            if (edicionCampo) {
                campoDinamicoService.updateCampo(campoInsert);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se actualizó el campo dinámico."));
            } else {
                campoDinamicoService.saveCampo(campoInsert);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se agregó el campo dinámico."));
            }
            /* Actualizar datos */
            edicionCampo = false;
            campoInsert = new CampoDomain();
            setCamposDinamicos(campoDinamicoService.findAllFiltro(getFiltroCampo()));
            RequestContext.getCurrentInstance().addCallbackParam("saved", true);
        } catch(Exception e) {
            RequestContext.getCurrentInstance().addCallbackParam("saved", false);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al guardar el valor."));
        }
    }
    
    public void deleteCampo() {
        try {
            campoDinamicoService.deleteCampo(campoDelete.getCampo());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó el campo " + campoDelete.getCampo()));
            /* Actualizar lista */
            campoDelete = new CampoDomain();
            setCamposDinamicos(campoDinamicoService.findAllFiltro(getFiltroCampo()));
            RequestContext.getCurrentInstance().addCallbackParam("deleted", true);
        } catch(Exception e) {
            RequestContext.getCurrentInstance().addCallbackParam("deleted", false);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al guardar el valor. " + e.getMessage()));
        }
    }
    
    /** 
     * Cuando se selecciona una lista.. 
     * automáticamente el tipo de dato es TEXTO y el tipo de control es LISTA
     * */
    public void selectLista() {
        if (campoInsert.getIdLista() != null) {
            campoInsert.setIdTipoDato(2); // TEXTO
            campoInsert.setIdTipoControl(2); // LISTA
            campoInsert.setIdLista(campoInsert.getIdLista());
        } else {
            campoInsert.setIdTipoControl(1); // TEXTO
        }
    }
    
    /* Si se selecciona el tipo de dato FECHA, el tipo de control debe ser CALENDARIO */
    public void selectTipoDato() {
        if (campoInsert.getIdTipoDato()==3) {
            campoInsert.setIdTipoControl(3);
        } else { // para NUMERO o TEXTO, el tipo de control debe ser TEXTO
            campoInsert.setIdTipoControl(1);
        }
    }

    public void filtrarCampos() {
        try {
            log.info("valor cuadro: " + getFiltroCampo());
            setCamposDinamicos(campoDinamicoService.findAllFiltro(getFiltroCampo()));
        } catch (Exception e) {
            log.error("ERROR AL SELECCIONAR LISTA.", e);
        }
    }
    
    public void nuevoCampo(){
        try {
            log.info("valor cuadro: " + getEditLista() + " " + getEditCategoria());
        } catch (Exception e) {
            log.error("ERROR AL SELECCIONAR LISTA.", e);
        }
    }
    
    /**
     * @return the camposDinamicos
     */
    public List<CampoDomain> getCamposDinamicos() {
        return camposDinamicos;
    }

    /**
     * @param camposDinamicos the camposDinamicos to set
     */
    public void setCamposDinamicos(List<CampoDomain> camposDinamicos) {
        this.camposDinamicos = camposDinamicos;
    }

    /**
     * @return the campoInsert
     */
    public CampoDomain getCampoInsert() {
        return campoInsert;
    }

    /**
     * @param campoInsert the campoInsert to set
     */
    public void setCampoInsert(CampoDomain campoInsert) {
        this.campoInsert = campoInsert;
    }

    /**
     * @return the listas
     */
    public List<ListaValoresDomain> getListas() {
        return listas;
    }

    /**
     * @param listas the listas to set
     */
    public void setListas(List<ListaValoresDomain> listas) {
        this.listas = listas;
    }

    /**
     * @return the tiposDato
     */
    public List<SimpleElementDomain> getTiposDato() {
        return tiposDato;
    }

    /**
     * @param tiposDato the tiposDato to set
     */
    public void setTiposDato(List<SimpleElementDomain> tiposDato) {
        this.tiposDato = tiposDato;
    }

    /**
     * @return the tiposControl
     */
    public List<SimpleElementDomain> getTiposControl() {
        return tiposControl;
    }

    /**
     * @param tiposControl the tiposControl to set
     */
    public void setTiposControl(List<SimpleElementDomain> tiposControl) {
        this.tiposControl = tiposControl;
    }

    /**
     * @return the campoDelete
     */
    public CampoDomain getCampoDelete() {
        return campoDelete;
    }

    /**
     * @param campoDelete the campoDelete to set
     */
    public void setCampoDelete(CampoDomain campoDelete) {
        this.campoDelete = campoDelete;
    }

    /**
     * @return the edicionCampo
     */
    public Boolean getEdicionCampo() {
        return edicionCampo;
    }

    /**
     * @param edicionCampo the edicionCampo to set
     */
    public void setEdicionCampo(Boolean edicionCampo) {
        this.edicionCampo = edicionCampo;
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
    
    public String getFiltroCampo() {
       return filtroCampo;
    }
    public void setFiltroCampo(String filtroCampo) {
       this.filtroCampo = filtroCampo;
    }
    
    public String getEditLista() {
       return editLista;
    }
    public void setEditLista(String editLista) {
       this.editLista = editLista;
    }
    
    public String getEditCategoria() {
       return editCategoria;
    }
    public void seteditCategoria(String editCategoria) {
       this.editCategoria = editCategoria;
    }
}
