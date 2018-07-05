
package mx.org.inai.viajesclaros.admin.ejb;

import java.math.BigDecimal;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CampoDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.TablaCampoDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 * Clase para las operaciones con la tabla viajes_claros_config, que es la
 * referencia tabla - campo
 *
 * @author Sandro Alejandro
 */
@Stateless
public class TablaCampoService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(TablaCampoService.class);

    /**
     * Devuelve todos los registros de la tabla viajes_claros_config
     *
     * @return
     * @throws Exception
     */
    public List<TablaCampoDomain> findAll() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            return session.createSQLQuery("CALL get_viajes_claros_config()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            TablaCampoDomain domain = new TablaCampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            Boolean b = ((BigDecimal) tuple[2]).intValue() != 0; // Si es dif de 0, no se puede eliminar
                            domain.setConstraintFails(b);
                            return domain;
                        }
                    })
                    .list();
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR CAMPOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Guarda un registro tabla-campo (viajes_claros_config)
     *
     * @param tablaCampo
     * @throws Exception
     */
    public void save(TablaCampoDomain tablaCampo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_viajes_claros_config(:tabla, :campo)")
                    .setParameter("tabla", tablaCampo.getTabla())
                    .setParameter("campo", tablaCampo.getCampo())
                    .executeUpdate();
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL GUARDAR EN viajes_claros_config. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Elimina un registro tabla-campo (viajes_claros_config)
     *
     * @param tablaCampo
     * @throws Exception
     */
    public void delete(TablaCampoDomain tablaCampo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_viajes_claros_config(:tabla, :campo)")
                    .setParameter("tabla", tablaCampo.getTabla())
                    .setParameter("campo", tablaCampo.getCampo())
                    .executeUpdate();
            session.flush();
            session.clear();
        } catch (ConstraintViolationException e) {
            log.error("ERROR AL ELIMINAR DE viajes_claros_config. " + e.getMessage());
            throw new Exception("Error al eliminar el campo, existen datos dependientes de este campo.");
        } catch (Exception e) {
            log.error("ERROR AL ELIMINAR DE viajes_claros_config. " + e.getMessage());
            throw new Exception("Error al eliminar el campo.");
        }
    }

    public List<SimpleElementDomain> findTablas() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> tablas = session.createSQLQuery("CALL get_tablas()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(0);
                            domain.setDescripcion((String) tuple[0]);
                            return domain;
                        }
                    })
                    .list();
            session.flush();
            session.clear();
            return tablas;
        } catch (Exception e) {
            log.error("ERROR AL OBTENER LAS TABLAS. " + e.getMessage());
            throw new Exception("Error al obtener las tablas.");
        }
    }

    /**
     * Devuelve los campos de despliegue de la tabla indicada (sólo los que no
     * han sido agregados)
     *
     * @param idDep Id dependencia
     * @param tabla Nombre de la tabla
     * @return lista de campos
     */
    public List<CampoDomain> findCamposDespliegueDispobibles(Integer idDep, String tabla) {
        Session session = em.unwrap(Session.class);

        List<CampoDomain> campos = session.createSQLQuery("CALL get_campos_despliegue_disponibles(:idDep, :tabla)")
                .setParameter("idDep", idDep)
                .setParameter("tabla", tabla)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        CampoDomain domain = new CampoDomain();
                        domain.setTabla((String) tuple[0]);
                        domain.setCampo((String) tuple[1]);
                        domain.setDespliegue((String) tuple[2]);
                        domain.setTipoDato("");
                        domain.setTipoControl("");
                        return domain;
                    }
                })
                .list();

        session.flush();
        session.clear();
        return campos;
    }

    /**
     * Obtiene los filtros de búsqueda que no han sido parametrizados para la
     * dependencia indicada
     *
     * @param idDep
     * @param tabla
     * @return lista de campos
     * @throws java.lang.Exception
     */
    public List<CampoDomain> findFiltrosDispobibles(Integer idDep, String tabla) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<CampoDomain> campos = session.createSQLQuery("CALL get_campos_filtros_disponibles(:idDep, :tabla)")
                    .setParameter("idDep", idDep)
                    .setParameter("tabla", tabla)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CampoDomain domain = new CampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            domain.setDespliegue((String) tuple[2]);
                            domain.setTipoDato((String) tuple[3]);
                            domain.setTipoControl((String) tuple[4]);
                            return domain;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            return campos;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public List<SimpleElementDomain> findTablasFiltrosDisponibles(Integer idDep) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleElementDomain> tablas = session.createSQLQuery("CALL get_tablas_filtros_disponibles(:idDep)")
                    .setParameter("idDep", idDep)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(0);
                            domain.setDescripcion((String) tuple[0]);
                            return domain;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            return tablas;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene únicamente las tablas que tienen campos que aún no se han
     * parametrizado para la dependencia indicada.
     *
     * @param idDep
     * @return
     * @throws Exception
     */
    public List<SimpleElementDomain> findTablasDespliegueDisponibles(Integer idDep) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleElementDomain> tablas = session.createSQLQuery("CALL get_tablas_despliegue_disponibles(:idDep)")
                    .setParameter("idDep", idDep)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(0);
                            domain.setDescripcion((String) tuple[0]);
                            return domain;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            return tablas;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene los campos que aún no han sido agregados a viajes_claros_config
     *
     * @param filtro
     * @return
     * @throws Exception
     */
    public List<TablaCampoDomain> findCamposConfigDisponibles(String filtro) throws Exception {
        return findCamposConfigDisponibles(null, filtro);
    }
    
    /**
     * Obtiene los campos que aún no han sido agregados a viajes_claros_config de la tabla indicada
     * 
     * @param nombreTabla
     * @param filtro
     * @return
     * @throws Exception 
     */
    public List<TablaCampoDomain> findCamposConfigDisponiblesPorTabla(String nombreTabla, String filtro) throws Exception {
        return findCamposConfigDisponibles(nombreTabla, filtro);
    }
    
    public List<TablaCampoDomain> findCamposConfigDisponiblesPorTabla(String nombreTabla) throws Exception {
        return findCamposConfigDisponibles(nombreTabla, "");
    }
    
    /**
     * Obtiene los campos base y dinámicos que aún no han sido agregados a viajes_claros_config.
     * Si nombreTabla es diferente de null, devuelve sólo los de dicha tabla.
     * @param nombreTabla
     * @return
     * @throws Exception 
     */
    private List<TablaCampoDomain> findCamposConfigDisponibles(String nombreTabla, String filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<TablaCampoDomain> campos = session.createSQLQuery("CALL get_campos_config_disponibles(:tabla, :filtro)")
                    .setParameter("tabla", nombreTabla) // Si es null, obtiene todos
                    .setParameter("filtro", filtro)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            TablaCampoDomain domain = new TablaCampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            session.flush();
            session.clear();
            return campos;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
    

    /**
     * Obtiene los campos que han sido agregados a viajes_claros_config, de la
     * tabla indicada
     *
     * @param nombreTabla
     * @return
     * @throws java.lang.Exception
     */
    public List<TablaCampoDomain> findCamposConfigPorTabla(String nombreTabla) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<TablaCampoDomain> campos = session.createSQLQuery("CALL get_campos_config_por_tabla(:tabla)")
                    .setParameter("tabla", nombreTabla)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            TablaCampoDomain domain = new TablaCampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            Boolean b = ((BigDecimal) tuple[2]).intValue() != 0;
                            domain.setConstraintFails(b);
                            return domain;
                        }
                    })
                    .list();
            return campos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS CONFIG. POR TABLA.", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene las tablas que tienen campos disponibles para configurar en la carga masiva
     * @param idDep
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> findTablasCargaDisponibles(Integer idDep) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> tablas = session.createSQLQuery("CALL get_tablas_carga_disponibles(:idDep)")
                    .setParameter("idDep", idDep)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;
                        
                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(0);
                            domain.setDescripcion((String) tuple[0]);
                            return domain;
                        }
                    })
                    .list();
            return tablas;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS TABLAS DISPONIBLES PARA CARGA MASIVA.", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene los campos disponibles para configurar en la carga masiva; de la tabla indicada
     * @param idDependencia
     * @param nombreTabla
     * @return
     * @throws Exception 
     */
    public List<TablaCampoDomain> findCamposCargaPorTabla(Integer idDependencia, String nombreTabla) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<TablaCampoDomain> campos = session.createSQLQuery("CALL get_campos_carga_disponibles(:idDep, :tabla)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("tabla", nombreTabla)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            TablaCampoDomain domain = new TablaCampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            return campos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS CONFIG. POR TABLA.", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene las tablas que tienen campos disponibles para la pantalla del flujo indicado
     * @param idFlujo
     * @param idTipoPersona
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> findTablasFlujoDisponibles(Integer idFlujo, Integer idTipoPersona) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> tablas = session.createSQLQuery("CALL get_tablas_flujo_disponibles(:idFlujo, :idTipoPersona)")
                    .setParameter("idFlujo", idFlujo)
                    .setParameter("idTipoPersona", idTipoPersona)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;
                        
                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(0);
                            domain.setDescripcion((String) tuple[0]);
                            return domain;
                        }
                    })
                    .list();
            return tablas;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS TABLAS DISPONIBLES PARA CARGA MASIVA.", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene los campos disponibles (aún no configurados) para el
     * @param idFlujo
     * @param idTipoPersona
     * @param nombreTabla
     * @return
     * @throws Exception 
     */
    public List<TablaCampoDomain> findCamposFlujoPorTabla(Integer idFlujo, Integer idTipoPersona, String nombreTabla) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<TablaCampoDomain> campos = session.createSQLQuery("CALL get_campos_flujo_disponibles(:idFlujo, :idTipoPersona, :tabla)")
                    .setParameter("idFlujo", idFlujo)
                    .setParameter("idTipoPersona", idTipoPersona)
                    .setParameter("tabla", nombreTabla)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            TablaCampoDomain domain = new TablaCampoDomain();
                            domain.setTabla((String) tuple[0]);
                            domain.setCampo((String) tuple[1]);
                            domain.setCategoria((String) tuple[3]);
                            return domain;
                        }
                    })
                    .list();
            return campos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS CONFIG. POR TABLA.", e);
            throw new Exception(e.getMessage());
        }
    }
    
}
