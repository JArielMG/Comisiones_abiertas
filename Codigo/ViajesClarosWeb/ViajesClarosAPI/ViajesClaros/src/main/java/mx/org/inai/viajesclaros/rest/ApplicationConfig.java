/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.org.inai.viajesclaros.rest;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author Sandro Alejandro
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(mx.org.inai.viajesclaros.filters.RESTRequestFilter.class);
        resources.add(mx.org.inai.viajesclaros.filters.RESTResponseFilter.class);
        resources.add(mx.org.inai.viajesclaros.rest.BusquedaREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.CatDependenciaFacadeREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.DependenciaREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.FuncionarioREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.GraficaREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.UtilREST.class);
        resources.add(mx.org.inai.viajesclaros.rest.ViajeREST.class);
    }
    
}
