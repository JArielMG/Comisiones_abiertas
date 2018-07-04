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
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
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
        return busquedaService.getEncabezadoViajes(id);
    }
    
    @GET
    @Path("viajes/{id}")
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesByDependencia(@PathParam("id") Integer id) throws Exception {
        return busquedaService.getViajesByDependencia(id);
    }
    
    @POST
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
    public List<ViajeResultModel> getViajesByFiltros(@PathParam("id") Integer id, BusquedaModel busquedaModel) {
        return busquedaService.getViajesByFiltros(id, busquedaModel);
    }
    
    @POST
    @Path("viajesCSV/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    public Response getViajesCSV(@PathParam("id") Integer id, BusquedaModel busquedaModel) {
        String csvText = busquedaService.getViajesCSV(id, busquedaModel);
        return Response.ok(csvText).header("Content-Disposition", "attachment; filename=" + "viajes.csv").build();
    }

}
