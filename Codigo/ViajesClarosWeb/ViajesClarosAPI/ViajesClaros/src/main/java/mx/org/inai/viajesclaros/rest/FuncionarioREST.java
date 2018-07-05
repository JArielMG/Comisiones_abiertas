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
package mx.org.inai.viajesclaros.rest;

import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import mx.org.inai.viajesclaros.model.FuncionarioModel;
import mx.org.inai.viajesclaros.model.PorcentajeDiasComisionModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.services.FuncionarioService;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
@Path("funcionario")
public class FuncionarioREST {
    @EJB
    FuncionarioService funcionarioService;
    
    @POST
    @Path("getById")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public FuncionarioModel getById(FuncionarioModel funcionario) throws Exception {
        return funcionarioService.getById(funcionario);
    }
    
    @GET
    @Path("funcionariosByDependencia/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<FuncionarioModel> getFiltrosByDependencia(@PathParam("id") Integer id, @PathParam("anio") Integer anio) throws Exception {
        return funcionarioService.getFuncionariosByDependencia(id,anio); 
    }
    
    @POST
    @Path("getResumenById/{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public FuncionarioModel getResumenById(FuncionarioModel funcionario, @PathParam("anio") Integer anio) throws Exception {
        return funcionarioService.getResumenById(funcionario,anio);
    }
    
    @POST
    @Path("getCargoFuncionario")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String getCargoFuncionario(FuncionarioModel funcionario) throws Exception {
        return funcionarioService.getFuncionarioCargo(funcionario);
    }
    
    @GET
    @Path("getByIdViaje/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public FuncionarioModel getByIdViaje(@PathParam("id") Integer id) throws Exception {
        return funcionarioService.getByIdViaje(id);
    }
    
    @GET
    @Path("getAllResumen/{anio}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<FuncionarioModel> getAllResumen(@PathParam("anio") Integer anio) {
        return funcionarioService.findAllResumen(anio);
    }
    
    @POST
    @Path("getPorcentajeDiasComision/{anio}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public PorcentajeDiasComisionModel getPorcentajeDiasComision(FuncionarioModel funcionario, @PathParam("anio") Integer anio) {
        return funcionarioService.getPorcentajeDiasComision(funcionario,anio);
    }
    
    @POST
    @Path("suscribe")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public SimpleObjectModel suscribe(FuncionarioModel model) {
        return funcionarioService.suscribe(model);
    }
}
