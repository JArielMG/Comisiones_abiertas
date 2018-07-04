package mx.org.inai.viajesclaros.admin.service;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

import mx.org.inai.viajesclaros.admin.model.GrupoAprobacionVO;
import mx.org.inai.viajesclaros.admin.model.LoginVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

/**
 * Session Bean implementation class SecurityServices
 */
public class SecurityServices {

	public SecurityServices() {
		
    }
    
    public Integer validaUsuario(LoginVO loginVO) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.obten_usuario_by_str(:us)");
		query.addEntity(UsuarioVO.class);
		query.setString("us", loginVO.getUser());
		
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			UsuarioVO vo = (UsuarioVO)result.get(i);
			//data.add(vo);
		}
		
		session.close();
		
		res = (Integer)query.uniqueResult();
    	
    	return res;
    }

}
