
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CargaColumnDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class CargaMasivaService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(CargaMasivaService.class);

    /**
     * obtiene los encabezados de las columnas para la carga masiva
     *
     * @param idDependencia
     * @return
     * @throws Exception
     */
    public List<CargaColumnDomain> getEncabezadoCarga(Integer idDependencia) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<CargaColumnDomain> encabezados = session.createSQLQuery("CALL get_headers_carga(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CargaColumnDomain domain = new CargaColumnDomain();
                            domain.setIdDependencia((Integer) tuple[0]);
                            domain.setTabla((String) tuple[1]);
                            domain.setCampo((String) tuple[2]);
                            domain.setDespliegue((String) tuple[3]);
                            domain.setEditable((Boolean) tuple[4]);
                            domain.setSecuencia((Integer) tuple[5]);
                            domain.setListaHabilitada((Boolean) tuple[6]);
                            return domain;
                        }
                    })
                    .list();
        
            session.flush();
            session.clear();
            return encabezados;
        } catch (Exception e) {
            log.error("ERROR AL OBTENER LOS ENCABEZADOS DE CARGA MASIVA.", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene los viajes de la dependencia indicada (con los campos de carga masiva)
     *
     * @param idDependencia
     * @return
     */
    public List<ViajeDomain> findViajesByDependenciaCarga(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<ViajeDomain> viajes = session.createSQLQuery("CALL get_viajes_por_dependencia_carga(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeDomain viaje = new ViajeDomain();
                        List<String> datos = new ArrayList<>();

                        for (int i = 1; i < tuple.length; i++) {
                            datos.add((String) tuple[i]);
                        }

                        viaje.setId((Integer) tuple[0]);
                        viaje.setDatos(datos);
                        return viaje;
                    }
                })
                .list();

        session.flush();
        session.clear();
        return viajes;
    }

    /**
     * Inserta une nueva columna en la configuración de carga masiva de la dependencia indicada
     *
     * @param column
     * @throws java.lang.Exception
     */
    public void saveColumn(CargaColumnDomain column) throws Exception {
        int i = 0;
        try {
            Session session = em.unwrap(Session.class);
            
            List<CargaColumnDomain> encabezados = session.createSQLQuery("CALL get_columnas_carga(:idDep, :secuencia)")
                    .setParameter("idDep", column.getIdDependencia())
                    .setParameter("secuencia", column.getSecuencia())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CargaColumnDomain domain = new CargaColumnDomain();
                            domain.setIdDependencia((Integer) tuple[0]);
                            domain.setTabla((String) tuple[1]);
                            domain.setCampo((String) tuple[2]);
                            domain.setDespliegue((String) tuple[3]);
                            domain.setEditable((Boolean) tuple[4]);
                            domain.setSecuencia((Integer) tuple[5]);
                            domain.setListaHabilitada((Boolean) tuple[6]);
                            return domain;
                        }
                    })
                    .list();
            
            for(CargaColumnDomain item : encabezados){
                session.createSQLQuery("CALL update_secuencias(:inSecuencia, :inTabla, :inCampo, :inDependencia)")
                    .setParameter("inTabla", item.getTabla())
                    .setParameter("inCampo", item.getCampo())
                    .setParameter("inSecuencia", column.getSecuencia()+ i + 1)
                    .setParameter("inDependencia", column.getIdDependencia())
                    .executeUpdate();
                i++;
            }
            
            session.createSQLQuery("CALL insert_interfaz_config(:tabla, :campo, "
                    + ":listaHabilitada, :etiqueta, :secuencia, :idDep, :editable)")
                    .setParameter("tabla", column.getTabla())
                    .setParameter("campo", column.getCampo())
                    .setParameter("listaHabilitada", column.getListaHabilitada())
                    .setParameter("etiqueta", column.getDespliegue())
                    .setParameter("secuencia", column.getSecuencia())
                    .setParameter("idDep", column.getIdDependencia())
                    .setParameter("editable", column.getEditable())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL GUARDAR LA COLUMNA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Actualiza los datos de una columna de configuración de carga masiva
     *
     * @param column
     * @throws Exception
     */
    public void updateColumn(CargaColumnDomain column) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL update_interfaz_config(:tabla, :campo, :idDep, "
                    + ":listaHabilitada, :etiqueta, :secuencia, :editable)")
                    .setParameter("tabla", column.getTabla())
                    .setParameter("campo", column.getCampo())
                    .setParameter("idDep", column.getIdDependencia())
                    .setParameter("listaHabilitada", column.getListaHabilitada() ? 1: 0)
                    .setParameter("etiqueta", column.getDespliegue())
                    .setParameter("secuencia", column.getSecuencia())
                    .setParameter("editable", column.getEditable())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL ACTUALIZAR LA COLUMNA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Elimina una columna de la configuración de carga masiva para la dependencia indicada
     * @param column
     * @throws Exception 
     */
    public void deleteColumn(CargaColumnDomain column) throws Exception {
        int i = 0;
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_interfaz_config(:tabla, :campo, :idDep)")
                    .setParameter("tabla", column.getTabla())
                    .setParameter("campo", column.getCampo())
                    .setParameter("idDep", column.getIdDependencia())
                    .executeUpdate();
            
            List<CargaColumnDomain> encabezados = session.createSQLQuery("CALL get_columnas_carga(:idDep, :secuencia)")
                    .setParameter("idDep", column.getIdDependencia())
                    .setParameter("secuencia", column.getSecuencia())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CargaColumnDomain domain = new CargaColumnDomain();
                            domain.setIdDependencia((Integer) tuple[0]);
                            domain.setTabla((String) tuple[1]);
                            domain.setCampo((String) tuple[2]);
                            domain.setDespliegue((String) tuple[3]);
                            domain.setEditable((Boolean) tuple[4]);
                            domain.setSecuencia((Integer) tuple[5]);
                            domain.setListaHabilitada((Boolean) tuple[6]);
                            return domain;
                        }
                    })
                    .list();
            
            for(CargaColumnDomain item : encabezados){
                session.createSQLQuery("CALL update_secuencias(:inSecuencia, :inTabla, :inCampo, :inDependencia)")
                    .setParameter("inTabla", item.getTabla())
                    .setParameter("inCampo", item.getCampo())
                    .setParameter("inSecuencia", column.getSecuencia() + i)
                    .setParameter("inDependencia", column.getIdDependencia())
                    .executeUpdate();
                i++;
            }
            
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL ELIMINAR LA COLUMNA. " + e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

}
