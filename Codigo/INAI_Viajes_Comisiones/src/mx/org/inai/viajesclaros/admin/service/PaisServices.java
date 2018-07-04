package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.PaisVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class PaisServices {

	public ArrayList<PaisVO> obtenerPaises() {
		ArrayList<PaisVO> data = new ArrayList<PaisVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_paises()");
		query.addEntity(PaisVO.class);
						
		List<PaisVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			PaisVO vo = (PaisVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public PaisVO obtenerPais(PaisVO pais) {
		PaisVO vo = new PaisVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_pais(:id)");
		query.addEntity(PaisVO.class);
		query.setInteger("id", pais.getId());
						
		List<PaisVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (PaisVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaPais(PaisVO pais) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_pais(:cod,:nom,:pred)");
		query.setString("cod", pais.getClave());
		query.setString("nom", pais.getNombre());
		query.setBoolean("pred", pais.getPredeterminado());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaPais(PaisVO pais) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_pais(:id,:cod,:nom,:pred)");
    	query.setInteger("id", pais.getId());
    	query.setString("cod", pais.getClave());
		query.setString("nom", pais.getNombre());
		query.setBoolean("pred", pais.getPredeterminado());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaPais(PaisVO pais) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_pais(:id)");
		query.setInteger("id", pais.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
