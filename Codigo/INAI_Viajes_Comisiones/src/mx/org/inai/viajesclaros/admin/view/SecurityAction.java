package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.Collection;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mx.org.inai.viajesclaros.admin.model.SesionVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.UserServices;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionManager;
import org.apache.shiro.util.Factory;

//import mx.org.inai.viajesclaros.admin.service.SecurityServices;

/**
 * Servlet implementation class SecurityAction
 */
@WebServlet(name = "SecurityAction", urlPatterns = { "/securityAction" })
public class SecurityAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//private SecurityServices securitySrv = new SecurityServices();
	private UserServices usServ = new UserServices();
	
	public SecurityAction() {
		super();
		Factory<org.apache.shiro.mgt.SecurityManager> factory = new IniSecurityManagerFactory();
		org.apache.shiro.mgt.SecurityManager securityManager = factory.getInstance();
		SecurityUtils.setSecurityManager(securityManager);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doPost(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destino = "login.jsp";
		String action = request.getParameter("action");
		
		if (action == null) {
			action = "login";
		}
    	
        if (action.equals("login")) {
        	org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
        	
        	String us = request.getParameter("user");
            String pas = request.getParameter("pass");
            
            if (us == null || us.equals("") || pas == null || pas.equals("")) {
            	request.setAttribute("mensaje", "Usuario o Contrase&ntilde;a incorrectos");
            } else {
	            if (!currentUser.isAuthenticated()) {
	        	    //collect user principals and credentials in a gui specific manner
	        	    //such as username/password html form, X509 certificate, OpenID, etc.
	        	    //We'll use the username/password example here since it is the most common.
	        	    UsernamePasswordToken token = new UsernamePasswordToken(us,pas);
	        	     //this is all you have to do to support 'remember me' (no config - built in!):
	        	    //token.setRememberMe(rememberMe);
	        	    try {
	        	        currentUser.login(token);
	        	        
	        	        UsuarioVO usuario = usServ.obtenerUsuario(us);
	        	        SesionVO sesion = new SesionVO();
	        	        sesion.setUsuario(us);
	        	        sesion.setPerfil(usuario.getPerfil());
	        	        sesion.setFechaHora(new Date());
	        	        //System.out.println("User [" + currentUser.getPrincipal().toString() + "] logged in successfully.");
	        	         
	        	        // save current username in the session, so we have access to our User model
	        	        currentUser.getSession().setAttribute("sesion", sesion);
	        	        request.setAttribute("account", org.apache.shiro.SecurityUtils.getSubject().getPrincipals().oneByType(java.util.Map.class));
	        	        request.getSession().setAttribute("sesion", sesion);
	        	        
	        	        destino = "index.jsp";
	        	    } catch (UnknownAccountException uae) {
	        	      System.out.println("Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
	        	      request.setAttribute("mensaje", "Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
	        	    } catch (IncorrectCredentialsException ice) {
	        	      System.out.println("Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
	        	      request.setAttribute("mensaje", "Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
	        	    } catch (LockedAccountException lae) {
	        	      System.out.println("La cuenta " + token.getPrincipal() + " esta bloqueada. "
	        	                + "Favor de contactar a su administrador para el desbloqueo.");
	        	      request.setAttribute("mensaje", "La cuenta " + token.getPrincipal() + " esta bloqueada. "
	        	                + "Favor de contactar a su administrador para el desbloqueo.");
	        	    } catch (AuthenticationException ice) {
		        	      System.out.println("Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
		        	      request.setAttribute("mensaje", "Usuario o Contrase&ntilde;a incorrectos para " + token.getPrincipal());
		        	}
	        	  } else {
	        		  destino = "index.jsp";
	        	  }
            }
        } else if (action.equals("logout")) {
        	SecurityUtils.getSubject().logout();
        	org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
        	DefaultSecurityManager securityManager = (DefaultSecurityManager) SecurityUtils.getSecurityManager();
            DefaultSessionManager sessionManager = (DefaultSessionManager) securityManager.getSessionManager();
            Collection<Session> activeSessions = sessionManager.getSessionDAO().getActiveSessions();
            for (Session session: activeSessions){
            	if (currentUser.getSession().getId().equals(session.getId())) {
                    session.stop();
                }
            }
            
            HttpSession session = request.getSession(false);
            if (session != null) {
            	session.invalidate();
            }
        	
        } else {
        	destino = "login.jsp";
        }
        
        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
