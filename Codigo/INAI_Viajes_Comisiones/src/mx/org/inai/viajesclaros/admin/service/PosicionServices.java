package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.PosicionVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class PosicionServices {

	public ArrayList<PosicionVO> obtenerPosiciones() {
		ArrayList<PosicionVO> data = new ArrayList<PosicionVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_posiciones()");
		query.addEntity(PosicionVO.class);
						
		List<PosicionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			PosicionVO vo = (PosicionVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public PosicionVO obtenerPosicion(PosicionVO posicion) {
		PosicionVO vo = new PosicionVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_posicion(:id)");
		query.addEntity(PosicionVO.class);
		query.setInteger("id", posicion.getId());
						
		List<PosicionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (PosicionVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaPosicion(PosicionVO posicion) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_posicion(:nom)");
		query.setString("nom", posicion.getNombre());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaPosicion(PosicionVO posicion) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_posicion(:id,:nom)");
    	query.setInteger("id", posicion.getId());
    	query.setString("nom", posicion.getNombre());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaPosicion(PosicionVO posicion) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_posicion(:id)");
		query.setInteger("id", posicion.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
