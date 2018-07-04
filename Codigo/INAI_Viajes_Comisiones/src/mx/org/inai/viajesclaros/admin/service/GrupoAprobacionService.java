package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.model.GrupoAprobacionVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class GrupoAprobacionService {
	
	public ArrayList<GrupoAprobacionVO> obtenerGruposAprobacion() {
		ArrayList<GrupoAprobacionVO> data = new ArrayList<GrupoAprobacionVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_grupos_aprobacion()");
		query.addEntity(GrupoAprobacionVO.class);
						
		List<GrupoAprobacionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			GrupoAprobacionVO vo = (GrupoAprobacionVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public GrupoAprobacionVO obtenerGrupoAprobacion(GrupoAprobacionVO grupo) {
		GrupoAprobacionVO vo = new GrupoAprobacionVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_grupo_aprobacion(:id)");
		query.addEntity(GrupoAprobacionVO.class);
		query.setInteger("id", grupo.getId());
						
		List<GrupoAprobacionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (GrupoAprobacionVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public GrupoAprobacionVO obtenerGrupoAprobacion(String nombre, ProcesoVO flujo) {
		GrupoAprobacionVO vo = new GrupoAprobacionVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_grupo_aprobacion_by_name(:nom,:fluj)");
		query.addEntity(GrupoAprobacionVO.class);
		query.setString("nom", nombre);
		query.setInteger("fluj", flujo.getId());
						
		List<GrupoAprobacionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (GrupoAprobacionVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public GrupoAprobacionVO obtenerGrupoAprobacion(ProcesoVO flujo, DependenciaVO dependencia, AreaVO area) {
		GrupoAprobacionVO vo = null;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_grupo_aprobacion_by_area(:flujo,:depen,:area)");
		query.addEntity(GrupoAprobacionVO.class);
		query.setInteger("flujo", flujo.getId());
		query.setInteger("depen", dependencia.getId());
		query.setInteger("area", area.getId());
						
		List<GrupoAprobacionVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (GrupoAprobacionVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaGrupoAprobacion(GrupoAprobacionVO grupo) {
    	Integer res = 0;
    	
    	System.out.println("********" + grupo.getNombre() + " - " + grupo.getProceso().getId() + " - " + grupo.getDependencia().getId() +
    					   " - " + grupo.getArea().getId() + " - " + grupo.getJerarquia().getId());
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_grupo_aprobacion(:nom,:proc,:dep,:area,:jerar)");
		query.setString("nom", grupo.getNombre());
		query.setInteger("proc", grupo.getProceso().getId());
		query.setInteger("dep", grupo.getDependencia().getId());
		query.setInteger("area", grupo.getArea().getId());
		query.setInteger("jerar", grupo.getJerarquia().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaGrupoAprobacion(GrupoAprobacionVO grupo) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_grupo_aprobacion(:id,:nom,:proc,:dep,:area,:jerar)");
    	query.setInteger("id", grupo.getId());
    	query.setString("nom", grupo.getNombre());
    	query.setInteger("proc", grupo.getProceso().getId());
		query.setInteger("dep", grupo.getDependencia().getId());
		query.setInteger("area", grupo.getArea().getId());
		query.setInteger("jerar", grupo.getJerarquia().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaGrupoAprobacion(GrupoAprobacionVO grupo) {
		Integer res = 0;
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_grupo_aprobacion(:id)");
		query.setInteger("id", grupo.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
}
