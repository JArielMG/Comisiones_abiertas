package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class AreaServices {

	public ArrayList<AreaVO> obtenerAreas() {
		ArrayList<AreaVO> data = new ArrayList<AreaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_areas()");
		query.addEntity(AreaVO.class);
						
		List<AreaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			AreaVO vo = (AreaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public AreaVO obtenerArea(AreaVO area) {
		AreaVO vo = new AreaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_area(:id)");
		query.addEntity(AreaVO.class);
		query.setInteger("id", area.getId());
						
		List<AreaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (AreaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaArea(AreaVO area) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_area(:nom,:dep)");
		query.setString("nom", area.getNombre());
		query.setInteger("dep", area.getDependencia().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaArea(AreaVO area) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_area(:id,:nom,:dep)");
    	query.setInteger("id", area.getId());
    	query.setString("nom", area.getNombre());
		query.setInteger("dep", area.getDependencia().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaArea(AreaVO area) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_area(:id)");
		query.setInteger("id", area.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
