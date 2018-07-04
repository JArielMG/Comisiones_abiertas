/*
 * Copyright (C) 2015 Sandro Alejandro
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
package mx.org.inai.viajesclaros.rest;

import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import mx.org.inai.viajesclaros.entities.CatDependencia;
import mx.org.inai.viajesclaros.services.DependenciaService;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
@Path("dependencia")
public class DependenciaREST {
    @EJB
    DependenciaService dependenciaService;
    
    @GET
    @Produces({"application/json"})
    public List<CatDependencia> findAll() {
        return dependenciaService.findAll();
    }
}
