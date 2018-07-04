package mx.org.inai.viajesclaros.admin.workflows;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import org.bonitasoft.engine.api.ApiAccessType;
import org.bonitasoft.engine.api.LoginAPI;
import org.bonitasoft.engine.api.TenantAPIAccessor;
import org.bonitasoft.engine.exception.BonitaHomeNotSetException;
import org.bonitasoft.engine.exception.ServerAPIException;
import org.bonitasoft.engine.exception.UnknownAPITypeException;
import org.bonitasoft.engine.platform.LoginException;
import org.bonitasoft.engine.platform.UnknownUserException;
import org.bonitasoft.engine.session.APISession;
import org.bonitasoft.engine.util.APITypeManager;

public class BonitaAmbienteAdmin {

	Properties prop = new Properties();
	
	public BonitaAmbienteAdmin() {
		super();
		try {
			prop.load(BonitaAmbienteAdmin.class.getClassLoader().getResourceAsStream("viajes_claros.properties"));
			
			Map<String, String> settings = new HashMap<String, String>();
			settings.put("server.url", prop.getProperty("bonita_url"));
			settings.put("application.name", prop.getProperty("bonita_app"));
			APITypeManager.setAPITypeAndParams(ApiAccessType.HTTP, settings);
			System.out.println("***** " + prop.getProperty("bonita_url") + prop.getProperty("bonita_app"));
		} catch (IOException ex) {
	        ex.printStackTrace();
	    }
	}
	
	public APISession bonitaSession(String user, String pwd) throws BonitaHomeNotSetException, ServerAPIException,
										UnknownAPITypeException, UnknownUserException, LoginException {
		final LoginAPI loginAPI = TenantAPIAccessor.getLoginAPI();
		APISession sessionBPM;
		
		if (user == null || pwd == null) {
			System.out.println("********** Te conectaste con ADMIN");
			sessionBPM = loginAPI.login(prop.getProperty("bonita_user"), prop.getProperty("bonita_pwd"));
		} else {
			System.out.println("********** Te conectaste con otro");
			sessionBPM = loginAPI.login(user, pwd);
		}
		
		return sessionBPM;
	}
}
