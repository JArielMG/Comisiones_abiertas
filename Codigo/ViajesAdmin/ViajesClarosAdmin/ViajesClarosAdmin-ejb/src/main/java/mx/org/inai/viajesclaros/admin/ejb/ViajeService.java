
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.domain.DespliegueBusquedaDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 * @author Sandro Alejandro
 */
@Stateless
public class ViajeService {
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;
    
    final static Logger log = Logger.getLogger(ViajeService.class);
    
    /**
     * Obtiene los viajes de la dependencia indicada
     * @param idDependencia
     * @return viajes
     */
    public List<ViajeDomain> findAllByDependencia(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<ViajeDomain> viajes = session.createSQLQuery("CALL get_viajes_por_dependencia(:idDep, :despliegueCompleto)")
                .setParameter("idDep", idDependencia)
                .setParameter("despliegueCompleto", Byte.valueOf("1"))
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        ViajeDomain viaje = new ViajeDomain();
                        List<String> datos = new ArrayList<>();
                        
                        for (int i=1; i<tuple.length; i++) {
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
     * Llama al SP para obtener los campos parametrizados para mostrar en los resultados de búsqueda
     *
     * @param idDependencia
     * @return Encabezados (lista de objetos ElementoCatalogoModel)
     */
    public List<DespliegueBusquedaDomain> getEncabezadoViajes(Integer idDependencia) {
        Session session = em.unwrap(Session.class);

        List<DespliegueBusquedaDomain> encabezados = session.createSQLQuery("CALL get_campos_despliegue_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        DespliegueBusquedaDomain domain = new DespliegueBusquedaDomain();
                        domain.setIdDependencia((Integer) tuple[0]);
                        domain.setTabla((String) tuple[1]);
                        domain.setCampo((String) tuple[2]);
                        domain.setDespliegue((String) tuple[3]);
                        domain.setOrden((Byte) tuple[4]);
                        domain.setMostrar((Boolean) tuple[5]);
                        return domain;
                    }
                })
                .list();

        session.flush();
        session.clear();
        return encabezados;
    }
    
}
