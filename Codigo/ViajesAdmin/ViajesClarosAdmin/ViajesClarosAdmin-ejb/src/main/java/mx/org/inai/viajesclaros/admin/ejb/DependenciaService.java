
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.DependenciaDomain;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class DependenciaService {
    
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;
    
    public List<DependenciaDomain> findAll() {
        Session session = em.unwrap(Session.class);
        
        List<DependenciaDomain> dependencias = session.createSQLQuery("CALL get_dependencias()")
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        DependenciaDomain dependencia = new DependenciaDomain();
                        dependencia.setId((Integer) tuple[0]);
                        dependencia.setDependencia((String) tuple[1]);
                        dependencia.setSiglas((String) tuple[2]);

                        return dependencia;
                    }
                })
                .list();
        
        session.flush();
        session.clear();
        return dependencias;
    }
}
