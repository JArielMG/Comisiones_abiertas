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
import mx.org.inai.viajesclaros.admin.ejb.ListaService;
import mx.org.inai.viajesclaros.domain.ListaValoresDomain;
import mx.org.inai.viajesclaros.domain.ValorListaDomain;
import org.apache.log4j.Logger;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class ListasController {

    @EJB
    ListaService listaService;
    private List<ValorListaDomain> valores;
    private List<ListaValoresDomain> listas;
    private ValorListaDomain valorInsert;
    private ValorListaDomain valorDelete;
    private ListaValoresDomain listaInsert;
    private ListaValoresDomain listaDelete;
    private ListaValoresDomain selectedLista;
    private Boolean edicionValor;
    final static Logger log = Logger.getLogger(ListasController.class);

    @PostConstruct
    public void init() {
        try {
            setEdicionValor((Boolean) false);
            valorInsert = new ValorListaDomain();
            listaInsert = new ListaValoresDomain();
            setValores(listaService.findAllValores());
            setListas(listaService.findAll());
        } catch (Exception e) {
            System.out.println("ERROR EN POSTCONSTRUCTOR. " + e.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al cargar los datos."));
        }
    }
    
    /**
     * Lógica para reiniciar la tabla de valores, dependiendo de si está o no seleccionada una lista
     */
    public void reinitValores() {
        try {
            valorDelete = new ValorListaDomain();
            valorInsert = new ValorListaDomain();
            if (selectedLista == null) {
                setListas(listaService.findAll());
                setValores(listaService.findAllValores());
            } else {
                valorInsert.setIdLista(selectedLista.getIdList());
                setListas(listaService.findAll());
                setValores(listaService.findValoresPorIdLista(selectedLista.getIdList()));
            }
        } catch(Exception e) {
            log.error("ERROR AL REINICIAR LOS VALORES.", e);
        }
    }

    public void reinitListaInsert() {
        listaInsert = new ListaValoresDomain();
    }

    public void reinitValorInsert() {
        log.info("REINIT VALOR INSERT");
        edicionValor = false;
        valorInsert = new ValorListaDomain();
        if (selectedLista != null) {
            log.info("SELECTED LSTA: " + selectedLista.getIdList());
            valorInsert.setIdLista(selectedLista.getIdList());
        }
    }

    /**
     * Método para guardar o actualizar una lista
     */
    public void saveLista() {
        try {
            if (listaInsert.getIdList() != null) {
                listaService.updateLista(listaInsert);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                        "", "Se actualizó la lista."));
            } else {
                listaService.saveLista(listaInsert.getNombreLista());
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                        "", "Se agregó la lista."));
            }
            selectedLista = new ListaValoresDomain();
            listaInsert = new ListaValoresDomain();
            setListas(listaService.findAll());
            setValores(listaService.findAllValores());
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al guardar la lista. " + e.getMessage()));
        }
    }

    /**
     * Método para guardar un valor dinámico asociado a una lista
     */
    public void saveValor() {
        try {
            if (edicionValor) {
                log.info("EDICIÓN! " + valorInsert.getIdLista() + " - " + valorInsert.getCodigo() + " - " + valorInsert.getValor());
                listaService.updateValor(valorInsert);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                        "", "Se actualizó el valor."));
            } else {
                log.info("INSERT!");
                listaService.saveValor(valorInsert);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                        "", "Se agregó el valor."));
            }
            edicionValor = false;
            RequestContext.getCurrentInstance().addCallbackParam("saved", true);
            /* Actualizar pantalla */
            reinitValores();
        } catch (Exception e) {
            RequestContext.getCurrentInstance().addCallbackParam("saved", false);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al guardar el valor. " + e.getMessage()));
        }
    }

    /**
     * Elimina una lista
     */
    public void deleteLista() {
        try {
            listaService.deleteLista(listaDelete.getIdList());
            setListas(listaService.findAll());
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó la lista."));
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al eliminar la lista. " + e.getMessage()));
        }
    }

    /**
     * Elimina un valor, perteneciente a una lista
     */
    public void deleteValor() {
        try {
            listaService.deleteValor(valorDelete);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                    "", "Se eliminó el valor."));
            /* Reiniciar las listas */
            reinitValores();
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "Error", "Error al eliminar el valor. " + e.getMessage()));
        }
    }

    public void selectRow() {
        try {
            log.info("SELECTED LISTA: " + selectedLista.getIdList());
            setValores(listaService.findValoresPorIdLista(selectedLista.getIdList()));
            /* Por si se quiere agregar un campo cuando una lista está seleccionada, 
             * por default se mostrará esa lista seleccionada */
            valorInsert.setIdLista(selectedLista.getIdList());
        } catch (Exception e) {
            log.error("ERROR AL SELECCIONAR LISTA.", e);
        }
    }

    public void unselectRow() {
        try {
            this.selectedLista = new ListaValoresDomain();
            setValores(listaService.findAllValores());
        } catch (Exception e) {
            log.error("ERROR AL DESELECCIONAR LISTA.", e);
        }
    }

    /**
     * @return the valores
     */
    public List<ValorListaDomain> getValores() {
        return valores;
    }

    /**
     * @param valores the valores to set
     */
    public void setValores(List<ValorListaDomain> valores) {
        this.valores = valores;
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
     * @return the valorInsert
     */
    public ValorListaDomain getValorInsert() {
        return valorInsert;
    }

    /**
     * @param valorInsert the valorInsert to set
     */
    public void setValorInsert(ValorListaDomain valorInsert) {
        this.valorInsert = valorInsert;
    }

    /**
     * @return the listaInsert
     */
    public ListaValoresDomain getListaInsert() {
        return listaInsert;
    }

    /**
     * @param listaInsert the listaInsert to set
     */
    public void setListaInsert(ListaValoresDomain listaInsert) {
        this.listaInsert = listaInsert;
    }

    /**
     * @return the listaDelete
     */
    public ListaValoresDomain getListaDelete() {
        return listaDelete;
    }

    /**
     * @param listaDelete the listaDelete to set
     */
    public void setListaDelete(ListaValoresDomain listaDelete) {
        this.listaDelete = listaDelete;
    }

    /**
     * @return the valorDelete
     */
    public ValorListaDomain getValorDelete() {
        return valorDelete;
    }

    /**
     * @param valorDelete the valorDelete to set
     */
    public void setValorDelete(ValorListaDomain valorDelete) {
        this.valorDelete = valorDelete;
    }

    /**
     * @return the edicionValor
     */
    public Boolean getEdicionValor() {
        return edicionValor;
    }

    /**
     * @param edicionValor the edicionValor to set
     */
    public void setEdicionValor(Boolean edicionValor) {
        this.edicionValor = edicionValor;
    }

    /**
     * @return the selectedLista
     */
    public ListaValoresDomain getSelectedLista() {
        return selectedLista;
    }

    /**
     * @param selectedLista the selectedLista to set
     */
    public void setSelectedLista(ListaValoresDomain selectedLista) {
        this.selectedLista = selectedLista;
    }

}
