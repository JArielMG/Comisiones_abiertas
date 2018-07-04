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
import javax.faces.bean.ViewScoped;
import mx.org.inai.viajesclaros.admin.ejb.CampoBaseService;
import mx.org.inai.viajesclaros.domain.CampoDomain;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class CamposBaseController {
    
    @EJB
    CampoBaseService campoBaseService;
    private List<CampoDomain> camposBase;
    
    @PostConstruct
    public void init() {
        try {
            setCamposBase(campoBaseService.findAll());
        } catch(Exception e) {
            System.out.println("ERROR EN POSTCONSTRUCTOR. " + e.getMessage());
        }
    }

    /**
     * @return the camposBase
     */
    public List<CampoDomain> getCamposBase() {
        return camposBase;
    }

    /**
     * @param camposBase the camposBase to set
     */
    public void setCamposBase(List<CampoDomain> camposBase) {
        this.camposBase = camposBase;
    }
    
}
