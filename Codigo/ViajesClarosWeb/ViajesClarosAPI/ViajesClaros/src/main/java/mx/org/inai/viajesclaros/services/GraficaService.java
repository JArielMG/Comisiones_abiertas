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
package mx.org.inai.viajesclaros.services;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.model.FuncionarioModel;
import mx.org.inai.viajesclaros.model.GraficaDependenciaModel;
import mx.org.inai.viajesclaros.model.GraficaModel;
import mx.org.inai.viajesclaros.model.GraficaValueModel;
import mx.org.inai.viajesclaros.model.HotelModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.model.ViajeResumenModel;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 * Servicio para obtener los datos de las gráficas que se muestran en el sistema
 * web.
 *
 * @author sandro
 */
@Stateless
public class GraficaService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(GraficaService.class);

    /**
     * Obtiene los 3 funcionarios con mayor gasto en viajes
     *
     * @param idDependencia
     * @param anio
     * @return
     */
    public List<FuncionarioModel> getFuncionariosMayorGasto(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);
            List<FuncionarioModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL grafica_funcionarios_mayor_gasto_por_dep_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setTotalGasto((Double) tuple[4]);
                            f.setCargo((String) tuple[5]);
                            return f;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL grafica_funcionarios_mayor_gasto_por_dep(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setTotalGasto((Double) tuple[4]);
                            f.setCargo((String) tuple[5]);
                            return f;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS FUNCIONARIOS CON MAYOR GASTO", e);
            return new ArrayList<>();
        }
    }

    /**
     * Obtiene los 3 funcionarios con mayor número de viajes
     *
     * @param idDependencia
     * @param anio
     * @return
     */
    public List<FuncionarioModel> getFuncionariosMasViajes(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);
            List<FuncionarioModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL grafica_funcionarios_mas_viajes_por_dep_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setTotalViajes(((BigInteger) tuple[4]).intValue());
                            f.setCargo((String) tuple[5]);
                            return f;
                        }
                    })
                    .list();
            }else{
            
                list = session.createSQLQuery("CALL grafica_funcionarios_mas_viajes_por_dep(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setTotalViajes(((BigInteger) tuple[4]).intValue());
                            f.setCargo((String) tuple[5]);
                            return f;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS FUNCIONARIOS CON MÁS VIAJES", e);
            return new ArrayList<>();
        }
    }

    /**
     * Obtiene los ultimos viajes de la dependencia indicada
     *
     * @param idDependencia
     * @return
     */
    public List<ViajeResumenModel> getUltimosViajesPorDep(Integer idDependencia) {
        try {
            Session session = em.unwrap(Session.class);

            List<ViajeResumenModel> list = session.createSQLQuery("CALL grafica_ultimos_viajes_por_dep(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel viaje = new ViajeResumenModel();
                            viaje.setId((Integer) tuple[0]);
                            viaje.setFechaPublicacion((String) tuple[2]);
                            viaje.setNombreEvento((String) tuple[4]);
                            viaje.setPaisDestino((String) tuple[5]);
                            viaje.setCiudadDestino((String) tuple[6]);
                            return viaje;
                        }
                    })
                    .list();
            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS ÚLTIMOS VIAJES POR DEPENDENCIA", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Obtiene los tres últimos viajes por unidad administrativa
     * @param idUnidad
     * @param anio
     * @return 
     */
    public List<ViajeResumenModel> getUltimosViajesPorUnidad(Integer idUnidad, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<ViajeResumenModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL grafica_ultimos_viajes_por_area_anio(:idUnidad,:anio)")
                    .setParameter("idUnidad", idUnidad)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel viaje = new ViajeResumenModel();
                            viaje.setId((Integer) tuple[0]);
                            viaje.setFechaPublicacion((String) tuple[1]);
                            viaje.setNombreEvento((String) tuple[2]);
                            viaje.setPaisDestino((String) tuple[3]);
                            viaje.setCiudadDestino((String) tuple[4]);
                            viaje.setCostoTotal(tuple[5].toString());
                            return viaje;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL grafica_ultimos_viajes_por_area(:idUnidad)")
                    .setParameter("idUnidad", idUnidad)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel viaje = new ViajeResumenModel();
                            viaje.setId((Integer) tuple[0]);
                            viaje.setFechaPublicacion((String) tuple[1]);
                            viaje.setNombreEvento((String) tuple[2]);
                            viaje.setPaisDestino((String) tuple[3]);
                            viaje.setCiudadDestino((String) tuple[4]);
                            viaje.setCostoTotal(tuple[5].toString());
                            return viaje;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS ÚLTIMOS VIAJES POR UNIDAD", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * obtiene las unidades administrativas, sólo las que tienen viajes.
     * @return 
     */
    public List<SimpleObjectModel> getUnidadesAdministrativas() {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleObjectModel> list = session.createSQLQuery("CALL get_areas_con_comisiones()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel model = new SimpleObjectModel();
                            model.setId((Integer) tuple[0]);
                            model.setDescripcion((String) tuple[1]);
                            return model;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS ÚLTIMOS VIAJES POR UNIDAD", e);
            return new ArrayList<>();
        }
    }

    /**
     * obtiene los hoteles con más viajes de la dependencia indicada
     *
     * @param idDependencia
     * @param anio
     * @return lista de hoteles
     */
    public List<HotelModel> getHotelesMasVisitadosPorDep(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<HotelModel> list; 
            if (anio>0){
                list = session.createSQLQuery("CALL grafica_hoteles_por_dep_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            HotelModel hotel = new HotelModel();
                            hotel.setNombreHotel((String) tuple[0]);
                            hotel.setCiudad((String) tuple[1]);
                            hotel.setPais((String) tuple[2]);
                            hotel.setNumeroViajes(((BigInteger) tuple[3]).intValue());
                            return hotel;
                        }
                    })
                    .list();
            }else{
            list = session.createSQLQuery("CALL grafica_hoteles_por_dep(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            HotelModel hotel = new HotelModel();
                            hotel.setNombreHotel((String) tuple[0]);
                            hotel.setCiudad((String) tuple[1]);
                            hotel.setPais((String) tuple[2]);
                            hotel.setNumeroViajes(((BigInteger) tuple[3]).intValue());
                            return hotel;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS HOTELES MÁS VISITADOS", e);
            return new ArrayList<>();
        }
    }

    /**
     * Obtiene la gráfica de tipos de viaje
     * @param idDependencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaTipoViaje(Integer idDependencia, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_tipo_viaje_anio(" + idDependencia + "," + anio + ")");
        else    
            return getGraficaGeneric("grafica_tipo_viaje(" + idDependencia + ")");
    }
    
    /**
     * Obtiene los valores de la gráfica de tipos de pasaje (aéreo / terrestre)
     * @param idDepdencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaTipoPasaje(Integer idDepdencia, Integer anio) {
         if (anio>0)
            return getGraficaGeneric("grafica_tipo_pasaje_anio(" + idDepdencia + "," + anio + ")");
        else  
            return getGraficaGeneric("grafica_tipo_pasaje(" + idDepdencia + ")");
    }
    
    /**
     * Obtiene los valores de la gráfica de aerolíneas más usadas por dependencia
     * @param idDependencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaAerolineas(Integer idDependencia, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_aerolineas_por_dep_anio(" + idDependencia + "," + anio + ")");
        else  
            return getGraficaGeneric("grafica_aerolineas_por_dep(" + idDependencia + ")");
    }
    
    /**
     * Obtiene los valores de la gráfica de ciudades más visitadas
     * @param idDependencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaCiudadesInternacionales(Integer idDependencia, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_ciudades_internacionales_anio(" + idDependencia + "," + anio + ")");
        else  
            return getGraficaGeneric("grafica_ciudades_internacionales(" + idDependencia + ")");
    }
    
    /**
     * Obtiene los valores de la gráfica de ciudades nacionales más visitadas
     * @param idDependencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaCiudadesNacionales(Integer idDependencia, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_ciudades_nacionales_anio(" + idDependencia + "," + anio + ")");
        else  
            return getGraficaGeneric("grafica_ciudades_nacionales(" + idDependencia + ")");
    }
    
    /**
     * Obtiene los valores de la gráfica de número de viajes por mes
     * @param idDependencia
     * @param anio
     * @return 
     */
    public GraficaModel getGraficaViajesPorMes(Integer idDependencia, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_viajes_por_mes_anio(" + idDependencia + "," + anio + ")");
        else  
            return getGraficaGeneric("grafica_viajes_por_mes(" + idDependencia + ")");
    }
    
    public GraficaModel getGraficaViaticosPorFuncionario(FuncionarioModel func, Integer anio) {
        if (anio>0)
            return getGraficaGeneric("grafica_viaticos_por_funcionario_anio(" + func.getId() + ", '" 
                + func.getNombres() + "', '" + func.getApellido1() + "', '" + func.getApellido2() + "', "+
                    anio+")");
        else
            return getGraficaGeneric("grafica_viaticos_por_funcionario(" + func.getId() + ", '" 
                + func.getNombres() + "', '" + func.getApellido1() + "', '" + func.getApellido2() + "')");
    }
    
    /**
     * Obtiene los valores de una gráfica con el SP indicado
     * @param storedProcedure Nombre del stored procedure (con parámetros incluidos)
     * @return 
     */
    private GraficaModel getGraficaGeneric(String storedProcedure) {
        try {
            Session session = em.unwrap(Session.class);
            GraficaModel gm  = new GraficaModel();
            
            String sql = "CALL " + storedProcedure;
            List<GraficaValueModel> values = session.createSQLQuery(sql)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            GraficaValueModel v = new GraficaValueModel();
                            v.setLabel((String) tuple[0]);
                            v.setValue(Double.valueOf(tuple[1].toString()));
                            return v;
                        }
                    })
                    .list();
            
            gm.setValues(values);
            
            session.flush();
            session.clear();
            return gm;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LA GRÁFICA", e);
            return new GraficaModel();
        }
    }
    
    /**
     * 
     * @param idDependencia
     * @param anio
     * @return 
     */
    public SimpleObjectModel getTotalViaticos(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleObjectModel> list;
            if (anio>0){
                list = session.createSQLQuery("call get_total_viaticos_por_dependencia_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel model = new SimpleObjectModel();
                            model.setDescripcion(((Double) tuple[0]).toString());
                            return model;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("call get_total_viaticos_por_dependencia(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel model = new SimpleObjectModel();
                            model.setDescripcion(((Double) tuple[0]).toString());
                            return model;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new SimpleObjectModel();
            }
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LA GRÁFICA", e);
            return new SimpleObjectModel();
        }
    }
    
    /**
     * 
     * @param idDependencia
     * @param anio
     * @return 
     */
    public SimpleObjectModel getTotalPasajes(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleObjectModel> list;
            if (anio>0){
                list = session.createSQLQuery("call get_total_pasajes_por_dependencia_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel model = new SimpleObjectModel();
                            model.setDescripcion(((Double) tuple[0]).toString());
                            return model;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("call get_total_pasajes_por_dependencia(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel model = new SimpleObjectModel();
                            model.setDescripcion(((Double) tuple[0]).toString());
                            return model;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new SimpleObjectModel();
            }
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LA GRÁFICA", e);
            return new SimpleObjectModel();
        }
    }
    
    /**
     * obtiene las gráficas parametrizadas (activas e inactivas) para la dependencia indicada
     * @param idDependencia
     * @return 
     */
    public List<GraficaDependenciaModel> getGraficasParametrizadas(Integer idDependencia) {
        try {
            Session session = em.unwrap(Session.class);
            List<GraficaDependenciaModel> list = session.createSQLQuery("call get_graficas_por_dependencia(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            GraficaDependenciaModel model = new GraficaDependenciaModel();
                            model.setIdGrafica((Integer) tuple[0]);
                            model.setGrafica((String) tuple[1]);
                            Boolean b = ((BigInteger) tuple[3]).intValue() != 0;
                            model.setEnabled(b);
                            return model;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS GRÁFICAS PARAMETRIZADAS", e);
            return new ArrayList<>();
        }
    }

}
