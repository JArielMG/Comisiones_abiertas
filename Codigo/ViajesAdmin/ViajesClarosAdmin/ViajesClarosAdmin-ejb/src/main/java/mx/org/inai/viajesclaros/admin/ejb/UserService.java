
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.PerfilDomain;
import mx.org.inai.viajesclaros.domain.UsuarioDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class UserService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(UserService.class);

    public UsuarioDomain findByUsername(String username) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<UsuarioDomain> users = session.createSQLQuery("CALL get_usuario_por_nombre_usuario(:usuario)")
                    .setParameter("usuario", username)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            UsuarioDomain domain = new UsuarioDomain();
                            PerfilDomain perfil  = new PerfilDomain();
                            domain.setId((Integer) tuple[0]);
                            domain.setUsuario((String) tuple[1]);
                            domain.setContrasena((String) tuple[2]);
                            domain.setDescripcion((String) tuple[3]);
                            domain.setHabilitado((Boolean) tuple[4]);
                            domain.setIntentos((Integer) tuple[5]);
                            domain.setIdPerfil((Integer) tuple[6]);
                            perfil.setId((Integer) tuple[6]);
                            perfil.setNombre((String) tuple[7]);
                            domain.setPerfil(perfil);
                            domain.setIdDependencia((Integer) tuple[8]);
                            domain.setIdPersona((Integer) tuple[9]);
                            domain.setIdArea((Integer) tuple[10]);
                            domain.setSalt((String) tuple[11]);
                            return domain;
                        }
                    })
                    .list();
            session.flush();
            session.clear();
            if (users.size() > 0) {
                return users.get(0);
            } else {
                return new UsuarioDomain();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR USUARIO", e);
            throw new Exception(e.getMessage());
        }
    }
}
