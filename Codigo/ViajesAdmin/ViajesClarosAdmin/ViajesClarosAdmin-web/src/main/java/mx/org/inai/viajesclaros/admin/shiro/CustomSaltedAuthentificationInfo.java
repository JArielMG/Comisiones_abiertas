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

import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.SimpleByteSource;

/**
 *
 * @author Sandro Alejandro
 */
public class CustomSaltedAuthentificationInfo implements SaltedAuthenticationInfo {
    private static final long serialVersionUID = -5467967895187234984L;
	  
	  private final String username;
	  private final String password;
	  private final String salt;
	 
	  public CustomSaltedAuthentificationInfo(String username, String password, String salt) {
	    this.username = username;
	    this.password = password;
	    this.salt = salt;
	  }
	 
	  @Override
	  public PrincipalCollection getPrincipals() {
	    PrincipalCollection coll = new SimplePrincipalCollection(username, username);
	    return coll;
	  }
	 
	  @Override
	  public Object getCredentials() {
	    return password;
	  }
	 
	  @Override
	  public ByteSource getCredentialsSalt() {
	    return new SimpleByteSource(Base64.decode(salt)); 
	  }

}
