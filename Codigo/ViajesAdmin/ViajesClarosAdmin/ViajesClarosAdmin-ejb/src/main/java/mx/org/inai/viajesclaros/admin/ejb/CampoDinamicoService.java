
package mx.org.inai.viajesclaros.admin.ejb;

import java.math.BigInteger;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CampoDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class CampoDinamicoService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(CampoDinamicoService.class);

    public List<CampoDomain> findAll() throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<CampoDomain> campos = session.createSQLQuery("CALL get_campos_dinamicos()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CampoDomain campo = new CampoDomain();
                            campo.setCampo((String) tuple[0]);
                            campo.setIdLista((Integer) tuple[1]);
                            campo.setDescripcion((String) tuple[2]);
                            campo.setDespliegue((String) tuple[3]);
                            campo.setIdTipoDato((Integer) tuple[5]);
                            campo.setIdTipoControl((Integer) tuple[6]);
                            campo.setTipoDato((String) tuple[7]);
                            campo.setTipoControl((String) tuple[8]);
                            campo.setNombreLista((String) tuple[9]);
                            campo.setCategoria((String) tuple[10]);
                            Boolean b = (Integer) tuple[11] != 0;
                            campo.setConstraintFails(b);
                            return campo;
                        }
                    }).list();

            session.flush();
            session.clear();
            return campos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR CAMPOS DINÁMICOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    public List<CampoDomain> findAllFiltro(String filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<CampoDomain> campos = session.createSQLQuery("CALL get_campos_dinamicos_filtrados(:filtro)")
                    .setParameter("filtro", filtro)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CampoDomain campo = new CampoDomain();
                            campo.setCampo((String) tuple[0]);
                            campo.setIdLista((Integer) tuple[1]);
                            campo.setDescripcion((String) tuple[2]);
                            campo.setDespliegue((String) tuple[3]);
                            campo.setIdTipoDato((Integer) tuple[5]);
                            campo.setIdTipoControl((Integer) tuple[6]);
                            campo.setTipoDato((String) tuple[7]);
                            campo.setTipoControl((String) tuple[8]);
                            campo.setNombreLista((String) tuple[9]);
                            campo.setCategoria((String) tuple[10]);
                            Boolean b = (Integer) tuple[11] != 0;
                            campo.setConstraintFails(b);
                            return campo;
                        }
                    }).list();

            session.flush();
            session.clear();
            return campos;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR CAMPOS DINÁMICOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Guarda un campo dinámico en la BD
     *
     * @param campo
     * @throws Exception
     */
    public void saveCampo(CampoDomain campo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            /* Validar que no exista un campo con el mismo nombre */
            List<CampoDomain> l = session.createSQLQuery("CALL get_campo_dinamico_por_nombre(:nombreCampo)")
                    .setParameter("nombreCampo", campo.getCampo())
                    .list();
            if (l.size() > 0) {
                throw new Exception("Ya existe un campo con el nombre: " + campo.getCampo());
            }
            
            session.createSQLQuery("CALL insert_campo_dinamico(:campo, :tipoDato, :idLista, "
                    + ":descripcion, :despliegue, :busquedaDef, :tipoControl, :categoria)")
                    .setParameter("campo", campo.getCampo())
                    .setParameter("tipoDato", campo.getIdTipoDato())
                    .setParameter("idLista", campo.getIdLista())
                    .setParameter("descripcion", campo.getDescripcion())
                    .setParameter("despliegue", campo.getDespliegue())
                    .setParameter("busquedaDef", 0)
                    .setParameter("tipoControl", campo.getIdTipoControl())
                    .setParameter("categoria", campo.getCategoria())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL GUARDAR EL CAMPO. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Actualiza el campo dinámico indicado
     * @param campo
     * @throws Exception 
     */
    public void updateCampo(CampoDomain campo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL update_campo_dinamico(:campo, :idTipoDato, :idLista, "
                    + ":descripcion, :despliegue, :busquedaDefecto, :idTipoControl, :categoria)")
                    .setParameter("campo", campo.getCampo())
                    .setParameter("idTipoDato", campo.getIdTipoDato())
                    .setParameter("idLista", campo.getIdLista())
                    .setParameter("descripcion", campo.getDescripcion())
                    .setParameter("despliegue", campo.getDespliegue())
                    .setParameter("busquedaDefecto", 0)
                    .setParameter("idTipoControl", campo.getIdTipoControl())
                    .setParameter("categoria", campo.getCategoria())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL CAMPO. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina el campo indicado
     * @param nombreCampo
     * @throws Exception 
     */
    public void deleteCampo(String nombreCampo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            session.createSQLQuery("CALL delete_campo_dinamico(:nombreCampo)")
                    .setParameter("nombreCampo", nombreCampo)
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR EL CAMPO. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene el catálogo de tipos de datos
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> getTiposDato() throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleElementDomain> tipos = session.createSQLQuery("CALL get_tipos_dato()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(((BigInteger) tuple[0]).intValue());
                            domain.setDescripcion((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return tipos;
        } catch (Exception e) {
            log.error("ERROR AL OBTENER LOS TIPOS DE DATOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene el catálogo de tipos de control
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> getTiposControl() throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleElementDomain> tipos = session.createSQLQuery("CALL get_tipos_control()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId(((BigInteger) tuple[0]).intValue());
                            domain.setDescripcion((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            return tipos;
        } catch (Exception e) {
            log.error("ERROR AL OBTENER LOS TIPOS DE DATOS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene el catálogo de categorías de campos
     * @return
     * @throws Exception 
     */
    public List<SimpleElementDomain> gatCategorias() throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SimpleElementDomain> categorias = session.createSQLQuery("CALL get_categorias_campo()")
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
            return categorias;
        } catch(Exception e) {
            log.error("ERROR AL OBTENER EL CATÁLOGO DE CATEGORÍAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
            
}
