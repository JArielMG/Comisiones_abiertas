
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.CampoFlujoDomain;
import mx.org.inai.viajesclaros.domain.FlujoTrabajoDomain;
import mx.org.inai.viajesclaros.domain.SeccionFormularioDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class FlujoService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(FlujoService.class);

    public List<FlujoTrabajoDomain> getFlujosTrabajo() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<FlujoTrabajoDomain> list = session.createSQLQuery("CALL get_flujos_trabajo()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FlujoTrabajoDomain model = new FlujoTrabajoDomain();
                            model.setId((Integer) tuple[0]);
                            model.setNombre((String) tuple[1]);
                            model.setDescripcion((String) tuple[2]);
                            model.setVersion((String) tuple[3]);
                            return model;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Guarda un campo de parametrización de las pantallas de flujos
     * @param campoDomain
     * @throws Exception 
     */
    public void saveFlujoCampoConfig(CampoFlujoDomain campoDomain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_flujos_campos_config(:idFlujo, :idTipoPersona, "
                    + ":tabla, :campo, :etiqueta, :listaHabilitada, :obligatorio, :idSeccion, :orden, :subtipo, :soloLectura, :clase)")
                    .setParameter("idFlujo", campoDomain.getIdFlujo())
                    .setParameter("idTipoPersona", campoDomain.getIdTipoPersona())
                    .setParameter("tabla", campoDomain.getTabla())
                    .setParameter("campo", campoDomain.getCampo())
                    .setParameter("etiqueta", campoDomain.getEtiqueta())
                    .setParameter("listaHabilitada", campoDomain.getListaHabilitada())
                    .setParameter("obligatorio", campoDomain.getObligatorio())
                    .setParameter("idSeccion", campoDomain.getIdSeccion())
                    .setParameter("orden", campoDomain.getOrden())                    
                    .setParameter("subtipo", campoDomain.getSubtipo())
                    .setParameter("soloLectura", campoDomain.getSoloLectura())
                    .setParameter("clase", campoDomain.getClase())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina un campo de la tabla flujos_campos_config
     * @param campoFlujoDomain
     * @throws Exception 
     */
    public void deleteFlujoCampoConfig(CampoFlujoDomain campoFlujoDomain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_flujos_campos_config(:idFlujo, :idTipoPersona, :tabla, :campo)")
                    .setParameter("idFlujo", campoFlujoDomain.getIdFlujo())
                    .setParameter("idTipoPersona", campoFlujoDomain.getIdTipoPersona())
                    .setParameter("tabla", campoFlujoDomain.getTabla())
                    .setParameter("campo", campoFlujoDomain.getCampo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    public void updateFlujoCampoConfig(CampoFlujoDomain campo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL update_flujos_campos_config(:idFlujo, :idTipoPersona, "
                    + ":tabla, :campo, :etiqueta, :listaHab, :obligatorio, :idSeccion, :orden, :subtipo, :soloLectura, :clase)")
                    .setParameter("idFlujo", campo.getIdFlujo())
                    .setParameter("idTipoPersona", campo.getIdTipoPersona())
                    .setParameter("tabla", campo.getTabla())
                    .setParameter("campo", campo.getCampo())
                    .setParameter("etiqueta", campo.getEtiqueta())
                    .setParameter("listaHab", campo.getListaHabilitada())
                    .setParameter("obligatorio", campo.getObligatorio())
                    .setParameter("idSeccion", campo.getIdSeccion())
                    .setParameter("orden", campo.getOrden())
                    .setParameter("subtipo", campo.getSubtipo())
                    .setParameter("soloLectura", campo.getSoloLectura())
                    .setParameter("clase", campo.getClase())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Guarda una nueva sección de formulario para el flujo de trabajo indicado
     * @param seccion
     * @throws Exception 
     */
    public void saveSeccion(SeccionFormularioDomain seccion) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_secciones_formulario(:etiqueta, :nombre, :idFlujo, :orden)")
                    .setParameter("etiqueta", seccion.getEtiqueta())
                    .setParameter("nombre", seccion.getNombre())
                    .setParameter("idFlujo", seccion.getIdFlujo())
                    .setParameter("orden", seccion.getOrden())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR LA SECCIÓN DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina una sección de la pantalla de flujos
     * @param idSeccion
     * @throws Exception 
     */
    public void deleteSeccion(Integer idSeccion) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_seccion_formulario(:idSeccion)")
                    .setParameter("idSeccion", idSeccion)
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR LA SECCIÓN", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Actualiza los datos de una sección
     * @param seccion
     * @throws Exception 
     */
    public void updateSeccion(SeccionFormularioDomain seccion) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL update_seccion_formulario(:id, :etiqueta, :nombre, :flujo, :orden)")
                    .setParameter("id", seccion.getId())
                    .setParameter("etiqueta", seccion.getEtiqueta())
                    .setParameter("nombre", seccion.getNombre())
                    .setParameter("flujo", seccion.getIdFlujo())
                    .setParameter("orden", seccion.getOrden())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIAR LA SECCIÓN", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene los campos del flujo de trabajo indicado, ordenados por categorías
     *
     * @param idFlujo
     * @param idTipoPersona
     * @return
     * @throws Exception
     */
    public List<SeccionFormularioDomain> getFlujoCategoriasCampos(Integer idFlujo, Integer idTipoPersona) throws Exception {
        try {
            /* Consultar las categorías y por cada categoría consultar los campos */
            List<SeccionFormularioDomain> secciones = getSecciones(idFlujo);
            for (SeccionFormularioDomain sec : secciones) {
                /* Consultar los campos de esta categoría */
                List<CampoFlujoDomain> campos = getFlujoCamposPorCategoria(idFlujo, idTipoPersona, sec.getId());
                sec.setCampos(campos);
            }
            return secciones;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR CAMPOS DEL FLUJO DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene los campos del flujo y de la categoría indicados
     * @param categoria
     * @return
     * @throws Exception 
     */
    private List<CampoFlujoDomain> getFlujoCamposPorCategoria(Integer idFlujo, Integer idTipoPersona, Integer idSeccion) throws Exception {
        Session session = em.unwrap(Session.class);
        List<CampoFlujoDomain> campos = session.createSQLQuery("CALL get_flujos_campos_config_por_flujo_tipo_persona_seccion("
                + ":idFlujo, :idTipoPersona, :idSeccion)")
                .setParameter("idFlujo", idFlujo)
                .setParameter("idTipoPersona", idTipoPersona)
                .setParameter("idSeccion", idSeccion)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        CampoFlujoDomain campoDomain = new CampoFlujoDomain();
                        campoDomain.setTabla((String) tuple[1]);
                        campoDomain.setCampo((String) tuple[2]);
                        campoDomain.setEtiqueta((String) tuple[3]);
                        campoDomain.setListaHabilitada((Boolean) tuple[4]);
                        campoDomain.setIdSeccion((Integer) tuple[5]);
                        Boolean b = (Byte) tuple[6] != 0;
                        campoDomain.setObligatorio(b);
                        campoDomain.setOrden((Integer) tuple[7]);
                        campoDomain.setIdLista((Integer) tuple[8]);
                        campoDomain.setTipoControl((String) tuple[9]);
                        campoDomain.setTipoDato((String) tuple[10]);
                        campoDomain.setSubtipo((String) tuple[11]);
                        campoDomain.setSoloLectura((Boolean) tuple[12]);
                        campoDomain.setClase((String) tuple[13]);
                        return campoDomain;
                    }
                })
                .list();
       
        session.flush();
        session.clear();
        return campos;
    }

    /**
     * Obtiene la secciones del formulario para el flujo indicado
     *
     * @param idFlujo
     * @return
     * @throws Exception
     */
    public List<SeccionFormularioDomain> getSecciones(Integer idFlujo) throws Exception {
        Session session = em.unwrap(Session.class);
        List<SeccionFormularioDomain> secciones = session.createSQLQuery("CALL get_secciones_formulario_por_id_flujo(:idFlujo)")
                .setParameter("idFlujo", idFlujo)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        SeccionFormularioDomain domain = new SeccionFormularioDomain();
                        domain.setId((Integer) tuple[0]);
                        domain.setEtiqueta((String) tuple[1]);
                        domain.setNombre((String) tuple[2]);
                        domain.setOrden((Integer) tuple[4]);
                        return domain;
                    }
                })
                .list();

        session.flush();
        session.clear();
        return secciones;
    }

}
