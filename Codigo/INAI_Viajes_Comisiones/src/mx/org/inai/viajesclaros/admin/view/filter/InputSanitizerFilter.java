package mx.org.inai.viajesclaros.admin.view.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

@WebFilter("/GenericFilter")
public class InputSanitizerFilter implements Filter {
	private static final Logger LOG = Logger.getLogger(InputSanitizerFilter.class);

	private static final String BANNED_INPUT_CHARS = ".*[^a-zA-Z0-9\\@\\'\\,\\.\\/\\(\\)\\+\\=\\-\\_\\[\\]\\{\\}\\^\\!\\*\\&\\%\\$\\:\\;\\? \\t]+.*";
    
    public static final String QUARANTINE_ATTRIBUTE_NAME = "filter.quarantined.params";
    public static final String SUSPICIOUS_REQUEST_FLAG_NAME = "filter.suspicious.request";
    
    public void init(FilterConfig fConfig) throws ServletException {
    	
    }
     
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
 
    	//wrap the original request and set up an empty quarantine map
    	CustomHttpRequest newRequest = new CustomHttpRequest((HttpServletRequest)request);
        Map<String, String> quarantine = new HashMap<String, String>();
        newRequest.setAttribute(QUARANTINE_ATTRIBUTE_NAME, quarantine);
         
        //inspect each parameter, and move any suspicious ones into thw quarantine area
        Enumeration<String> names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            String value = request.getParameter(name);
            if (value.matches(BANNED_INPUT_CHARS)) {
                //uh-oh, found something that doesn't look right, quarantine it and make sure the request is flagged as suspicious
                LOG.warn("Removing potentially malicious parameter from request:  " + name);
                quarantine.put(name, value);
                newRequest.removeParameter(name);
                newRequest.setAttribute(SUSPICIOUS_REQUEST_FLAG_NAME, "true");
            }
        }
         
        //done, send the modified request on down the chain
        chain.doFilter(newRequest, response);
         
    }
 
     
 
    public void destroy() {
        //close any resources here
    }

}
