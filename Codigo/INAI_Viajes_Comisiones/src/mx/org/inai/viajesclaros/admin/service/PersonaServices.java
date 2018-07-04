package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.TipoPersonaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

/**
 * Session Bean implementation class PersonaServices
 */
public class PersonaServices {

	public PersonaServices() {
        // TODO Auto-generated constructor stub
    }
    
    public ArrayList<TipoPersonaVO> obtenerTiposPersonas() {
		ArrayList<TipoPersonaVO> data = new ArrayList<TipoPersonaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_tipo_personas()");
		query.addEntity(TipoPersonaVO.class);
						
		List<TipoPersonaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			TipoPersonaVO vo = (TipoPersonaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
    
    public TipoPersonaVO obtenerTipoPersona(TipoPersonaVO tipo) {
		TipoPersonaVO vo = new TipoPersonaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_tipo_persona(:id)");
		query.addEntity(TipoPersonaVO.class);
		query.setInteger("id", tipo.getId());
						
		List<TipoPersonaVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (TipoPersonaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
    
    public Integer insertaPersona(PersonaVO persona) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_persona(:nom,:pat,:mat,:tit,"+
																					  ":email,:id_cat,:id_tip,"+
																					  ":id_pos,:car,:fec)");
		
		query.setString("nom", persona.getNombres());
		query.setString("pat", persona.getApellidoPaterno());
		query.setString("mat", persona.getApellidoMaterno());
		query.setString("tit", persona.getTitulo());
		query.setString("email", persona.getEmail());
		query.setInteger("id_cat", persona.getCategoria().getId());
		query.setInteger("id_tip", persona.getTipoPersona().getId());
		query.setInteger("id_pos", persona.getPosicion().getId());
		query.setString("car", persona.getCargo());
		query.setDate("fec", persona.getFechaIngreso());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaPersona(PersonaVO persona) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_persona(:id,:nom,:pat,:mat,:tit,"+
				  																	   ":email,:id_cat,:id_tip,"+
    																				   ":id_pos,:car,:fec)");
		query.setInteger("id", persona.getId());
    	query.setString("nom", persona.getNombres());
		query.setString("pat", persona.getApellidoPaterno());
		query.setString("mat", persona.getApellidoMaterno());
		query.setString("tit", persona.getTitulo());
		query.setString("email", persona.getEmail());
		query.setInteger("id_cat", persona.getCategoria().getId());
		query.setInteger("id_tip", persona.getTipoPersona().getId());
		query.setInteger("id_pos", persona.getPosicion().getId());
		query.setString("car", persona.getCargo());
		query.setDate("fec", persona.getFechaIngreso());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaPersona(PersonaVO persona) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_persona(:id)");
		query.setInteger("id", persona.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
	
	public PersonaVO obtenPersona(PersonaVO persona) {
		PersonaVO vo = new PersonaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_persona(:id)");
		query.addEntity(PersonaVO.class);
		query.setInteger("id", persona.getId());
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (PersonaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
    
    public ArrayList<PersonaVO> obtenerPersonas() {
		ArrayList<PersonaVO> data = new ArrayList<PersonaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_personas()");
		query.addEntity(PersonaVO.class);
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			PersonaVO vo = (PersonaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}

}
