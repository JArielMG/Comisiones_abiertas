
package mx.org.inai.viajesclaros.admin.quartz;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import javax.naming.InitialContext;
import mx.org.inai.viajesclaros.admin.ejb.SuscripcionService;

/**
 * Tarea que realiza el envío de correo a los suscriptores
 *
 * @author Sandro Alejandro
 */
public class EmailJob implements Job {

    final static Logger log = Logger.getLogger(EmailJob.class);

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {

        try {
            /* Buscar el EJB por nombre debido a que no es posible inyectarlo dentro del Job */
            InitialContext ctx = new InitialContext();
            SuscripcionService suscripcionService = (SuscripcionService) ctx.lookup("java:global/ViajesClarosAdmin-web/SuscripcionService");
            suscripcionService.procesoEnvioDeCorreos();
        } catch (Exception e) {
            log.error("ERROR AL EJECUTAR EL PROCESO DE ENVÍO DE CORREOS", e);
            throw new JobExecutionException(e.getMessage());
        }
    }
}
