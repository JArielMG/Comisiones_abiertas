package mx.org.inai.viajesclaros.admin.security;

import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.UserServices;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.jdbc.JdbcRealm;

public class CustomShiroRealm extends JdbcRealm {
	  @Override
	  protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
	    // identify account to log to
	    UsernamePasswordToken userPassToken = (UsernamePasswordToken) token;
	    final String username = userPassToken.getUsername();
	    final UserServices usrSrv = new UserServices();
	 
	    if (username == null) {
	      System.out.println("Username is null.");
	      return null;
	    }
	 
	    // read password hash and salt from db
	    final UsuarioVO usuario = usrSrv.obtenerUsuario(username);
	    
	    SaltedAuthenticationInfo info = new CustomSaltedAuthentificationInfo(username, usuario.getContra(), usuario.getSalt());
	 
	    return info;
	  }

}
