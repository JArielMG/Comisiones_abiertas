package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;

import mx.org.inai.viajesclaros.admin.model.CategoriaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 * Session Bean implementation class CategoryServices
 */
public class CategoryServices {

	public CategoryServices() {
        // TODO Auto-generated constructor stub
    }
    
    public Integer insertaCategoria(CategoriaVO categoria) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_categoria(:nom,:hosp,:viat)");
		query.setString("nom", categoria.getNombre());
		query.setDouble("hosp", categoria.getTopeHospedaje());
		query.setDouble("viat", categoria.getTopeViaticos());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaCategoria(CategoriaVO categoria) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_categoria(:id,:nom,:hosp,:viat)");
		query.setInteger("id", categoria.getId());
		query.setString("nom", categoria.getNombre());
		query.setDouble("hosp", categoria.getTopeHospedaje());
		query.setDouble("viat", categoria.getTopeViaticos());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
	public Integer eliminaCategoria(CategoriaVO categoria) {
		Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_categoria(:id)");
		query.setInteger("id", categoria.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
	
	public CategoriaVO obtenCategoria(CategoriaVO categoria) {
		CategoriaVO vo = new CategoriaVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_categoria(:id)");
		query.addEntity(CategoriaVO.class);
		query.setInteger("id", categoria.getId());
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (CategoriaVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public ArrayList<CategoriaVO> obtenerCategorias() {
		ArrayList<CategoriaVO> data = new ArrayList<CategoriaVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_categorias()");
		query.addEntity(CategoriaVO.class);
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			CategoriaVO vo = (CategoriaVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}

}
