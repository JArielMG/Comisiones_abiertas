package mx.org.inai.viajesclaros.admin.service;

import java.math.BigInteger;

import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class ComisionServices {

	public int esComisionNacional(int comision) {
		int result = 0;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.es_comision_nacional(:id_com)");			
		query.setInteger("id_com", comision);
						
		result = ((BigInteger)query.uniqueResult()).intValue();
		
		session.close();
		
		return result;
	}
	
	
	
	public Integer actualizaComision(int comision, String estatus){ 
		Integer res = 0;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_edo_comision(:id_com,:edo)");
		query.setInteger("id_com", comision);
		query.setString("edo", estatus);
    	
    	res = (Integer)query.uniqueResult();
		
		session.close();
		
		return res;
	}
	
	public Integer publicaViaje(int comision, int dependencia) {
		Integer res = 0;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.publica_viaje(:id_com,:id_dep)");
		query.setInteger("id_com", comision);
		query.setInteger("id_dep", dependencia);
    	
    	res = (Integer)query.uniqueResult();
		
		session.close();
		
		return res;
	}
}
