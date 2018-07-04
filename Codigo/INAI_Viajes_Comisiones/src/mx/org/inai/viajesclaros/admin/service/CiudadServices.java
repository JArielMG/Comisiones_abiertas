package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.CiudadVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class CiudadServices {

	public ArrayList<CiudadVO> obtenerCiudades() {
		ArrayList<CiudadVO> data = new ArrayList<CiudadVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_ciudades()");
		query.addEntity(CiudadVO.class);
						
		List<CiudadVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			CiudadVO vo = (CiudadVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public CiudadVO obtenerCiudad(CiudadVO ciudad) {
		CiudadVO vo = new CiudadVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_ciudad(:id)");
		query.addEntity(CiudadVO.class);
		query.setInteger("id", ciudad.getId());
						
		List<CiudadVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (CiudadVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaCiudad(CiudadVO ciudad) {
    	Integer res = 0;
    	String latitud;
    	String longitud;
    	
    	if (ciudad.getLatitud().length() >= 20) {
    		latitud = ciudad.getLatitud().substring(0, 20);
    	} else {
    		latitud = ciudad.getLatitud();
    	}
    	
    	if (ciudad.getLongitud().length() >= 20) {
    		longitud = ciudad.getLongitud().substring(0, 20);
    	} else {
    		longitud = ciudad.getLongitud();
    	}
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_ciudad(:nom,:pais,:edo,:lat,:lon)");
		query.setString("nom", ciudad.getNombre());
		query.setInteger("pais", ciudad.getPais().getId());
		query.setInteger("edo", ciudad.getEstado().getId());
		query.setString("lat", latitud);
		query.setString("lon", longitud);
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaCiudad(CiudadVO ciudad) {
    	Integer res = 0;
    	String latitud;
    	String longitud;
    	
    	if (ciudad.getLatitud().length() >= 20) {
    		latitud = ciudad.getLatitud().substring(0, 20);
    	} else {
    		latitud = ciudad.getLatitud();
    	}
    	
    	if (ciudad.getLongitud().length() >= 20) {
    		longitud = ciudad.getLongitud().substring(0, 20);
    	} else {
    		longitud = ciudad.getLongitud();
    	}
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_ciudad(:id,:nom,:pais,:edo,:lat,:lon)");
    	query.setInteger("id", ciudad.getId());
    	query.setString("nom", ciudad.getNombre());
		query.setInteger("pais", ciudad.getPais().getId());
		query.setInteger("edo", ciudad.getEstado().getId());
		query.setString("lat", latitud);
		query.setString("lon", longitud);
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaCiudad(CiudadVO ciudad) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_ciudad(:id)");
		query.setInteger("id", ciudad.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
