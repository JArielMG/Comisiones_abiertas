package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class DependenciaServices {

	public ArrayList<DependenciaVO> obtenerDependencias() {
		ArrayList<DependenciaVO> data = new ArrayList<DependenciaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_dependencias()");
		query.addEntity(DependenciaVO.class);
						
		List<DependenciaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			DependenciaVO vo = (DependenciaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public DependenciaVO obtenerDependencia(DependenciaVO dependencia) {
		DependenciaVO vo = new DependenciaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_dependencia_by_Id(:id)");
		query.addEntity(DependenciaVO.class);
		query.setInteger("id", dependencia.getId());
						
		List<DependenciaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (DependenciaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaDependencia(DependenciaVO dependencia) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_dependencia(:sig,:nom,:def)");
		query.setString("sig", dependencia.getSiglas());
		query.setString("nom", dependencia.getNombre());
		query.setBoolean("def", dependencia.getPredeterminada());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaDependencia(DependenciaVO dependencia) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_dependencia(:id,:sig,:nom,:def)");
    	query.setInteger("id", dependencia.getId());
    	query.setString("sig", dependencia.getSiglas());
		query.setString("nom", dependencia.getNombre());
		query.setBoolean("def", dependencia.getPredeterminada());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaDependencia(DependenciaVO dependencia) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_dependencia(:id)");
		query.setInteger("id", dependencia.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
