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

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import mx.org.inai.viajesclaros.admin.ejb.CalendarioService;
import mx.org.inai.viajesclaros.domain.CalendarEventDomain;
import mx.org.inai.viajesclaros.domain.FuncionarioDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class CalendarioController {

    @EJB
    CalendarioService calendarioService;

    private Integer mes;
    private Integer anio;
    private Integer idArea;
    private Integer idFunc;
    private String jsonString;
    private Integer idFuncionario;
    private String selectedStatus;
    private List<SimpleElementDomain> areas;
    private List<CalendarEventDomain> eventos;
    private List<FuncionarioDomain> funcionarios;
    final static Logger log = Logger.getLogger(CalendarioController.class);

    @PostConstruct
    public void init() {
        try {
            this.mes = Calendar.getInstance().get(Calendar.MONTH) + 1;
            this.anio = Calendar.getInstance().get(Calendar.YEAR);
            this.areas = calendarioService.getUnidadesAdministrativas(mes, anio);
            this.selectedStatus = "";
            updateEventos();
        } catch (Exception e) {
            log.error("ERROR EN POST CONSTRUCTOR", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al cargar los datos. "));
        }
    }

    /* Consulta los eventos */
    public void updateEventos() throws Exception {
        this.eventos = calendarioService.getEventosMes(mes, anio, idArea, idFunc, selectedStatus);
        ObjectMapper mapper = new ObjectMapper();
        jsonString = mapper.writeValueAsString(eventos);
    }

    /* Cuando se cambia de mes en el calendario, consultar los eventos de ese mes */
    public void changeMonth() {
        try {
            this.idArea = null;
            this.idFunc = null;
            this.mes = Integer.valueOf(FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("mesCalendario"));
            this.anio = Integer.valueOf(FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("anioCalendario"));
            log.info("MES: " + mes);
            log.info("AÑO: " + anio);
            this.areas = calendarioService.getUnidadesAdministrativas(mes, anio);
            this.funcionarios = new ArrayList<>();
            updateEventos();
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS EVENTOS", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al consultar los eventos. "));
        }
    }

    /* Cuando se selecciona una unidad administrativa */
    public void changeUnidad() {
        try {
            this.idFunc = null;
            this.funcionarios = calendarioService.getFuncionariosPorUnidad(idArea, mes, anio);
            /* Consultar lo viajes del mes de esta unidad */
            updateEventos();
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS FUNCIONARIOS", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al consultar los funcionarios. "));
        }
    }
    
    /* Cuando se selecciona un funcionario, mostrar sólo los eventos de éste */
    public void changeFuncionario() {
        try {
            updateEventos();
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS EVENTOS DEL FUNCIONARIO", e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error!", "Error al consultar las comisiones del funcionario. "));
        }
    }

    /**
     * @return the jsonString
     */
    public String getJsonString() {
        return jsonString;
    }

    /**
     * @param jsonString the jsonString to set
     */
    public void setJsonString(String jsonString) {
        this.jsonString = jsonString;
    }

    /**
     * @return the areas
     */
    public List<SimpleElementDomain> getAreas() {
        return areas;
    }

    /**
     * @param areas the areas to set
     */
    public void setAreas(List<SimpleElementDomain> areas) {
        this.areas = areas;
    }

    /**
     * @return the idArea
     */
    public Integer getIdArea() {
        return idArea;
    }

    /**
     * @param idArea the idArea to set
     */
    public void setIdArea(Integer idArea) {
        this.idArea = idArea;
    }

    /**
     * @return the funcionarios
     */
    public List<FuncionarioDomain> getFuncionarios() {
        return funcionarios;
    }

    /**
     * @param funcionarios the funcionarios to set
     */
    public void setFuncionarios(List<FuncionarioDomain> funcionarios) {
        this.funcionarios = funcionarios;
    }

    /**
     * @return the idFuncionario
     */
    public Integer getIdFuncionario() {
        return idFuncionario;
    }

    /**
     * @param idFuncionario the idFuncionario to set
     */
    public void setIdFuncionario(Integer idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    /**
     * @return the idFunc
     */
    public Integer getIdFunc() {
        return idFunc;
    }

    /**
     * @param idFunc the idFunc to set
     */
    public void setIdFunc(Integer idFunc) {
        this.idFunc = idFunc;
    }

    /**
     * @return the selectedStatus
     */
    public String getSelectedStatus() {
        return selectedStatus;
    }

    /**
     * @param selectedStatus the selectedStatus to set
     */
    public void setSelectedStatus(String selectedStatus) {
        this.selectedStatus = selectedStatus;
    }
}
