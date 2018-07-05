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
import mx.org.inai.viajesclaros.model.GraficaDependenciaModel;
import mx.org.inai.viajesclaros.model.GraficaModel;
import mx.org.inai.viajesclaros.model.HotelModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.model.ViajeResumenModel;
import mx.org.inai.viajesclaros.services.GraficaService;

/**
 * Servicio para obtener los datos de las gráficas que se muestran en el sistema web
 * @author sandro
 */
@Stateless
@Path("grafica")
public class GraficaREST {
    @EJB
    GraficaService graficaService;
    
    @GET
    @Path("getFuncionariosMayorGasto/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<FuncionarioModel> getFuncionariosMayorGasto(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getFuncionariosMayorGasto(id,anio);
    }
    
    @GET
    @Path("getFuncionariosMasViajes/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<FuncionarioModel> getFuncionariosMasViajes(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getFuncionariosMasViajes(id,anio);
    }
    
    @GET
    @Path("getUltimosViajes/{id}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<ViajeResumenModel> getUltimosViajes(@PathParam("id") Integer id) {
        return graficaService.getUltimosViajesPorDep(id);
    }
    
    @GET
    @Path("getUltimosViajesPorUnidad/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<ViajeResumenModel> getUltimosViajesPorUnidad(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getUltimosViajesPorUnidad(id,anio);
    }
    
    @GET
    @Path("getUnidadesAdministrativas")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<SimpleObjectModel> getUnidadesAdministrativas() {
        return graficaService.getUnidadesAdministrativas();
    }
    
    @GET
    @Path("getHotelesMasVisitados/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<HotelModel> getHotelesMasVisitados(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getHotelesMasVisitadosPorDep(id,anio);
    }
    
    @GET
    @Path("getGraficaTipoViaje/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaTipoViaje(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaTipoViaje(id,anio);
    }
    
    @GET
    @Path("getGraficaTipoPasaje/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaTipoPasaje(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaTipoPasaje(id,anio);
    }
    
    @GET
    @Path("getGraficaAerolineas/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaAerolineas(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaAerolineas(id,anio);
    }
    
    @GET
    @Path("getGraficaCiudadesInternacionales/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaCiudadesInternacionales(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaCiudadesInternacionales(id,anio);
    }
    
    @GET
    @Path("getGraficaCiudadesNacionales/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaCiudadesNacionales(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaCiudadesNacionales(id,anio);
    }
    
    @GET
    @Path("getGraficaViajesPorMes/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaViajesPorMes(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getGraficaViajesPorMes(id,anio);
    }
    
    @GET
    @Path("getTotalViaticos/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public SimpleObjectModel getTotalViaticosPorDependencia(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getTotalViaticos(id,anio);
    }
    
    @GET
    @Path("getTotalPasajes/{id},{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    public SimpleObjectModel getTotalPasajesPorDependencia(@PathParam("id") Integer id, @PathParam("anio") Integer anio) {
        return graficaService.getTotalPasajes(id,anio);
    }
    
    @POST
    @Path("getGraficaViaticosPorFuncionario/{anio}")
    @Produces(MediaType.APPLICATION_JSON) 
    @Consumes(MediaType.APPLICATION_JSON) 
    public GraficaModel getGraficaViaticosPorFuncionario(FuncionarioModel funcionario,@PathParam("anio") Integer anio) {
        return graficaService.getGraficaViaticosPorFuncionario(funcionario,anio);
    }
    
    @GET
    @Path("getGraficasParametrizadas/{id}")
    @Produces(MediaType.APPLICATION_JSON) 
    public List<GraficaDependenciaModel> getGraficasParametrizadas(@PathParam("id") Integer id) {
        return graficaService.getGraficasParametrizadas(id);
    }
    
}
