/*
 * Copyright (C) 2015 INAI
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package mx.org.inai.viajesclaros.admin.shiro;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import javax.naming.InitialContext;
import mx.org.inai.viajesclaros.admin.ejb.UserService;
import mx.org.inai.viajesclaros.domain.UsuarioDomain;
import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

/**
 * Clase adecuada para consultar los datos del usuario en el Login
 * @author Sandro Alejandro
 */
public class CustomShiroRealm extends AuthorizingRealm {
    
    final static Logger log = Logger.getLogger(CustomShiroRealm.class);
    
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {
        String rol = "";
        
        try {
            String username = pc.getPrimaryPrincipal().toString();
            InitialContext ctx = new InitialContext();
            UserService userService = (UserService) ctx.lookup("java:global/ViajesClarosAdmin-web/UserService");    
            UsuarioDomain usuario = userService.findByUsername(username);
            rol = usuario.getPerfil().getNombre();
        } catch(Exception e) {
            
        }
        
        Set<String> roles = new HashSet<>();
        roles.add(rol);
        
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roles);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        UsuarioDomain usuario = new UsuarioDomain();
        
        try {
            InitialContext ctx = new InitialContext();
            UserService userService = (UserService) ctx.lookup("java:global/ViajesClarosAdmin-web/UserService");    
            usuario = userService.findByUsername(upToken.getUsername());
            log.info("USER " + usuario.getUsuario());
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR EL USUARIO EN LOGIN", e);
            throw new AuthenticationException(e);
        }
        
        return new CustomSaltedAuthentificationInfo(usuario.getUsuario(), usuario.getContrasena(), usuario.getSalt());
    }
    
}
