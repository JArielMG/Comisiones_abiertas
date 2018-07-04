
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author sandro
 */
@Stateless
public class PersonaService {
    
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(PersonaService.class);
    
    /**
     * Obtiene los tipos de personas
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> getTiposPersona() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> list = session.createSQLQuery("CALL obten_tipo_personas()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId((Integer) tuple[0]);
                            domain.setCodigo((String) tuple[1]);
                            domain.setDescripcion((String) tuple[2]);
                            return domain;
                        }
                    })
                    .list();
            session.flush();
            session.clear();
            return list;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR LOS FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
}
