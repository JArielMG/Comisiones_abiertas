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
import mx.org.inai.viajesclaros.model.MapMarkerModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.model.ViajeResumenModel;
import mx.org.inai.viajesclaros.services.ViajeService;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
@Path("viaje")
public class ViajeREST {
    @EJB
    ViajeService viajeService;
    
    @POST
    @Path("getViajesByFuncionario/{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    @Consumes(MediaType.APPLICATION_JSON) 
    public List<ViajeResumenModel> getViajesbyFuncionario(FuncionarioModel funcionario, @PathParam("anio") Integer anio) {
        return viajeService.getViajesResumenByFuncionario(funcionario,anio);
    }
    
    @GET
    @Path("getResumenById/{id}")
    @Produces(MediaType.APPLICATION_JSON) 
    public ViajeResumenModel getResumenById(@PathParam("id") Integer id) {
        return viajeService.getResumenById(id);
    }
    
    @POST
    @Path("getDatosPorCategoria")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public List<SimpleObjectModel> getDavosViajePorCategoria(SimpleObjectModel model) {
        return viajeService.getDavosViajePorCategoria(model);
    }
    
    @GET
    @Path("getUbicacionesPorDependencia/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<MapMarkerModel> getUbicacionesPorDependencia(@PathParam("id") Integer id,@PathParam("anio") Integer anio) {
        return viajeService.getUbicacionesPorDependencia(id,anio);
    }
    
    @POST
    @Path("getUbicacionesPorFuncionario/{anio}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public List<MapMarkerModel> getUbicacionesPorFuncionario(FuncionarioModel funcionario, @PathParam("anio") Integer anio) {
        return viajeService.getUbicacionesPorFuncionario(funcionario,anio);
    }
    
    @POST
    @Path("getViajesPorCiudadPais/{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public List<ViajeResumenModel> getViajesPorCiudadPais(ViajeResumenModel viaje,@PathParam("anio") Integer anio) {
        return viajeService.getViajesResumenPorCiudadPais(viaje,anio);
    }
    @POST
    @Path("getViajesPorCiudadPaisFuncionario/{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public List<ViajeResumenModel> getViajesPorCiudadPaisFuncionario(ViajeResumenModel viaje, @PathParam("anio") Integer anio) {
        return viajeService.getViajesResumenPorCiudadPaisFuncionario(viaje,anio);
    }
}
