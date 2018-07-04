package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.JerarquiaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class JerarquiaServices {

	public ArrayList<JerarquiaVO> obtenerJerarquias() {
		ArrayList<JerarquiaVO> data = new ArrayList<JerarquiaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_jerarquias()");
		query.addEntity(JerarquiaVO.class);
						
		List<JerarquiaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			JerarquiaVO vo = (JerarquiaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public JerarquiaVO obtenerJerarquia(JerarquiaVO jerarquia) {
		JerarquiaVO vo = new JerarquiaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_jerarquia(:id)");
		query.addEntity(JerarquiaVO.class);
		query.setInteger("id", jerarquia.getId());
						
		List<JerarquiaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (JerarquiaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaJerarquia(JerarquiaVO jerarquia) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_jerarquia(:nom)");
		query.setString("nom", jerarquia.getNombre());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaJerarquia(JerarquiaVO jerarquia) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_jerarquia(:id,:nom)");
    	query.setInteger("id", jerarquia.getId());
    	query.setString("nom", jerarquia.getNombre());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaJerarquia(JerarquiaVO jerarquia) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_jerarquia(:id)");
		query.setInteger("id", jerarquia.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
