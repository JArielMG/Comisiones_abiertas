
package mx.org.inai.viajesclaros.admin.ejb;

import java.math.BigInteger;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.GraficaDependenciaDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class GraficaService {
    
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;
    
    final static Logger log = Logger.getLogger(GraficaService.class);
    
    /**
     * Obtiene el catálogo de gráficas
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> findAll() throws Exception {
        Session session = em.unwrap(Session.class);
        List<SimpleElementDomain> list = session.createSQLQuery("CALL get_graficas")
                .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setCodigo((String) tuple[0]);
                            domain.setDescripcion((String) tuple[1]);
                            return domain;
                        }
                })
                .list();
        
        session.flush();
        session.clear();
        return list;
    }
    
    /**
     * Obtiene las gráficas de le dependencia indicada
     * @param idDependencia
     * @return
     * @throws Exception 
     */
    public List<GraficaDependenciaDomain> findByDependencia(Integer idDependencia) throws Exception {
        Session session = em.unwrap(Session.class);
        final Integer  idDep = idDependencia;
        List<GraficaDependenciaDomain> list = session.createSQLQuery("CALL get_graficas_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            GraficaDependenciaDomain domain = new GraficaDependenciaDomain();
                            domain.setIdGrafica((Integer) tuple[0]);
                            domain.setGrafica((String) tuple[1]);
                            domain.setIdDependencia(idDep); // Para que todos los registros tengan la id de dependencia
                            Boolean b = ((BigInteger) tuple[3]).intValue() != 0;
                            domain.setEnabled(b);
                            domain.setCodigoGrafica((String) tuple[4]);
                            return domain;
                        }
                })
                .list();
        
        session.flush();
        session.clear();
        return list;
    }
    
    /**
     * Guarda la parametrización de las gráficas de la dependencia indicada
     * @param list
     * @throws Exception 
     */
    public void saveGraficasDependencia(List<GraficaDependenciaDomain> list) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            /* Elimiar las gráficas esa dependencia y luego insertar las nuevas */
            session.createSQLQuery("CALL delete_graficas_dependencia(:idDep)")
                    .setParameter("idDep", list.get(0).getIdDependencia())
                    .executeUpdate();
            
            for (GraficaDependenciaDomain graf : list) {
                if (graf.getEnabled()) {
                    session.createSQLQuery("CALL insert_grafica_config(:idDep, :idGraf)")
                            .setParameter("idDep", graf.getIdDependencia())
                            .setParameter("idGraf", graf.getIdGrafica())
                            .executeUpdate();
                    
                    session.flush();
                    session.clear();
                }
            }
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR LA PARAMETRIZACIÓN DE GRÁFICAS.", e);
            throw new Exception(e.getMessage());
        }
    }
}
