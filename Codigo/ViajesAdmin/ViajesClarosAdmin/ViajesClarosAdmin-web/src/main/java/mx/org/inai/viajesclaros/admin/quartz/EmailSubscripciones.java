
package mx.org.inai.viajesclaros.admin.quartz;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.Logger;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

/**
 * Tarea programada de envío de información a los suscriptores de Viajes Claros.
 *
 * @author Sandro Alejandro
 */
public class EmailSubscripciones implements ServletContextListener {

    final static Logger log = Logger.getLogger(EmailSubscripciones.class);


    @Override
    public void contextInitialized(ServletContextEvent sce) {
        JobDetail job = JobBuilder.newJob(EmailJob.class).withIdentity("Enviar Correo", "group1").build();

        // TODO: Programar la tarea para que corra todos los días a las 12am
        Trigger trigger = TriggerBuilder
		.newTrigger()
		.withIdentity("trigerEmail", "group1")
		.withSchedule(
			CronScheduleBuilder.cronSchedule("0 0 0 * * ?"))
		.build();

        // schedule it
        try {
            Scheduler scheduler = new StdSchedulerFactory().getScheduler();
            scheduler.start();
            scheduler.scheduleJob(job, trigger);
        } catch (Exception e) {
            log.error("ERROR EN EL PROCESO DE ENVÍO DE CORREOS. ", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
