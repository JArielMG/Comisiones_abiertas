
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CampoDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class CampoBaseService {
    
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(CampoBaseService.class);
    
    public List<CampoDomain> findAll() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            List<CampoDomain> campos = session.createSQLQuery("CALL get_campos_base()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        CampoDomain campo = new CampoDomain();
                        campo.setTabla((String) tuple[0]);
                        campo.setCampo((String) tuple[1]);
                        campo.setDescripcion((String) tuple[2]);
                        campo.setDespliegue((String) tuple[3]);
                        campo.setIdTipoDato((Integer) tuple[5]);
                        campo.setIdTipoControl((Integer) tuple[6]);
                        campo.setTipoDato((String) tuple[7]);
                        campo.setTipoControl((String) tuple[8]);
                        return campo;
                    }
                }).list();
            
            session.flush();
            session.clear();
            return campos;
        } catch(Exception e) {
            log.error("ERROR AL CONSULTAR CAMPOS DINÁMICOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
}
