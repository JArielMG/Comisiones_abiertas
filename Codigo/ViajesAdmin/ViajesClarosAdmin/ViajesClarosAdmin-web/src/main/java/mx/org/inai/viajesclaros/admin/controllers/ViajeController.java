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
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import mx.org.inai.viajesclaros.admin.ejb.ViajeService;
import mx.org.inai.viajesclaros.domain.DespliegueBusquedaDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;

/**
 * @author Sandro Alejandro
 */
@ManagedBean
@RequestScoped
public class ViajeController {
    
    @EJB
    ViajeService viajeService;
    private List<ViajeDomain> viajes;
    private List<DespliegueBusquedaDomain> headers;
    
    @PostConstruct
    public void init() {
        setViajes(viajeService.findAllByDependencia(4));
        setHeaders(viajeService.getEncabezadoViajes(4));
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

}
