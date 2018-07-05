package mx.org.inai.viajesclaros.admin.ejb;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.ejb.Stateless;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletContext;
import mx.org.inai.viajesclaros.domain.DatosServidorPublicoDomain;
import mx.org.inai.viajesclaros.domain.SimpleElementDomain;
import mx.org.inai.viajesclaros.domain.SuscripcionCampoDomain;
import mx.org.inai.viajesclaros.domain.ViajeDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class SuscripcionService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(SuscripcionService.class);

    /**
     * Obtiene los campos de la categoría, indicando si están configurados
     * (enabled) o no
     *
     * @param idDependencia
     * @param categoria
     * @return
     * @throws Exception
     */
    public List<SuscripcionCampoDomain> getCamposSuscripcionPorCat(Integer idDependencia, String categoria) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            List<SuscripcionCampoDomain> list = session.createSQLQuery("CALL get_suscripcion_campos_por_cat(:idDep, :cat)")
                    .setParameter("idDep", idDependencia)
                    .setParameter("cat", categoria)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SuscripcionCampoDomain domain = new SuscripcionCampoDomain();
                            domain.setCampo((String) tuple[0]);
                            domain.setDespliegue((String) tuple[1]);
                            Boolean b = (Integer) tuple[2] != 0;
                            domain.setEnabled(b);
                            return domain;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS CAMPOS DE SUSCRIPCIÓN POR CATEGORÍA", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Guarda la lista de campos para la dependencia indicada
     *
     * @param idDependencia
     * @param list
     * @throws Exception
     */
    public void saveCamposSuscripcion(Integer idDependencia, List<SuscripcionCampoDomain> list) throws Exception {
        try {
            Session session = em.unwrap(Session.class);

            /* Insertar los campos */
            for (SuscripcionCampoDomain c : list) {
                if (c.getEnabled()) {
                    log.info("INSERT: idDep: " + idDependencia + ", campo: " + c.getCampo());
                    session.createSQLQuery("CALL insert_suscripcion_config(:idDep, :nombreCampo)")
                            .setParameter("idDep", idDependencia)
                            .setParameter("nombreCampo", c.getCampo())
                            .executeUpdate();
                    session.flush();
                    session.clear();
                }
            }
        } catch (Exception e) {
            log.error("ERROR AL AL GUARDAR LOS CAMPOS DE SUSCRIPCIÓN", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Elimina la configuración de suscripción para la dependencia indicada
     *
     * @param idDependencia
     * @throws Exception
     */
    public void deleteSuscripcionPorDependencia(Integer idDependencia) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_suscripcion_config_por_dep(:idDep)")
                    .setParameter("idDep", idDependencia)
                    .executeUpdate();
            session.flush();
            session.clear();
        } catch (Exception e) {
            log.error("ERROR AL ELIMINAR LOS CAMPOS DE SUSCRIPCIÓN", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Consulta los Ids de los últimos viajes y el correo de los suscriptores
     *
     * @return
     * @throws Exception
     */
    private List<SimpleElementDomain> getSuscripcionUltimosViajes() throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<SimpleElementDomain> list = session.createSQLQuery("CALL get_suscripcion_ultimos_viajes()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            SimpleElementDomain domain = new SimpleElementDomain();
                            domain.setId((Integer) tuple[0]);
                            domain.setDescripcion((String) tuple[1]);
                            return domain;
                        }
                    })
                    .list();
            session.flush();
            session.clear();

            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS ÚLTIMOS VIAJES PARA ENVÍO A SUSCRIPTORES", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Obtiene los datos parametrizados del viaje para su envío a suscriptores
     *
     * @param idViaje
     * @return
     * @throws Exception
     */
    private ViajeDomain getDatosViajeSuscripcion(Integer idViaje) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<ViajeDomain> list = session.createSQLQuery("CALL get_viaje_datos_suscripcion(:idViaje)")
                    .setParameter("idViaje", idViaje)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            ViajeDomain viaje = new ViajeDomain();
                            List<String> datos = new ArrayList<>();
                            List<String> headers = new ArrayList<>();

                            for (int i = 1; i < tuple.length; i++) {
                                datos.add((String) tuple[i]);
                                headers.add((String) aliases[i]);
                            }

                            viaje.setDatos(datos);
                            viaje.setHeaders(headers);
                            return viaje;
                        }
                    })
                    .list();
            session.flush();
            session.clear();

            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new ViajeDomain();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS DATOS DEL VIAJE EN SUSCRIPCIÓN", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene los datos parametrizados del viaje para su envío a suscriptores
     *
     * @param idViaje
     * @return
     * @throws Exception
     */
    private DatosServidorPublicoDomain getDatosServidorPublico(Integer idViaje) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            List<DatosServidorPublicoDomain> list = session.createSQLQuery("CALL get_datos_servidor_publico(:idViaje)")
                    .setParameter("idViaje", idViaje)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            DatosServidorPublicoDomain servidorPublico = new DatosServidorPublicoDomain();
                            servidorPublico.setNombreCompleto((String) tuple[0]);
                            servidorPublico.setDependencia((String) tuple[1]);

                            return servidorPublico;
                        }
                    })
                    .list();
            session.flush();
            session.clear();

            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new DatosServidorPublicoDomain();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR LOS DATOS DEL SERVIDOR PÚBLICO", e);
            throw new Exception(e.getMessage());
        }
    }

    /**
     * Realiza el proceso de envío de correos. Es llamado desde el web por medio
     * de una tarea programada.
     */
    public void procesoEnvioDeCorreos() throws NamingException {
        
        String nombre = "";
        String dependencia = "";
        Context ctx = new InitialContext();
        Context env = (Context) ctx.lookup("java:comp/env");
        final String ruta = (String) env.lookup("PathComisiones");
        
        try {

            /* Obtiene los datos de los viajes recientes */
            List<SimpleElementDomain> list = this.getSuscripcionUltimosViajes();
            if (list.isEmpty()) {
                log.info("NO HAY VIAJES RECIENTES PARA EL ENVÍO DE CORREOS (SUSCRIPCIONES).");
            }

            for (SimpleElementDomain d : list) {
                String detalle = "";
                ViajeDomain viajeDomain = this.getDatosViajeSuscripcion(d.getId());
                DatosServidorPublicoDomain datosServidorPublico = this.getDatosServidorPublico(d.getId());
                for (int i = 0; i < viajeDomain.getHeaders().size(); i++) {
                    log.info("-> " + viajeDomain.getHeaders().get(i) + ": " + viajeDomain.getDatos().get(i));
                    detalle += "<br/><b>" + getAcuteString(viajeDomain.getHeaders().get(i)) + "</b> : " + getAcuteString(viajeDomain.getDatos().get(i));
                }
                
                /*detalle += "<br/><b>Nombre del Evento:</b> " + getAcuteString(viajeDomain.getDatos().get(3));
                detalle += "<br/><b>Motivo:</b>   ";
                detalle += "<br/><b>De:</b> " + getAcuteString(viajeDomain.getDatos().get(2)) + " <b>A:</b> " + getAcuteString(viajeDomain.getDatos().get(2));
                detalle += "<br/><b>Monto total de la comisi&oacute;n:</b> " + getAcuteString(viajeDomain.getDatos().get(0));*/
                detalle += "<br/><a href='http://" + ruta + "/comisiones-abiertas/#/viaje/" + d.getId() + "'>"
                    + "Consultar Detalle</a>";
                
                nombre = getAcuteString(datosServidorPublico.getNombreCompleto());
                dependencia = getAcuteString(datosServidorPublico.getDependencia());
                String mensajeHtml = "<img src=\"cid:image\"><p><strong style='font-size:14.0pt;color:#028E8E'>"
                    + "Comisi&oacute;n oficial de trabajo</strong>"
                    + "</p><p>Estimado(a) usuario(a),</p><p>&nbsp;</p>"
                    + "<p>El servidor p&uacute;blico <strong style='font-size:14.0pt;color:#028E8E'>" 
                    + nombre + ".</strong> del " 
                    + dependencia + " ha realizado una nueva comisi&oacute;n de "
                    + "trabajo.</p><br/><div>[detalle]</div><p>Si usted desea dejar de recibir estas "
                    + "notificaciones, favor de ponerse en contacto a trav&eacute;s del correo "
                    + "electr&oacute;nico <a href='mailto:comisionesabiertas@inai.org.mx'>"
                    + "comisionesabiertas@inai.org.mx</a>, o al tel&eacute;fono "
                    + "(55) 5004 2400 ext. 2157, 2191 y 2126.</p><p>&nbsp;</p>"
                    + "<table style='background-color: #f2f2f2;'><tbody><tr>"
                    + "<td style='text-align: center; color: #575756; font-size: 10.0pt; "
                    + "font-family: HelveticaNeue-Medium,sans-serif; "
                    + "mso-bidi-font-family: HelveticaNeue-Medium;'>"
                    + "<p>Instituto Nacional de Transparencia, Acceso a la Informaci&oacute;n y "
                    + "Protecci&oacute;n de Datos Personales</p><p>Insurgentes Sur No. 3211"
                    + " Col. Insurgentes Cuicuilco, Delegaci&oacute;n Coyoac&aacute;n, "
                    + "C.P. 04530</p><p>Correo: <a href='mailto:comisionesabiertas@inai.org.mx'>"
                    + "comisionesabiertas@inai.org.mx</a>, tel&eacute;fono "
                    + "(55) 5004 2400 ext. 2157, 2191 y 2126.</p>"
                    + "<p style='color: #028e8e;'><strong>"
                    + "<a href='http://" + ruta + "/comisiones-abiertas/assets/pdf/INAI_aviso_privacidad.pdf'>"
                    + "Aviso de privacidad</a></strong></p></td></tr></tbody></table>";
                        
                mensajeHtml = mensajeHtml.replace("[detalle]", detalle);

                /* ENVIAR EL CORREO */
                sendMail(d.getDescripcion(), mensajeHtml);
            }

        } catch (Exception e) {
            log.error("ERROR EN EL PROCESO DE ENVÍO DE CORREOS", e);
        }
    }

    private void sendMail(String emailDir, String html) {
        try {
            /* Consultar los datos SMTP */
            Session ses = em.unwrap(Session.class);
            List<Object[]> resultSmtp = ses.createSQLQuery("CALL get_smtp_config()").list();
            Object[] dataSmtp = resultSmtp.get(0);
            final String host = dataSmtp[1].toString();
            final String port = dataSmtp[2].toString();
            final String user = dataSmtp[3].toString();
            final String pass = dataSmtp[4].toString();
            log.info("host: " + host);
            log.info("port: " + port);
            log.info("user: " + user);
            log.info("pass: " + pass);

            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", port);

            javax.mail.Session session = javax.mail.Session.getDefaultInstance(props,
                    new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            });

            DataSource fds = new FileDataSource("/var/www/html/comisiones-abiertas/assets/img/ComisionesAbiertasMail.png");
            
            MimeMultipart multipart = new MimeMultipart("related");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("comisionesabiertas@inai.org.mx"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailDir));
            message.setSubject("Comisiones Abiertas - Se ha registrado una nueva comisión oficial de trabajo");
            BodyPart messageBodyPart = new MimeBodyPart();
                        
            messageBodyPart.setContent(html, "text/html");
            multipart.addBodyPart(messageBodyPart);
                           
                        
            messageBodyPart = new MimeBodyPart();
            messageBodyPart.setDataHandler(new DataHandler(fds));
            messageBodyPart.setHeader("Content-ID", "<image>");
            multipart.addBodyPart(messageBodyPart);
            message.setContent(multipart);

            
            Transport.send(message);
        } catch (Exception e) {
            log.error("ERROR AL ENVIAR UN CORREO. ", e);
        }
    }

    private String getAcuteString(String cadena){
        cadena = cadena.replace("á","&aacute;").replace("é","&eacute;").replace("í","&iacute;").replace("ó","&oacute;").replace("ú","&uacute;");
        cadena = cadena.replace("Á","&Aacute;").replace("É","&Eacute;").replace("Í","&Iacute;").replace("Ó","&Oacute;").replace("Ú","&Uacute;");
        cadena = cadena.replace("Ñ","&Ntilde;").replace("ñ","&ntilde;").replace("Ü","&Uuml;").replace("ü","&uuml;");
        return cadena;
    }
}
