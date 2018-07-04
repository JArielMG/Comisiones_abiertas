package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.JerarMiembroVO;
import mx.org.inai.viajesclaros.admin.model.JerarquiaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class MiembroServices {

	public ArrayList<JerarMiembroVO> obtenerMiembros(JerarquiaVO jerarquia) {
		ArrayList<JerarMiembroVO> data = new ArrayList<JerarMiembroVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_miembros(:jerar)");
		query.addEntity(JerarMiembroVO.class);
		query.setInteger("jerar", jerarquia.getId());
						
		List<JerarMiembroVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			JerarMiembroVO vo = (JerarMiembroVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public JerarMiembroVO obtenerMiembro(JerarMiembroVO miembro) {
		JerarMiembroVO vo = new JerarMiembroVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_miembro(:id)");
		query.addEntity(JerarMiembroVO.class);
		query.setInteger("id", miembro.getId());
						
		List<JerarMiembroVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (JerarMiembroVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaMiembro(JerarMiembroVO miembro) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_miembro(:jerar,:usu)");
		query.setInteger("jerar", miembro.getJerarquia().getId());
		query.setInteger("usu", miembro.getUsuario().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaMiembro(JerarMiembroVO miembro) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_miembro(:id,:jerar,:usu)");
    	query.setInteger("id", miembro.getId());
    	query.setInteger("jerar", miembro.getJerarquia().getId());
		query.setInteger("usu", miembro.getUsuario().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaMiembro(JerarMiembroVO miembro) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_miembro(:id)");
		query.setInteger("id", miembro.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
