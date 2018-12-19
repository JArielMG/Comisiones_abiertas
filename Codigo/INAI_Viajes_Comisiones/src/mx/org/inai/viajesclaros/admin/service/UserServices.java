package mx.org.inai.viajesclaros.admin.service;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.bonitasoft.engine.api.IdentityAPI;
import org.bonitasoft.engine.api.TenantAPIAccessor;
import org.bonitasoft.engine.bpm.process.ProcessDeploymentInfo;
import org.bonitasoft.engine.exception.BonitaHomeNotSetException;
import org.bonitasoft.engine.exception.CreationException;
import org.bonitasoft.engine.exception.DeletionException;
import org.bonitasoft.engine.exception.SearchException;
import org.bonitasoft.engine.exception.ServerAPIException;
import org.bonitasoft.engine.exception.UnknownAPITypeException;
import org.bonitasoft.engine.exception.UpdateException;
import org.bonitasoft.engine.identity.Group;
import org.bonitasoft.engine.identity.Role;
import org.bonitasoft.engine.identity.User;
import org.bonitasoft.engine.identity.UserMembership;
import org.bonitasoft.engine.identity.UserNotFoundException;
import org.bonitasoft.engine.platform.LoginException;
import org.bonitasoft.engine.search.SearchResult;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.model.PerfilVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.workflows.BonitaProcesosAdmin;
import mx.org.inai.viajesclaros.admin.workflows.BonitaUsuariosAdmin;

/**
 * Session Bean implementation class UserServices
 */
public class UserServices {
	
	Properties prop = new Properties();

	public UserServices() {
        // TODO Auto-generated constructor stub
		try {
			prop.load(UserServices.class.getClassLoader().getResourceAsStream("viajes_claros.properties"));
			
		} catch (IOException ex) {
	        ex.printStackTrace();
	    }
    }
    
