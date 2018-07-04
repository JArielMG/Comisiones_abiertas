
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CalendarEventDomain;
import mx.org.inai.viajesclaros.domain.FuncionarioDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class CalendarioService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(CalendarioService.class);

    /**
     * Obtiene los viajes del mes para mostrarlos en el calendario
     *
     * @param mes
     * @param anio
     * @param idArea
     * @param idFunc
     * @param status    estado del viaje: PUBLICADO, PENDIENTE, RECHAZADO
     * @return
     * @throws java.lang.Exception
     */
    public List<CalendarEventDomain> getEventosMes(Integer mes, Integer anio, Integer idArea, Integer idFunc, String status) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            log.info("idARea: " + idArea);
            List<CalendarEventDomain> eventos = session.createSQLQuery("CALL get_calendario_eventos_mes_anio("
                    + ":mes, :anio, :idArea, :idFunc, :status)")
                    .setParameter("mes", mes)
                    .setParameter("anio", anio)
                    .setParameter("idArea", idArea)
                    .setParameter("idFunc", idFunc)
                    .setParameter("status", status)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CalendarEventDomain domain = new CalendarEventDomain();
                            domain.setTitle((String) tuple[1]);
                            domain.setStart((String) tuple[2]);
                            domain.setStartShowed((String) tuple[3]);
                            domain.setEnd((String) tuple[4]);
                            domain.setEndShowed((String) tuple[5]);
                            domain.setUnidadAdministrativa((String) tuple[6]);
                            domain.setCiudadDestino((String) tuple[7]);
                            domain.setPaisDestino((String) tuple[8]);
                            domain.setStatus((String) tuple[9]);
                            domain.setColor((String) tuple[10]);
                            return domain;
                        }
                    })
                    .list();
            log.info(eventos.size() + " eventos");
            
            session.flush();
            session.clear();
            return eventos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS EVENTOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene las unidades administrativas
     * @param mes
     * @param anio
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> getUnidadesAdministrativas(Integer mes, Integer anio) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> areas = session.createSQLQuery("CALL get_areas_con_comisiones_calendar(:mes, :anio)")
                    .setParameter("mes", mes)
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId((Integer) tuple[0]);
                            domain.setDescripcion((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return areas;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LAS UNIDADES ADMINISTRATIVAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene los funcionarios de la unidad administrativa que tienen comisiones en el mes y año indicados
     * @param idArea
     * @param mes
     * @param anio
     * @return
     * @throws Exception 
     */
    public List<FuncionarioDomain> getFuncionariosPorUnidad(Integer idArea, Integer mes, Integer anio) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<FuncionarioDomain> list = session.createSQLQuery("CALL get_funcionarios_por_area_calendar(:idArea, :mes, :anio)")
                    .setParameter("mes", mes)
                    .setParameter("anio", anio)
                    .setParameter("idArea", idArea)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                           FuncionarioDomain domain = new FuncionarioDomain();
                           domain.setId((Integer) tuple[0]);
                           domain.setNombres((String) tuple[1]);
                           domain.setApellido1((String) tuple[2]);
                           domain.setApellido2((String) tuple[3]);
                           domain.setNombreCompleto(domain.getNombres() + " " + domain.getApellido1() + " " + domain.getApellido2());
                           return domain;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS FUNCIONARIOS DE LA UNIDAD. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

}
