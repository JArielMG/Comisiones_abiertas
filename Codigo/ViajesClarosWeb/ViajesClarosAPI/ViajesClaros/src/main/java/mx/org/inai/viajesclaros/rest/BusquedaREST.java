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
import javax.ws.rs.core.Response;
import mx.org.inai.viajesclaros.model.BusquedaModel;
import mx.org.inai.viajesclaros.model.ElementoCatalogoModel;
import mx.org.inai.viajesclaros.model.FiltroBusquedaModel;
import mx.org.inai.viajesclaros.model.ViajeResultModel;
import mx.org.inai.viajesclaros.services.BusquedaService;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
@Path("busqueda")
public class BusquedaREST {

    @EJB
    BusquedaService busquedaService;

    @GET
    @Path("filtrosByDependencia/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<FiltroBusquedaModel> getFiltrosByDependencia(@PathParam("id") Integer id) throws Exception {
        return busquedaService.getFiltrosByDependencia(id); 
    }
    
    @GET
    @Path("encabezados/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ElementoCatalogoModel> getEncabezadosByDependencia(@PathParam("id") Integer id) throws Exception {
        return busquedaService.getEncabezadoViajes(id,Byte.valueOf("0"));
    }
    
    @GET
    @Path("encabezadosComplete/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ElementoCatalogoModel> getEncabezadosCompleteByDependencia(@PathParam("id") Integer id) throws Exception {
        return busquedaService.getEncabezadoViajes(id,Byte.valueOf("1"));
    }
    
    @GET
    @Path("viajes/{id},{anio}")
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesByDependencia(@PathParam("id") Integer id, @PathParam("anio") Integer anio) throws Exception {
        return busquedaService.getViajesByDependencia(id,anio,Byte.valueOf("0"));
    }
    
    @GET
    @Path("viajesComplete/{id},{anio}")
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesCompleteByDependencia(@PathParam("id") Integer id, @PathParam("anio") Integer anio) throws Exception {
        return busquedaService.getViajesByDependencia(id,anio,Byte.valueOf("1"));
    }
    
    @POST
    @Path("/{id},{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesByFiltros(@PathParam("id") Integer id, BusquedaModel busquedaModel, @PathParam("anio") Integer anio) {
        return busquedaService.getViajesByFiltros(id, busquedaModel,anio,Byte.valueOf("0"));
    }
    
    @POST
    @Path("complete/{id},{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesCompleteByFiltros(@PathParam("id") Integer id, BusquedaModel busquedaModel, @PathParam("anio") Integer anio) {
        return busquedaService.getViajesByFiltros(id, busquedaModel,anio,Byte.valueOf("1"));
    }
    
    @POST
    @Path("viajesCSV/{id},{anio}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response getViajesCSV(@PathParam("id") Integer id, BusquedaModel busquedaModel, @PathParam("anio") Integer anio) {
        String csvText = busquedaService.getViajesCSV(id, busquedaModel, anio);
        return Response.ok(csvText).header("Content-Disposition", "attachment; filename=" + "viajes.csv").build();
    }

}
