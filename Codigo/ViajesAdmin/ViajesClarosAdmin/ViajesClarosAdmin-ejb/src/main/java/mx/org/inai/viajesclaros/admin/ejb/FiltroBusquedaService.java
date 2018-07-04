
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.admin.util.TipoControl;
import mx.org.inai.viajesclaros.domain.DespliegueBusquedaDomain;
import mx.org.inai.viajesclaros.domain.FiltroBusquedaDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class FiltroBusquedaService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    /**
     * Obtiene los filtros de búsqueda de la dependencia indicada
     *
     * @param idDependencia
     * @return filtros de búsqueda
     */
    public List<FiltroBusquedaDomain> getFiltrosByDependencia(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<FiltroBusquedaDomain> filtros = session.createSQLQuery("CALL get_filtros_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FiltroBusquedaDomain filtro = new FiltroBusquedaDomain();

                        filtro.setId((Integer) tuple[0]);
                        filtro.setTabla((String) tuple[1]);
                        filtro.setCampo((String) tuple[2]);
                        filtro.setDescripcion((String) tuple[3]);
                        filtro.setTipoDato((String) tuple[4]);
                        filtro.setTipoControl((String) tuple[5]);
                        filtro.setIdCatalogo(0);
                        filtro.setComparador((String) tuple[6]);
                        filtro.setIdLista((Integer) tuple[7]);

                        return filtro;
                    }
                })
                .list();

        /* Si el filtro es catálogo, se deben traer los elementos del catálogo */
        for (FiltroBusquedaDomain f : filtros) {
            if (f.getTipoControl().equals(TipoControl.SELECT) && !f.getTabla().equals("")) {
                List<SimpleElementDomain> cat = session.createSQLQuery("CALL get_catalogo_tabla_campo(:tabla, :campo)")
                        .setParameter("tabla", f.getTabla())
                        .setParameter("campo", f.getCampo())
                        .setResultTransformer(new BasicTransformerAdapter() {
                            private static final long serialVersionUID = 1L;

                            @Override
                            public Object transformTuple(Object[] tuple, String[] aliases) {
                                Integer id = (Integer) tuple[0];
                                String descripcion = (String) tuple[1];

                                return new SimpleElementDomain(id, descripcion);
                            }
                        })
                        .list();
                f.setCatalogo(cat);
            } else if (f.getTipoControl().equals(TipoControl.SELECT) && f.getIdLista() != null) {
                /* Es un catálogo de campos dinámicos */
                List<SimpleElementDomain> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                        .setParameter("idLista", f.getIdLista())
                        .setResultTransformer(new BasicTransformerAdapter() {
                            private static final long serialVersionUID = 1L;

                            @Override
                            public Object transformTuple(Object[] tuple, String[] aliases) {
                                Integer id = (Integer) tuple[0];
                                String descripcion = (String) tuple[2];
                                return new SimpleElementDomain(id, descripcion);
                            }
                        })
                        .list();
                f.setCatalogo(cat);
            }
        }
        
        session.flush();
        session.clear();

        return filtros;
    }

    /**
     * Obtiene los elementos del catálogo de comparadores
     *
     * @return comparadores
     */
    public List<SimpleElementDomain> getCatalogoComparador() {
        Session session = em.unwrap(Session.class);

        List<SimpleElementDomain> tipos = session.createSQLQuery("CALL get_cat_comparadores()")
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
        return tipos;
    }
    
    /**
     * Guarda un nuevo filtro de búsqueda
     * @param filtro
     * @throws Exception 
     */
    public void saveFiltroBusqueda(FiltroBusquedaDomain filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_buscador_filtros_config(:idDep, :tabla, :campo, :operador)")
                    .setParameter("idDep", filtro.getIdDependencia())
                    .setParameter("tabla", filtro.getTabla())
                    .setParameter("campo", filtro.getCampo())
                    .setParameter("operador", filtro.getComparador())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina un filtro de búsqueda
     * @param filtro
     * @throws Exception 
     */
    public void deleteFiltroBusqueda(FiltroBusquedaDomain filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_buscador_filtro(:idDep, :tabla, :campo)")
                    .setParameter("idDep", filtro.getIdDependencia())
                    .setParameter("tabla", filtro.getTabla())
                    .setParameter("campo", filtro.getCampo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina en elemento de despliegue de búsqueda de la dependencia indicada
     * @param domain Objeto de tipo DespliegueBusquedaDomain
     * @throws Exception 
     */
    public void deleteDespliegueBusqueda(DespliegueBusquedaDomain domain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_buscador_despliegue(:idDep, :tabla, :campo)")
                    .setParameter("idDep", domain.getIdDependencia())
                    .setParameter("tabla", domain.getTabla())
                    .setParameter("campo", domain.getCampo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Guarda un elemento de despliegue de búsqueda para la dependencia indicada
     * @param domain Despliegue a guardar
     * @throws Exception 
     */
    public void saveDespliegueBusqueda(DespliegueBusquedaDomain domain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_buscador_despliegue_config(:idDep, :tabla, :campo)")
                    .setParameter("idDep", domain.getIdDependencia())
                    .setParameter("tabla", domain.getTabla())
                    .setParameter("campo", domain.getCampo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        }
    }

}
