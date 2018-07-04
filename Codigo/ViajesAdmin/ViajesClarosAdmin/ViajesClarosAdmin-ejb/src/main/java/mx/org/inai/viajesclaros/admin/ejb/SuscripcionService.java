package mx.org.inai.viajesclaros.admin.ejb;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.ejb.Stateless;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
     * Realiza el proceso de envío de correos. Es llamado desde el web por medio
     * de una tarea programada.
     */
    public void procesoEnvioDeCorreos() {

        try {

            /* Obtiene los datos de los viajes recientes */
            List<SimpleElementDomain> list = this.getSuscripcionUltimosViajes();
            if (list.isEmpty()) {
                log.info("NO HAY VIAJES RECIENTES PARA EL ENVÍO DE CORREOS (SUSCRIPCIONES).");
            }

            for (SimpleElementDomain d : list) {
                String detalle = "";
                ViajeDomain viajeDomain = this.getDatosViajeSuscripcion(d.getId());
                for (int i = 0; i < viajeDomain.getHeaders().size(); i++) {
                    log.info("-> " + viajeDomain.getHeaders().get(i) + ": " + viajeDomain.getDatos().get(i));
                    detalle += "<br/><b>" + viajeDomain.getHeaders().get(i) + "</b> : " + viajeDomain.getDatos().get(i);
                }

                String html = "<h2>Viajes Claros</h2><p>Se ha registrado un nuevo viaje del "
                        + "funcionario <b>[funcionario]</b> en el sitio web Viajes Claros.</p>"
                        + "<h3>Detalle del viaje</h3>"
                        + "<div>[detalle]</div>";
                html = html.replace("[detalle]", detalle);

                /* ENVIAR EL CORREO */
                sendMail(d.getDescripcion(), html);
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

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("viajes.claros@inai.org.mx"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailDir));
            message.setSubject("Viajes Claros | Se ha registrado un nuevo viaje");
            message.setContent(html, "text/html; charset=utf-8");

            Transport.send(message);
        } catch (Exception e) {
            log.error("ERROR AL ENVIAR UN CORREO. ", e);
        }
    }

}
