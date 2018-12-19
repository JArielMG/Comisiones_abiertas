package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import mx.org.inai.viajesclaros.admin.model.CatalogoElement;

import mx.org.inai.viajesclaros.admin.model.ComisionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.FlujosInstanciasVO;
import mx.org.inai.viajesclaros.admin.model.ListaValoresVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesNotificacionVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

public class NotificacionServices {

    public NotificacionDetalleVO obtenerDetalleNotificacion(FlujosInstanciasVO instancia, Long taskId, Integer tipoPersona) {
        NotificacionDetalleVO vo = new NotificacionDetalleVO();
        ArrayList<SeccionesNotificacionVO> secciones = new ArrayList<SeccionesNotificacionVO>();

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_seccs_notif_flujo(:fluj)");
        query.addEntity(SeccionesNotificacionVO.class);
        query.setInteger("fluj", instancia.getFlujo().getId());

        List<SeccionesNotificacionVO> result = query.list();
        for (int i = 0; i < result.size(); i++) {
            SeccionesNotificacionVO seccion = (SeccionesNotificacionVO) result.get(i);
            secciones.add(seccion);
        }

        for (SeccionesNotificacionVO secc : secciones) {
            query = session.createSQLQuery("CALL viajes_claros.obten_info_seccs_notif(:ins,:sec,:tipo)");
            query.addEntity(ComisionDetalleVO.class);
            query.setLong("ins", instancia.getInstancia());
            query.setInteger("sec", secc.getIdSeccion());
            query.setInteger("tipo", tipoPersona);

            List<ComisionDetalleVO> detalles = query.list();

//            if (secc.getIdSeccion() == 1 || secc.getIdSeccion() == 7) {
//
//                query = session.createSQLQuery("CALL viajes_claros.obten_area_adscripcion(:ins)");
//                query.addEntity(ComisionDetalleVO.class);
//                query.setLong("ins", instancia.getInstancia());
//                detalles.add((ComisionDetalleVO) query.list().get(0));
//
//                query = session.createSQLQuery("CALL viajes_claros.obten_cve_adscripcion(:ins)");
//                query.addEntity(ComisionDetalleVO.class);
//                query.setLong("ins", instancia.getInstancia());
//                detalles.add((ComisionDetalleVO) query.list().get(0));
//
//            }

            secc.setDetalle(detalles);
        }

        vo.setInstance(instancia);
        vo.setTaskId(taskId);
        vo.setSecciones(secciones);

        session.close();

        return vo;
    }
    
    @SuppressWarnings("unchecked")
    public List<CatalogoElement> getvaloresDinamicos(Integer idLista) {
        Session session = HibernateUtil.getSessionFactory().openSession();
    
        List<CatalogoElement> valoresDinamicos = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                            .setParameter("idLista", idLista).setResultTransformer(new BasicTransformerAdapter() {
                                private static final long serialVersionUID = 1L;
                                @Override
                                public Object transformTuple(Object[] tuple, String[] aliases) {
                                    Integer id = (Integer) tuple[0];
                                    String codigo = (String) tuple[1];
                                    String descripcion = (String) tuple[2];
                                    return new CatalogoElement(id, codigo, descripcion);
                                }
                            }).list();
        return valoresDinamicos;
    }
    
    @SuppressWarnings("unchecked")
    public ListaValoresVO getListaValores(String nombreLista) {
        Session session = HibernateUtil.getSessionFactory().openSession();
    
        List<ListaValoresVO> valoresDinamicos = session.createSQLQuery("CALL get_listas_valores_filtradas(:nombreLista)")
                            .setParameter("nombreLista", nombreLista).setResultTransformer(new BasicTransformerAdapter() {
                                private static final long serialVersionUID = 1L;
                                @Override
                                public Object transformTuple(Object[] tuple, String[] aliases) {
                                    Integer id = (Integer) tuple[0];
                                    String nombre = (String) tuple[1];
                                    boolean habilitada = (boolean) tuple[2];
                                    return new ListaValoresVO(id, nombre, habilitada);
                                }
                            }).list();
        return valoresDinamicos.get(0);
    }
    
    public void insertarActualizarComisionDetalle(Integer idComision, String tabla, String campo, String valorTexto, Double valorNumerico, Date valorFecha) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_existe_comision_detalle(:idComision,:tabla,:campo)");
        query.setInteger("idComision", idComision);
        query.setString("tabla", tabla);
        query.setString("campo", campo);

        Object res = query.uniqueResult();

        //Actualiza si el resultado es distinto a nulo
        if (res != null) {
            query = session.createSQLQuery("CALL viajes_claros.update_comision_detalle(:idComision,:tabla,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setString("tabla", tabla);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();

        } else {
            query = session.createSQLQuery("CALL viajes_claros.insert_comisiones_detalle(:idComision,:tabla,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setString("tabla", tabla);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();
        }

        session.close();
    }

}
