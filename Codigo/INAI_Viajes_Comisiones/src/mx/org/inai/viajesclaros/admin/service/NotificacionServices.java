package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.ComisionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.FlujosInstanciasVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesNotificacionVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class NotificacionServices {
	
	public NotificacionDetalleVO obtenerDetalleNotificacion(FlujosInstanciasVO instancia, Long taskId, Integer tipoPersona) {
		NotificacionDetalleVO vo = new NotificacionDetalleVO();
		ArrayList<SeccionesNotificacionVO> secciones = new ArrayList<SeccionesNotificacionVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_seccs_notif_flujo(:fluj)");
		query.addEntity(SeccionesNotificacionVO.class);
		query.setInteger("fluj", instancia.getFlujo().getId());
						
		List<SeccionesNotificacionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			SeccionesNotificacionVO seccion = (SeccionesNotificacionVO)result.get(i);
			secciones.add(seccion);
		}
		
		for (SeccionesNotificacionVO secc : secciones) {
			query = session.createSQLQuery("CALL viajes_claros.obten_info_seccs_notif(:ins,:sec,:tipo)");
			query.addEntity(ComisionDetalleVO.class);
			query.setLong("ins", instancia.getInstancia());
			query.setInteger("sec", secc.getIdSeccion());
			query.setInteger("tipo", tipoPersona);
			
			List<ComisionDetalleVO> detalles = query.list();
			
			secc.setDetalle(detalles);
		}
		
		vo.setInstance(instancia);
		vo.setTaskId(taskId);
		vo.setSecciones(secciones);
		
		session.close();
    	
    	return vo;
	}
}