    public ArrayList<PerfilVO> obtenerPerfiles() {
		ArrayList<PerfilVO> data = new ArrayList<PerfilVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_perfiles()");
		query.addEntity(PerfilVO.class);
						
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			PerfilVO vo = (PerfilVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
    
    public PerfilVO obtenerPerfil(PerfilVO perfil) {
		PerfilVO vo = new PerfilVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_perfil(:id)");
		query.setInteger("id", perfil.getId());
		query.addEntity(PerfilVO.class);
						
                System.out.println("################### En el for");
		List result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (PerfilVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
    
    public ArrayList<UsuarioVO> obtenerUsuarios() {
		ArrayList<UsuarioVO> data = new ArrayList<UsuarioVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_usuarios()");
		query.addEntity(UsuarioVO.class);
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			UsuarioVO vo = (UsuarioVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public UsuarioVO obtenerUsuario(UsuarioVO usuario) {
		UsuarioVO vo = new UsuarioVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_usuario(:id)");
		query.addEntity(UsuarioVO.class);
		query.setInteger("id", usuario.getId());
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public UsuarioVO obtenerUsuario(String usuario) {
		UsuarioVO vo = new UsuarioVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_usuario_by_str(:us)");
		query.addEntity(UsuarioVO.class);
		query.setString("us", usuario);
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public UsuarioVO obtenerUsuario(long usuarioId) {
		UsuarioVO vo = new UsuarioVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_usuario_bonita(:id)");
		query.addEntity(UsuarioVO.class);
		query.setLong("id", usuarioId);
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public UsuarioVO obtenerUsuario(DependenciaVO dependencia, AreaVO area) {
		UsuarioVO vo = null;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_usuario_jefe_area(:depen,:area)");
		query.addEntity(UsuarioVO.class);
		query.setInteger("depen", dependencia.getId());
		query.setInteger("area", area.getId());
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public Integer insertaUsuario(UsuarioVO usuario) {
    	Integer res = 0;
    	UsuarioVO vo = null;
    	
    	generaContrasenaHash(usuario);
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_usuario(:us,:contr,:salt,:desc,:hab,:ints," +
																					 ":perf,:dep,:per,:area,:jefe)");
		query.setString("us", usuario.getUsuario());
		query.setString("contr", usuario.getContra());
		query.setString("salt", usuario.getSalt());
		query.setString("desc", usuario.getDescripcion());
		query.setBoolean("hab", usuario.getHabilitado());
		query.setInteger("ints", 0);
		query.setInteger("perf", usuario.getPerfil().getId());
		query.setInteger("dep", usuario.getDependencia().getId());
		query.setInteger("per", usuario.getPersona().getId());
		query.setInteger("area", usuario.getArea().getId());
		query.setBoolean("jefe", usuario.getJefeArea());
    	
    	res = (Integer)query.uniqueResult();
    	
    	query = session.createSQLQuery("CALL viajes_claros.obten_usuario_by_str(:us)");
		query.addEntity(UsuarioVO.class);
		query.setString("us", usuario.getUsuario());
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
    	
    	if (res == 0) {
    		try {
    			BonitaUsuariosAdmin usAdmin = new BonitaUsuariosAdmin();
	    		final User user = usAdmin.crearUsuario(usAdmin.bonitaSession(null, null), usuario);
                        
	    		if (user != null) {
	    			usAdmin.asignarPerfil(usAdmin.bonitaSession(null, null), prop.getProperty("bonita_default_profile"), user);
	    			
	    			Group group = usAdmin.obtenerGrupo(usAdmin.bonitaSession(null, null), prop.getProperty("bonita_default_group"));
	    			
	    			Role role = usAdmin.obtenerRol(usAdmin.bonitaSession(null, null), prop.getProperty("bonita_default_role"));
	    			
	    			final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(usAdmin.bonitaSession(null, null));
	    			identityAPI.addUserMembership(user.getId(), group.getId(), role.getId());
	    			
	    			// Guardar el id en la base para asignaciones futuras
	    			query = session.createSQLQuery("select viajes_claros.actualiza_id_bonita(:id,:bonita)");
	    			query.setInteger("id", vo.getId());
	    			query.setLong("bonita", user.getId());
	    			
	    			res = (Integer)query.uniqueResult();
	    			
	    		} else {
	    			res = 1;
	    		}
	    		
    		} catch(BonitaHomeNotSetException e) {
    			e.printStackTrace();
    		} catch(ServerAPIException e) {
    			e.printStackTrace();
    		} catch(UnknownAPITypeException e) {
    			e.printStackTrace();
    		} catch(LoginException e) {
    			e.printStackTrace();
    		} catch(CreationException e) {
    			e.printStackTrace();
    		} catch (SearchException e) {
				e.printStackTrace();
			}
    	}
    	
    	session.close();
    	
    	return res;
    }
    
	
    public Integer actualizaUsuario(UsuarioVO usuario) {
    	Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_usuario(:id,:us,:contr,:desc,:hab," +
																					   ":ints,:perf,:dep,:per,:area," +
																					   ":jefe)");
    	query.setInteger("id", usuario.getId());
    	query.setString("us", "");
    	query.setString("contr", "");
		query.setString("desc", usuario.getDescripcion());
		query.setBoolean("hab", usuario.getHabilitado());
		query.setInteger("ints", 0);
		query.setInteger("perf", usuario.getPerfil().getId());
		query.setInteger("dep", usuario.getDependencia().getId());
		query.setInteger("per", usuario.getPersona().getId());
		query.setInteger("area", usuario.getArea().getId());
		query.setBoolean("jefe", usuario.getJefeArea());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
    }
    
    public Integer actualizaContrasena(UsuarioVO usuario) {
    	Integer res = 0;
    	UsuarioVO vo = null;
    	
    	generaContrasenaHash(usuario);
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_contra(:id,:contr,:salt)");
    	query.setInteger("id", usuario.getId());
    	query.setString("contr", usuario.getContra());
		query.setString("salt", usuario.getSalt());
		
    	res = (Integer)query.uniqueResult();
    	
    	query = session.createSQLQuery("CALL viajes_claros.obten_usuario(:id)");
		query.addEntity(UsuarioVO.class);
		query.setInteger("id", usuario.getId());
						
		List<UsuarioVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (UsuarioVO)result.get(i);
		}
    	
    	session.close();
    	
    	try {
	    	BonitaUsuariosAdmin usAdmin = new BonitaUsuariosAdmin();
			final User user = usAdmin.actualizaUsuario(usAdmin.bonitaSession(null, null), vo);
    	} catch(BonitaHomeNotSetException | UserNotFoundException | ServerAPIException | UnknownAPITypeException | UpdateException | LoginException e) {
			e.printStackTrace();
		}
    	
    	return res;
    }
    
	public Integer eliminaUsuario(UsuarioVO usuario) {
		Integer res = 0;
		UsuarioVO usBonita = obtenerUsuario(usuario);
    	
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_usuario(:id)");
		query.setInteger("id", usuario.getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	if (res == 0) {
    		try {
    			BonitaUsuariosAdmin usAdmin = new BonitaUsuariosAdmin();
    			usAdmin.borrarUsuario(usAdmin.bonitaSession(null, null), usBonita);
    			
			} catch (BonitaHomeNotSetException | ServerAPIException
					| UnknownAPITypeException | DeletionException
					| LoginException e) {
				e.printStackTrace();
			}
    	}
    	
    	return res;
	}
	
	private void generaContrasenaHash(UsuarioVO usuario) {
		String plainTextPassword = usuario.getContra();
		RandomNumberGenerator rng = new SecureRandomNumberGenerator();
		Object salt = rng.nextBytes();
		 
		// Now hash the plain-text password with the random salt and multiple
		// iterations and then Base64-encode the value (requires less space than Hex):
		String hashedPasswordBase64 = new Sha256Hash(plainTextPassword, salt,1024).toBase64();
		 
		usuario.setContra(hashedPasswordBase64);
		usuario.setSalt(salt.toString());
	}

}
