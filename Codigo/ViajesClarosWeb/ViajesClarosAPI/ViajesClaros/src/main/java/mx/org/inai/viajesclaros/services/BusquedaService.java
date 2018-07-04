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
package mx.org.inai.viajesclaros.services;

import au.com.bytecode.opencsv.CSVWriter;
import java.io.FileWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.model.BusquedaModel;
import mx.org.inai.viajesclaros.model.ElementoCatalogoModel;
import mx.org.inai.viajesclaros.model.FiltroBusquedaModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.model.ValorListaModel;
import mx.org.inai.viajesclaros.model.ViajeResultModel;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 * Servicio para realizar operaciones del buscador en la base de datos. Todas
 * las operaciones se realizan por medio de stored procedures y funciones
 *
 * @author Sandro Alejandro
 */
@Stateless
public class BusquedaService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(BusquedaService.class);

    public List<FiltroBusquedaModel> getFiltrosByDependencia(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<FiltroBusquedaModel> filtros = session.createSQLQuery("CALL get_filtros_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer id = (Integer) tuple[0];
                        String campo = (String) tuple[2];
                        String descripcion = (String) tuple[3];
                        String tipoDato = (String) tuple[4];
                        String tipoControl = (String) tuple[5];
                        String comparador = (String) tuple[6];
                        Integer idCatalogo = (Integer) tuple[7];

                        return new FiltroBusquedaModel(id, campo, descripcion, tipoControl, tipoDato,
                                idCatalogo, comparador);
                    }
                })
                .list();

        /* Si el filtro es catálogo, se deben traer los elementos del catálogo */
        for (FiltroBusquedaModel f : filtros) {
            if (f.getIdCatalogo() != null && f.getIdCatalogo() > 0) {
                List<ValorListaModel> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id_lista(:idLista)")
                        .setParameter("idLista", f.getIdCatalogo())
                        .setResultTransformer(new BasicTransformerAdapter() {
                            private static final long serialVersionUID = 1L;

                            @Override
                            public Object transformTuple(Object[] tuple, String[] aliases) {
                                ValorListaModel valor = new ValorListaModel();
                                valor.setIdLista((Integer) tuple[0]);
                                valor.setCodigo((String) tuple[1]);
                                valor.setValor((String) tuple[2]);
                                return valor;
                            }
                        })
                        .list();
                f.setValoresLista(cat);
            }
        }
        
        session.flush();
        session.clear();
        return filtros;
    }

    /**
     * Llama al SP para obtener los campos parametrizados para mostrar en los
     * resultados de búsqueda
     *
     * @param idDependencia
     * @return Encabezados (lista de objetos ElementoCatalogoModel)
     */
    public List<ElementoCatalogoModel> getEncabezadoViajes(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<ElementoCatalogoModel> encabezados = session.createSQLQuery("CALL get_headers_viajes(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer id = 0;
                        String descripcion = (String) tuple[2];

                        return new ElementoCatalogoModel(id, descripcion);
                    }
                })
                .list();

        session.flush();
        session.clear();
        return encabezados;
    }

    /**
     * Obtiene los datos de los viajes de la dependencia indicada (los campos
     * son dinámicos)
     *
     * @param idDependencia
     * @return Lista de viajes
     */
    public List<ViajeResultModel> getViajesByDependencia(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<ViajeResultModel> viajes = session.createSQLQuery("CALL get_viajes_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeResultModel v = new ViajeResultModel();

                        List<String> datos = new ArrayList<>();
                        for (int i = 1; i < tuple.length; i++) {
                            datos.add((String) tuple[i]);
                        }

                        v.setId((Integer) tuple[0]);
                        v.setDatos(datos);
                        return v;
                    }
                })
                .list();

        session.flush();
        session.clear();
        return viajes;
    }

    /**
     * Realiza la búsqueda con los filtros dinámicos indicados
     *
     * @param idDependencia Id de la dependencia
     * @param busquedaModel Filtros de búsqueda
     * @return viajes
     */
    public List<ViajeResultModel> getViajesByFiltros(Integer idDependencia, BusquedaModel busquedaModel) {
        /* Obtener el String con la parte WHERE */
        String queryWhere = procesaFiltros(busquedaModel);
        /* Llamar al SP de búsqueda y enviar la parte WHERE como parámetro */
        return callViajesByFiltros(idDependencia, queryWhere);
    }

    /**
     * Devuelve una cadena que representa un archivo CSV
     *
     * @param idDep
     * @param busquedaModel
     * @return
     */
    public String getViajesCSV(Integer idDep, BusquedaModel busquedaModel) {
        try {
            log.info("AQUÍ OBTENIENDO EL CSV");
            /* Obtener el String con la parte WHERE */
            String queryWhere = procesaFiltros(busquedaModel);
            /* Llamar al SP de búsqueda y enviar la parte WHERE como parámetro */
            List<ViajeResultModel> viajes = callViajesByFiltros(idDep, queryWhere);
            
            StringWriter sw = new StringWriter();
            CSVWriter writer = new CSVWriter(sw, '\t');
            
            for (ViajeResultModel v : viajes) {
                writer.writeNext(v.getDatos().toArray(new String[v.getDatos().size()]));
            }
            writer.close();
            log.info("YA LO OBTUVE: " + sw.toString());
            return sw.toString();
        } catch (Exception e) {
            log.error("ERROR AL FORMAR LA CADENA DE VIAJES CSV.", e);
            return "";
        }
    }

    /**
     * Procesa los filtros de búsqueda para construir la parte WHERE de la consulta por filtros.
     * @param busquedaModel
     * @return 
     */
    private String procesaFiltros(BusquedaModel busquedaModel) {
        String queryWhere = "";
        /* Crear la parte del WHERE del query */
        for (FiltroBusquedaModel p : busquedaModel.getParametros()) {
            if (p.getTipoControl().equals("SELECT") && p.getIdValor() != 0) {
                queryWhere += " AND " + p.getDescripcion() + " = " + p.getIdValor();
            } else {
                if (p.getComparador() == null) {
                    p.setComparador("=");
                }
                switch (p.getComparador()) {
                    case "LIKE":
                        queryWhere += " AND " + p.getDescripcion().replace(" ", "_") + " LIKE \"%" + p.getValor() + "%\"";
                        break;
                    case "=":
                        queryWhere += " AND " + p.getDescripcion().replace(" ", "_") + p.getComparador() + " \"" + p.getValor() + "\"";
                        break;
                    case "<":
                    case ">":
                    case "<=":
                    case ">=":
                        if (p.getTipoDato().equals("date")) {
                            queryWhere += " AND STR_TO_DATE(" + p.getDescripcion().replace(" ", "_")
                                    + ", \"%d/%m/%Y\")" + p.getComparador()
                                    + " STR_TO_DATE( \"" + p.getValor() + "\", \"%d/%m/%Y\")";
                        } else {
                            queryWhere += " AND " + p.getDescripcion().replace(" ", "_") + p.getComparador() + " \"" + p.getValor() + "\"";
                        }
                        break;
                    default: // same as =
                        queryWhere += " AND " + p.getDescripcion().replace(" ", "_") + p.getComparador() + " \"" + p.getValor() + "\"";
                        break;
                }
            }
        }
        return queryWhere;
    }

    /**
     * Llama al Stored Procedure para obtener los viajes por filtros de búsqueda
     *
     * @param idDependencia
     * @param queryWhere
     * @return
     */
    private List<ViajeResultModel> callViajesByFiltros(Integer idDependencia, String queryWhere) {
        Session session = em.unwrap(Session.class);
        List<ViajeResultModel> viajes = session.createSQLQuery("CALL get_viajes_por_filtros(:idDep, :queryWhere)")
                .setParameter("idDep", idDependencia)
                .setParameter("queryWhere", queryWhere)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeResultModel v = new ViajeResultModel();

                        List<String> datos = new ArrayList<>();
                        for (int i = 1; i < tuple.length; i++) {
                            datos.add((String) tuple[i]);
                        }

                        v.setId((Integer) tuple[0]);
                        v.setDatos(datos);
                        return v;
                    }
                })
                .list();
        
        session.flush();
        session.clear();
        return viajes;
    }

}
