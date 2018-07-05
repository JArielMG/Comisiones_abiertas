package mx.org.inai.viajesclaros.admin.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.bonitasoft.engine.bpm.process.ProcessInstance;

import mx.org.inai.viajesclaros.admin.model.MailConfigVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.service.ServerConfigServices;

public class SendMail {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ProcesoVO flujo = new ProcesoVO();
		flujo.setNombre("Prueba de Flujo para Correo");
		//ProcessInstance instance = new ProcessInstance();
		
		SendMail.email("mikengel19@gmail.com", flujo, null);
	}
	
	public static void email(String emailTo, ProcesoVO flujo, ProcessInstance instance) {
		ServerConfigServices server = new ServerConfigServices();
		final MailConfigVO config = server.obtenerMailServer();
		
		Properties props = new Properties();
		props.put("mail.smtp.host", config.getHost());
		props.put("mail.smtp.socketFactory.port", config.getPuerto());
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", config.getPuerto());

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(config.getUsuario(), config.getContra());
			}
		  });

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(config.getUsuario()));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(emailTo));
			message.setSubject("Administración de Viajes Claros - " + flujo.getNombre());
			message.setText("Estimado usuario: "
				+ "\n\n Le ha llegado a su bandeja de notificaciones, la solicitud de aprobación para la siguiente tarea: "
				+ instance.getId() + ". Favor de ingresar al sitio para mayor detalle.\n");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			e.printStackTrace();
			//System.out.println("****** Sent message horribly.... " + e.getMessage());
			throw new RuntimeException(e);
		}
	}
}
