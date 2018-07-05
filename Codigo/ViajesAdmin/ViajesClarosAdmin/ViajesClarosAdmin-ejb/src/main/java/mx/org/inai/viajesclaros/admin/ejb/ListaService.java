
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.ListaValoresDomain;
import mx.org.inai.viajesclaros.domain.ValorListaDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 * Servicio para las operaciones con las tablas de listas y valores_dinamicos
 *
 * @author Sandro Alejandro
 */
@Stateless
public class ListaService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(ListaService.class);

    public List<ListaValoresDomain> findAll() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            List<ListaValoresDomain> listas = session.createSQLQuery("CALL get_listas_valores()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ListaValoresDomain domain = new ListaValoresDomain();
                            domain.setIdList((Integer) tuple[0]);
                            domain.setNombreLista((String) tuple[1]);
                            domain.setHabilitada((Boolean) tuple[2]);
                            Boolean b = (Integer)tuple[3] != 0; // Si es dif de 0, no se puede eliminar
                            domain.setConstraintFails(b);
                            return domain;
                        }
                    }).list();
            
            session.flush();
            session.clear();
            return listas;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LISTAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    public List<ListaValoresDomain> findAllOrdenada() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            List<ListaValoresDomain> listas = session.createSQLQuery("CALL get_listas_valores_ordenada()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ListaValoresDomain domain = new ListaValoresDomain();
                            domain.setIdList((Integer) tuple[0]);
                            domain.setNombreLista((String) tuple[1]);
                            domain.setHabilitada((Boolean) tuple[2]);
                            Boolean b = (Integer)tuple[3] != 0; // Si es dif de 0, no se puede eliminar
                            domain.setConstraintFails(b);
                            return domain;
                        }
                    }).list();
            
            session.flush();
            session.clear();
            return listas;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LISTAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene todos los valores dinámicos
     * @return
     * @throws Exception 
     */
    /*public List<ValorListaDomain> findAllValores() throws Exception {
        return this.findValoresDinamicos(null);
    }*/
    
    /**
     * Obtiene los valores dinámicos de la lista indicada
     * @param idLista
     * @return
     * @throws Exception 
     */
    /*public List<ValorListaDomain> findValoresPorIdLista(Integer idLista) throws Exception {
        return this.findValoresDinamicos(idLista);
    }*/
    
    /**
     * Consulta los valores dinámicos de la lista indicada; si el idLista es null, obtiene todos los valores
     * @param idLista
     * @return
     * @throws Exception 
     */
    private List<ValorListaDomain> findValoresDinamicos(Integer idLista, String filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<ValorListaDomain> valores = session.createSQLQuery("CALL get_valores_dinamicos_filtro(:idLista, :filtro)")
                    .setParameter("idLista", idLista)
                    .setParameter("filtro", filtro)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ValorListaDomain domain = new ValorListaDomain();
                            domain.setIdLista((Integer) tuple[0]);
                            domain.setCodigo((String) tuple[1]);
                            domain.setValor((String) tuple[2]);
                            domain.setNombreLista((String) tuple[3]);
                            return domain;
                        }
                    }).list();

            session.flush();
            session.clear();
            return valores;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS VALORES DE LISTAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Guarda un registro en listas_valores
     * @param nombreLista
     * @throws Exception 
     */
    public void saveLista(String nombreLista) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            session.createSQLQuery("CALL insert_listas_valores(:nombreLista)")
                    .setParameter("nombreLista", nombreLista)
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR LA LISTA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Guarda un valor dinámico asociado a una lista
     * @param valor
     * @throws Exception 
     */
    public void saveValor(ValorListaDomain valor) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            /* Validar que no exista el código para esa lista */
            List <ValorListaDomain> list = session.createSQLQuery("CALL exists_valor_dinamico(:idLista, :codigo)")
                    .setParameter("idLista", valor.getIdLista())
                    .setParameter("codigo", valor.getCodigo())
                    .list();
            if (list.size() > 0) {
                throw new Exception("Ya existe un valor para esta lista con el código " + valor.getCodigo());
            }
            
            session.createSQLQuery("CALL insert_valores_dinamicos(:idLista, :codigo, :valor)")
                    .setParameter("idLista", valor.getIdLista())
                    .setParameter("codigo", valor.getCodigo())
                    .setParameter("valor", valor.getValor())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR EL VALOR DINÁMICO. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Actualiza el nombre de una lista
     * @param lista
     * @throws Exception 
     */
    public void updateLista(ListaValoresDomain lista) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            session.createSQLQuery("CALL update_listas_valores(:idLista, :nombreLista, :isHabilitada)")
                    .setParameter("idLista", lista.getIdList())
                    .setParameter("nombreLista", lista.getNombreLista())
                    .setParameter("isHabilitada", true)
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR LA LISTA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    public void updateValor(ValorListaDomain valor) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            session.createSQLQuery("CALL update_valor_dinamico(:idLista, :codigo, :valor)")
                    .setParameter("idLista", valor.getIdLista())
                    .setParameter("codigo", valor.getCodigo())
                    .setParameter("valor", valor.getValor())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL VALOR. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina la lista con el id indicado
     * @param idLista
     * @throws Exception 
     */
    public void deleteLista(Integer idLista) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            session.createSQLQuery("CALL delete_listas_valores(:idLista)")
                    .setParameter("idLista", idLista)
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR LA LISTA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina un valor dinámico asociado a una lista
     * @param valor
     * @throws Exception 
     */
    public void deleteValor(ValorListaDomain valor) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            session.createSQLQuery("CALL delete_valores_dinamicos(:idLista, :codigo)")
                    .setParameter("idLista", valor.getIdLista())
                    .setParameter("codigo", valor.getCodigo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR EL VALOR. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    ////////LEO
    public List<ListaValoresDomain> findAllFilter(String filtro) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            
            List<ListaValoresDomain> listas = session.createSQLQuery("CALL get_listas_valores_filtradas(:filtro)")
                    .setParameter("filtro", filtro)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ListaValoresDomain domain = new ListaValoresDomain();
                            domain.setIdList((Integer) tuple[0]);
                            domain.setNombreLista((String) tuple[1]);
                            domain.setHabilitada((Boolean) tuple[2]);
                            Boolean b = (Integer)tuple[3] != 0; // Si es dif de 0, no se puede eliminar
                            domain.setConstraintFails(b);
                            return domain;
                        }
                    }).list();
            
            session.flush();
            session.clear();
            return listas;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LISTAS FILTRADAS. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }
    
    public List<ValorListaDomain> findAllValores(String filtro) throws Exception {
        return this.findValoresDinamicos(null, filtro);
    }
    
    public List<ValorListaDomain> findValoresPorIdLista(Integer idLista, String filtro) throws Exception {
        return this.findValoresDinamicos(idLista, filtro);
    }
    //////////////
}
