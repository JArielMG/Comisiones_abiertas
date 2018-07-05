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

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.model.FuncionarioModel;
import mx.org.inai.viajesclaros.model.MapMarkerModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import mx.org.inai.viajesclaros.model.ViajeResumenModel;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class ViajeService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(ViajeService.class);

    /**
     * Obtiene los principales datos del viaje indicado
     *
     * @param idViaje
     * @return
     */
    public ViajeResumenModel getResumenById(Integer idViaje) {
        try {
            Session session = em.unwrap(Session.class);

            List<ViajeResumenModel> list = session.createSQLQuery("CALL get_viaje_resumen_por_id(:idViaje)")
                    .setParameter("idViaje", idViaje)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel model = new ViajeResumenModel();
                            model.setId((Integer) tuple[0]);
                            model.setCostoTotal((String) tuple[1]);
                            model.setFechaInicio((String) tuple[2]);
                            model.setFechaFin((String) tuple[3]);
                            model.setPaisDestino((String) tuple[4]);
                            model.setCiudadDestino((String) tuple[5]);
                            model.setNombreEvento((String) tuple[6]);
                            return model;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new ViajeResumenModel();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR EL RESUMEN DEL VIAJE", e);
            return new ViajeResumenModel();
        }
    }

    /**
     * Obtiene los viajes del funcionario indicado
     *
     * @param func
     * @param anio
     * @return
     */
    public List<ViajeResumenModel> getViajesResumenByFuncionario(FuncionarioModel func, Integer anio) {
        Session session = em.unwrap(Session.class);

        List<ViajeResumenModel> viajes;
            if (anio>0){
                viajes = session.createSQLQuery("CALL get_viajes_resumen_por_persona_anio(:idFun, :nom, :ap1, :ap2, :anio)")
                .setParameter("idFun", func.getId())
                .setParameter("nom", func.getNombres())
                .setParameter("ap1", func.getApellido1())
                .setParameter("ap2", func.getApellido2())
                .setParameter("anio", anio)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeResumenModel viaje = new ViajeResumenModel();
                        viaje.setId((Integer) tuple[0]);
                        viaje.setCostoTotal(tuple[1].toString());
                        viaje.setFechaInicio(tuple[2].toString());
                        viaje.setFechaFin(tuple[3].toString());
                        viaje.setPaisDestino((String) tuple[4]);
                        viaje.setCiudadDestino((String) tuple[5]);
                        viaje.setNombreEvento((String) tuple[6]);
                        return viaje;
                    }
                })
                .list();
            }else{
                viajes = session.createSQLQuery("CALL get_viajes_resumen_por_persona(:idFun, :nom, :ap1, :ap2)")
                .setParameter("idFun", func.getId())
                .setParameter("nom", func.getNombres())
                .setParameter("ap1", func.getApellido1())
                .setParameter("ap2", func.getApellido2())
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeResumenModel viaje = new ViajeResumenModel();
                        viaje.setId((Integer) tuple[0]);
                        viaje.setCostoTotal(tuple[1].toString());
                        viaje.setFechaInicio(tuple[2].toString());
                        viaje.setFechaFin(tuple[3].toString());
                        viaje.setPaisDestino((String) tuple[4]);
                        viaje.setCiudadDestino((String) tuple[5]);
                        viaje.setNombreEvento((String) tuple[6]);
                        return viaje;
                    }
                })
                .list();
            }
        session.flush();
        session.clear();
        return viajes;
    }

    /**
     * Obtiene los datos del viaje de la categoría indicada
     *
     * @param model
     * @return
     */
    public List<SimpleObjectModel> getDavosViajePorCategoria(SimpleObjectModel model) {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleObjectModel> datos = session.createSQLQuery("CALL get_viaje_datos_por_categoria(:idViaje, :categoria)")
                    .setParameter("idViaje", model.getId())
                    .setParameter("categoria", model.getCodigo())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleObjectModel m = new SimpleObjectModel();
                            m.setCodigo((String) tuple[0]);
                            m.setDescripcion((String) tuple[1]);
                            return m;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return datos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS DATOS DEL VIAJE POR CATEGORÍA", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Obtiene la latitud y longitud de las ciudades visitadas de la dependencia
     * @param idDependencia
     * @param anio
     * @return 
     */
    public List<MapMarkerModel> getUbicacionesPorDependencia(Integer idDependencia, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<MapMarkerModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_ubicaciones_mapa_anio(:idDep,:anio)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            MapMarkerModel model = new MapMarkerModel();
                            model.setCiudad(tuple[0].toString());
                            model.setPais(tuple[1].toString());
                            model.setGastoTotal(tuple[2].toString());
                            model.setLat(tuple[3].toString());
                            model.setLng(tuple[4].toString());
                            model.setMessage(model.getGastoTotal() + " gasto hasta el día de hoy");
                            return model;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL get_ubicaciones_mapa(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            MapMarkerModel model = new MapMarkerModel();
                            model.setCiudad(tuple[0].toString());
                            model.setPais(tuple[1].toString());
                            model.setGastoTotal(tuple[2].toString());
                            model.setLat(tuple[3].toString());
                            model.setLng(tuple[4].toString());
                            model.setMessage(model.getGastoTotal() + " gasto hasta el día de hoy");
                            return model;
                        }
                    })
                    .list();
            }
            
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS UBICACIONES DE LOS VIAJES", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Obtiene la latitud y longitud de las ciudades visitadas del funcionario
     * @param func
     * @param anio
     * @return 
     */
    public List<MapMarkerModel> getUbicacionesPorFuncionario(FuncionarioModel func, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<MapMarkerModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_ubicaciones_mapa_por_persona_anio(:idFun, :nombres, :ap1, :ap2, :anio)")
                    .setParameter("idFun", func.getId())
                    .setParameter("nombres", func.getNombres())
                    .setParameter("ap1", func.getApellido1())
                    .setParameter("ap2", func.getApellido2())
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            MapMarkerModel model = new MapMarkerModel();
                            model.setCiudad(tuple[0].toString());
                            model.setPais(tuple[1].toString());
                            model.setGastoTotal(tuple[2].toString());
                            model.setLat(tuple[3].toString());
                            model.setLng(tuple[4].toString());
                            model.setMessage(model.getGastoTotal() + " gasto hasta el día de hoy");
                            return model;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL get_ubicaciones_mapa_por_persona(:idFun, :nombres, :ap1, :ap2)")
                    .setParameter("idFun", func.getId())
                    .setParameter("nombres", func.getNombres())
                    .setParameter("ap1", func.getApellido1())
                    .setParameter("ap2", func.getApellido2())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            MapMarkerModel model = new MapMarkerModel();
                            model.setCiudad(tuple[0].toString());
                            model.setPais(tuple[1].toString());
                            model.setGastoTotal(tuple[2].toString());
                            model.setLat(tuple[3].toString());
                            model.setLng(tuple[4].toString());
                            model.setMessage(model.getGastoTotal() + " gasto hasta el día de hoy");
                            return model;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS UBICACIONES DE LOS VIAJES POR FUNCIONARIO", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Obtiene los viajes realizados de la ciudad-pais indicados
     * @param viaje
     * @param anio
     * @return 
     */
    public List<ViajeResumenModel> getViajesResumenPorCiudadPais(ViajeResumenModel viaje, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<ViajeResumenModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_mapa_viajes_por_ciudad_pais_anio(:idDep, :ciudad, :pais, :anio)")
                    .setParameter("idDep", viaje.getIdDependencia())
                    .setParameter("ciudad", viaje.getCiudadDestino())
                    .setParameter("pais", viaje.getPaisDestino())
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel v = new ViajeResumenModel();
                            v.setId(Integer.valueOf(tuple[0].toString()));
                            v.setCiudadDestino(tuple[1].toString());
                            v.setPaisDestino(tuple[2].toString());
                            v.setFechaInicio(tuple[3].toString());
                            v.setIdFuncionario(Integer.valueOf(tuple[4].toString()));
                            v.setNombres(tuple[5].toString());
                            v.setApellido1(tuple[6].toString());
                            v.setApellido2(tuple[7].toString());
                            return v;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL get_mapa_viajes_por_ciudad_pais(:idDep, :ciudad, :pais)")
                    .setParameter("idDep", viaje.getIdDependencia())
                    .setParameter("ciudad", viaje.getCiudadDestino())
                    .setParameter("pais", viaje.getPaisDestino())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel v = new ViajeResumenModel();
                            v.setId(Integer.valueOf(tuple[0].toString()));
                            v.setCiudadDestino(tuple[1].toString());
                            v.setPaisDestino(tuple[2].toString());
                            v.setFechaInicio(tuple[3].toString());
                            v.setIdFuncionario(Integer.valueOf(tuple[4].toString()));
                            v.setNombres(tuple[5].toString());
                            v.setApellido1(tuple[6].toString());
                            v.setApellido2(tuple[7].toString());
                            return v;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS VIAJES DE LA CIUDAD-PAIS", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Obtiene los viajes realizados de la ciudad-pais indicados
     * @param viaje
     * @param anio
     * @return 
     */
    public List<ViajeResumenModel> getViajesResumenPorCiudadPaisFuncionario(ViajeResumenModel viaje, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<ViajeResumenModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_mapa_viajes_por_ciudad_pais_funcionario_anio(:idFun, :nombre, :primerApellido, :segundoApellido, :ciudad, :pais, :anio)")
                    .setParameter("idFun", viaje.getIdFuncionario())
                    .setParameter("nombre", viaje.getNombres())
                    .setParameter("primerApellido", viaje.getApellido1())
                    .setParameter("segundoApellido", viaje.getApellido2())
                    .setParameter("ciudad", viaje.getCiudadDestino())
                    .setParameter("pais", viaje.getPaisDestino())
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel v = new ViajeResumenModel();
                            v.setId(Integer.valueOf(tuple[0].toString()));
                            v.setCiudadDestino(tuple[1].toString());
                            v.setPaisDestino(tuple[2].toString());
                            v.setFechaInicio(tuple[3].toString());
                            v.setIdFuncionario(Integer.valueOf(tuple[4].toString()));
                            v.setNombres(tuple[5].toString());
                            v.setApellido1(tuple[6].toString());
                            v.setApellido2(tuple[7].toString());
                            return v;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL get_mapa_viajes_por_ciudad_pais_funcionario(:idFun, :nombre, :primerApellido, :segundoApellido, :ciudad, :pais)")
                    .setParameter("idFun", viaje.getIdFuncionario())
                    .setParameter("nombre", viaje.getNombres())
                    .setParameter("primerApellido", viaje.getApellido1())
                    .setParameter("segundoApellido", viaje.getApellido2())
                    .setParameter("ciudad", viaje.getCiudadDestino())
                    .setParameter("pais", viaje.getPaisDestino())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeResumenModel v = new ViajeResumenModel();
                            v.setId(Integer.valueOf(tuple[0].toString()));
                            v.setCiudadDestino(tuple[1].toString());
                            v.setPaisDestino(tuple[2].toString());
                            v.setFechaInicio(tuple[3].toString());
                            v.setIdFuncionario(Integer.valueOf(tuple[4].toString()));
                            v.setNombres(tuple[5].toString());
                            v.setApellido1(tuple[6].toString());
                            v.setApellido2(tuple[7].toString());
                            return v;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS VIAJES DE LA CIUDAD-PAIS", e);
            return new ArrayList<>();
        }
    }

}
