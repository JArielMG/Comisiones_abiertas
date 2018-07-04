package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.EstadoVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class EstadoServices {

	public ArrayList<EstadoVO> obtenerEstados() {
		ArrayList<EstadoVO> data = new ArrayList<EstadoVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_estados()");
		query.addEntity(EstadoVO.class);
						
		List<EstadoVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			EstadoVO vo = (EstadoVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public EstadoVO obtenerEstado(EstadoVO estado) {
		EstadoVO vo = new EstadoVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_estado(:id)");
		query.addEntity(EstadoVO.class);
		query.setInteger("id", estado.getId());
						
		List<EstadoVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (EstadoVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaEstado(EstadoVO estado) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_estado(:nom,:pais)");
		query.setString("nom", estado.getNombre());
		query.setInteger("pais", estado.getPais().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaEstado(EstadoVO estado) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_estado(:id,:nom,:pais)");
    	query.setInteger("id", estado.getId());
    	query.setString("nom", estado.getNombre());
		query.setInteger("pais", estado.getPais().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaEstado(EstadoVO estado) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_estado(:id)");
		query.setInteger("id", estado.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
