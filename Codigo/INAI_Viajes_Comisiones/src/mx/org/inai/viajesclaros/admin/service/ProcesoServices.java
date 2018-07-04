package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class ProcesoServices {

	public ArrayList<ProcesoVO> obtenerProcesos() {
		ArrayList<ProcesoVO> data = new ArrayList<ProcesoVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_procesos()");
		query.addEntity(ProcesoVO.class);
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			ProcesoVO vo = (ProcesoVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
    
    public ProcesoVO obtenerProceso(ProcesoVO proceso) {
    	ProcesoVO vo = new ProcesoVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_proceso(:id)");
		query.setInteger("id", proceso.getId());
		query.addEntity(ProcesoVO.class);
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (ProcesoVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
}
