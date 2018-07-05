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
package mx.org.inai.viajesclaros.services;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.ejb.Stateless;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.model.FuncionarioModel;
import mx.org.inai.viajesclaros.model.MailProperties;
import mx.org.inai.viajesclaros.model.PorcentajeDiasComisionModel;
import mx.org.inai.viajesclaros.model.SimpleObjectModel;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class FuncionarioService {

    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(FuncionarioService.class);

    /**
     * Obtiene los datos del funcionario por el Id indicado
     *
     * @param func
     * @return
     */
    public FuncionarioModel getById(FuncionarioModel func) {
        Session session = em.unwrap(Session.class);

        List<FuncionarioModel> list = session.createSQLQuery("CALL get_funcionario_por_id(:idFuncionario, :nombre, :apellido1, :apellido2)")
                .setParameter("idFuncionario", func.getId())
                .setParameter("nombre", func.getNombres())
                .setParameter(("apellido1"), func.getApellido1())
                .setParameter("apellido2", func.getApellido2())
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FuncionarioModel f = new FuncionarioModel();
                        f.setId(Integer.valueOf(tuple[0].toString()));
                        f.setNombres((String) tuple[1]);
                        f.setApellido1((String) tuple[2]);
                        f.setApellido2((String) tuple[3]);
                        f.setTitulo((String) tuple[4]);
                        f.setEmail((String) tuple[5]);
                        f.setIdCategoria(Integer.valueOf(tuple[6].toString()));
                        f.setCategoria((String) tuple[7]);
                        f.setIdTipoPersona(Integer.valueOf(tuple[8].toString()));
                        f.setTipoPersona((String) tuple[9]);
                        f.setIdArea(Integer.valueOf(tuple[10].toString()));
                        f.setArea((String) tuple[11]);
                        f.setIdDependencia(Integer.valueOf(tuple[12].toString()));
                        return f;
                    }
                })
                .list();

        session.flush();
        session.clear();
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return new FuncionarioModel();
        }
    }

    /**
     * Obtiene todos los funcionarios
     *@param anio
     * 
     * @return
     */
    public List<FuncionarioModel> findAllResumen(Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<FuncionarioModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_funcionarios_resumen_anio(:anio)")
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setNombreCompleto(f.getNombres() + " " + f.getApellido1() + " " + f.getApellido2());
                            f.setCargo((String) tuple[4]);
                            f.setTotalGasto((Double) tuple[5]);
                            f.setViajeMasCostoso((Double) tuple[6]);
                            f.setIdViajeMasCostoso((Integer) tuple[7]);
                            f.setFechaIngreso((Date) tuple[8]);
                            f.setDependencia((String) tuple[9]);
                            f.setTotalViajes(((BigInteger) tuple[10]).intValue());
                            return f;
                        }
                    })
                    .list();
            }else{
                list = session.createSQLQuery("CALL get_funcionarios_resumen()")
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setNombreCompleto(f.getNombres() + " " + f.getApellido1() + " " + f.getApellido2());
                            f.setCargo((String) tuple[4]);
                            f.setTotalGasto((Double) tuple[5]);
                            f.setViajeMasCostoso((Double) tuple[6]);
                            f.setIdViajeMasCostoso((Integer) tuple[7]);
                            f.setFechaIngreso((Date) tuple[8]);
                            f.setDependencia((String) tuple[9]);
                            f.setTotalViajes(((BigInteger) tuple[10]).intValue());
                            return f;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            return list;
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR TODOS LOS FUNCIONARIOS", e);
            return new ArrayList<>();
        }
    }

    /**
     * obtiene el funcionario por el id de viaje
     *
     * @param idViaje
     * @return
     */
    public FuncionarioModel getByIdViaje(Integer idViaje) {
        try {
            Session session = em.unwrap(Session.class);

            List<FuncionarioModel> list = session.createSQLQuery("CALL get_funcionario_por_id_viaje(:idViaje)")
                    .setParameter("idViaje", idViaje)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            FuncionarioModel f = new FuncionarioModel();
                            f.setId(Integer.valueOf(tuple[0].toString()));
                            f.setNombres((String) tuple[1]);
                            f.setApellido1((String) tuple[2]);
                            f.setApellido2((String) tuple[3]);
                            f.setTitulo((String) tuple[4]);
                            f.setEmail((String) tuple[5]);
                            f.setIdCategoria(Integer.valueOf(tuple[6].toString()));
                            f.setCategoria((String) tuple[7]);
                            f.setIdTipoPersona(Integer.valueOf(tuple[8].toString()));
                            f.setTipoPersona((String) tuple[9]);
                            f.setIdArea(Integer.valueOf(tuple[10].toString()));
                            f.setArea((String) tuple[11]);
                            f.setIdDependencia(Integer.valueOf(tuple[12].toString()));
                            return f;
                        }
                    })
                    .list();

            session.flush();
            session.clear();
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new FuncionarioModel();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR EL FUNCIONARIO POR ID VIAJE", e);
            return new FuncionarioModel();
        }
    }

    /**
     * Obtiene los funcionarios de la dependencia indicada
     *
     * @param idDependencia
     * @param anio
     * @return
     */
    public List<FuncionarioModel> getFuncionariosByDependencia(Integer idDependencia, Integer anio) {
        Session session = em.unwrap(Session.class);

        List<FuncionarioModel> funcionarios;
            if (anio>0){
                funcionarios = session.createSQLQuery("CALL get_funcionarios_por_dependencia_anio(:idDep,:anio)")
                .setParameter("idDep", idDependencia)
                .setParameter("anio", anio)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FuncionarioModel funcionario = new FuncionarioModel();
                        funcionario.setId(Integer.valueOf(tuple[0].toString()));
                        funcionario.setNombres((String) tuple[1]);
                        funcionario.setApellido1((String) tuple[2]);
                        funcionario.setApellido2((String) tuple[3]);
                        funcionario.setNombreCompleto(funcionario.getNombres() + ' ' + funcionario.getApellido1() + ' ' + funcionario.getApellido2());
                        funcionario.setTitulo((String) tuple[4]);
                        funcionario.setEmail((String) tuple[5]);
                        funcionario.setIdCategoria(Integer.valueOf(tuple[6].toString()));
                        funcionario.setCategoria((String) tuple[7]);
                        funcionario.setIdTipoPersona(Integer.valueOf(tuple[8].toString()));
                        funcionario.setTipoPersona((String) tuple[9]);
                        funcionario.setIdArea(Integer.valueOf(tuple[10].toString()));
                        funcionario.setArea((String) tuple[11]);
                        funcionario.setCargo((String) tuple[12]);
                        funcionario.setTotalViajes(((BigInteger) tuple[13]).intValue());
                        funcionario.setTotalGasto((Double) tuple[14]);
                        return funcionario;
                    }
                })
                .list();
            }else{
                funcionarios = session.createSQLQuery("CALL get_funcionarios_por_dependencia(:idDep)")
                .setParameter("idDep", idDependencia)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FuncionarioModel funcionario = new FuncionarioModel();
                        funcionario.setId(Integer.valueOf(tuple[0].toString()));
                        funcionario.setNombres((String) tuple[1]);
                        funcionario.setApellido1((String) tuple[2]);
                        funcionario.setApellido2((String) tuple[3]);
                        funcionario.setNombreCompleto(funcionario.getNombres() + ' ' + funcionario.getApellido1() + ' ' + funcionario.getApellido2());
                        funcionario.setTitulo((String) tuple[4]);
                        funcionario.setEmail((String) tuple[5]);
                        funcionario.setIdCategoria(Integer.valueOf(tuple[6].toString()));
                        funcionario.setCategoria((String) tuple[7]);
                        funcionario.setIdTipoPersona(Integer.valueOf(tuple[8].toString()));
                        funcionario.setTipoPersona((String) tuple[9]);
                        funcionario.setIdArea(Integer.valueOf(tuple[10].toString()));
                        funcionario.setArea((String) tuple[11]);
                        funcionario.setCargo((String) tuple[12]);
                        funcionario.setTotalViajes(((BigInteger) tuple[13]).intValue());
                        funcionario.setTotalGasto((Double) tuple[14]);
                        return funcionario;
                    }
                })
                .list();
            }
        session.flush();
        session.clear();
        return funcionarios;
    }

    /**
     * Obtiene los principales datos del funcionario (nombre, dependencia, gasto
     * total, total viajes)
     *
     * @param func
     * @param anio
     * @return
     */
    public FuncionarioModel getResumenById(FuncionarioModel func, Integer anio) {
        Session session = em.unwrap(Session.class);

        List<FuncionarioModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL get_funcionario_resumen_anio(:idFuncionario, :nom, :ap1, :ap2, :anio)")
                .setParameter("idFuncionario", func.getId())
                .setParameter(("nom"), func.getNombres())
                .setParameter("ap1", func.getApellido1())
                .setParameter("ap2", func.getApellido2())
                .setParameter("anio", anio)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FuncionarioModel funcionario = new FuncionarioModel();
                        funcionario.setId(Integer.valueOf(tuple[0].toString()));
                        funcionario.setNombres((String) tuple[1]);
                        funcionario.setApellido1((String) tuple[2]);
                        funcionario.setApellido2((String) tuple[3]);
                        funcionario.setCargo((String) tuple[4]);
                        funcionario.setIdDependencia(Integer.valueOf(tuple[5].toString()));
                        funcionario.setDependencia((String) tuple[6]);
                        funcionario.setTotalViajes(((BigInteger) tuple[7]).intValue());
                        funcionario.setTotalGasto((Double) tuple[8]);
                        funcionario.setFechaIngreso((Date) tuple[9]);
                        return funcionario;
                    }
                })
                .list();
            }else{
                list = session.createSQLQuery("CALL get_funcionario_resumen(:idFuncionario, :nom, :ap1, :ap2)")
                .setParameter("idFuncionario", func.getId())
                .setParameter(("nom"), func.getNombres())
                .setParameter("ap1", func.getApellido1())
                .setParameter("ap2", func.getApellido2())
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        FuncionarioModel funcionario = new FuncionarioModel();
                        funcionario.setId(Integer.valueOf(tuple[0].toString()));
                        funcionario.setNombres((String) tuple[1]);
                        funcionario.setApellido1((String) tuple[2]);
                        funcionario.setApellido2((String) tuple[3]);
                        funcionario.setCargo((String) tuple[4]);
                        funcionario.setIdDependencia(Integer.valueOf(tuple[5].toString()));
                        funcionario.setDependencia((String) tuple[6]);
                        funcionario.setTotalViajes(((BigInteger) tuple[7]).intValue());
                        funcionario.setTotalGasto((Double) tuple[8]);
                        funcionario.setFechaIngreso((Date) tuple[9]);
                        return funcionario;
                    }
                })
                .list();
            }

        session.flush();
        session.clear();
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return new FuncionarioModel();
        }
    }
    
    /**
     * Obtiene el cargo actual del funcionario
     *
     * @param func
     * @return
     */
    public String getFuncionarioCargo(FuncionarioModel func) {
        Session session = em.unwrap(Session.class);

        List<String> list;
            list = session.createSQLQuery("CALL get_funcionario_cargo_actual(:idFuncionario, :nom, :ap1, :ap2)")
                .setParameter("idFuncionario", func.getId())
                .setParameter(("nom"), func.getNombres())
                .setParameter("ap1", func.getApellido1())
                .setParameter("ap2", func.getApellido2())
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        String cargo = (String) tuple[0];
                        return cargo;
                    }
                })
                .list();

        session.flush();
        session.clear();
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return new String("");
        }
    }

    /**
     * Obtiene los porcentajde de días de comisión y días en las institución
     *
     * @param funcionario
     * @param anio
     * @return
     */
    public PorcentajeDiasComisionModel getPorcentajeDiasComision(FuncionarioModel funcionario, Integer anio) {
        try {
            Session session = em.unwrap(Session.class);

            List<PorcentajeDiasComisionModel> list;
            if (anio>0){
                list = session.createSQLQuery("CALL grafica_porcentajes_viajes_funcionario_anio(:idFuncionario, :nom, :ap1, :ap2, :anio)")
                    .setParameter("idFuncionario", funcionario.getId())
                    .setParameter("nom", funcionario.getNombres())
                    .setParameter(("ap1"), funcionario.getApellido1())
                    .setParameter("ap2", funcionario.getApellido2())
                    .setParameter("anio", anio)
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            PorcentajeDiasComisionModel model = new PorcentajeDiasComisionModel();
                            model.setTotalDiasViaje(((BigDecimal) tuple[0]).intValue());
                            model.setTotalDiasInstitucion(((BigInteger) tuple[1]).intValue());
                            model.setPorcentajeViaje(((BigDecimal) tuple[2]).floatValue());
                            model.setPorcentajeInstitucion(((BigDecimal) tuple[3]).floatValue());
                            return model;
                        }
                    })
                    .list();
            }else{
            list = session.createSQLQuery("CALL grafica_porcentajes_viajes_funcionario(:idFuncionario, :nom, :ap1, :ap2)")
                    .setParameter("idFuncionario", funcionario.getId())
                    .setParameter("nom", funcionario.getNombres())
                    .setParameter(("ap1"), funcionario.getApellido1())
                    .setParameter("ap2", funcionario.getApellido2())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            PorcentajeDiasComisionModel model = new PorcentajeDiasComisionModel();
                            model.setTotalDiasViaje(((BigDecimal) tuple[0]).intValue());
                            model.setTotalDiasInstitucion(((BigInteger) tuple[1]).intValue());
                            model.setPorcentajeViaje(((BigDecimal) tuple[2]).floatValue());
                            model.setPorcentajeInstitucion(((BigDecimal) tuple[3]).floatValue());
                            return model;
                        }
                    })
                    .list();
            }
            session.flush();
            session.clear();
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return new PorcentajeDiasComisionModel();
            }
        } catch (Exception e) {
            log.error("ERROR AL CONSULTAR EL PORCENTAJDE DE DÍAS DE COMISIÓN", e);
            return new PorcentajeDiasComisionModel();
        }
    }
    
    /**
     * Realiza la suscripción para recibir la información de viajes de un funcionario
     * @param model
     * @return 
     */
    public SimpleObjectModel suscribe(FuncionarioModel model) {
        try {
            Session session = em.unwrap(Session.class);
            log.info("mail: " + model.getEmail());
            session.createSQLQuery("CALL insert_suscripcion_email_config(:idFuncionario, :email, :nom, :ap1, :ap2)")
                    .setParameter("idFuncionario", model.getId())
                    .setParameter("email", model.getEmail())
                    .setParameter("nom", model.getNombres())
                    .setParameter("ap1", model.getApellido1())
                    .setParameter("ap2", model.getApellido2())
                    .executeUpdate();
            List<MailProperties> mailProp = session.createSQLQuery("CALL viajes_claros.obten_mail_server()")
                .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            MailProperties model = new MailProperties();
                            model.setId(((Integer) tuple[0]));
                            model.setHost(((String) tuple[1]));
                            model.setPuerto(((String) tuple[2]));
                            model.setUsuario(((String) tuple[3]));
                            model.setContra(((String) tuple[4]));
                            return model;
                        }
                    })
                    .list();
            
            session.flush();
            session.clear();
            
            Properties props = new Properties();
            props.put("mail.smtp.host", mailProp.get(0).getHost());
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", mailProp.get(0).getPuerto());

            final String username = mailProp.get(0).getUsuario();
            final String pass = mailProp.get(0).getContra();
            
            log.debug(props.propertyNames());
                
	    javax.mail.Session mailSession = javax.mail.Session.getInstance(props,
		  new javax.mail.Authenticator() {
                        @Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, pass);
			}
		  });

		try {

			Message message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(model.getEmail()));
			message.setSubject("Suscripción a Viajes Claros");
			message.setText("Estimado usuario: "
				+ "\n\n Se ha realizado exitosamente la suscripción al funcionario : " + 
                                model.getNombres() + " " +model.getApellido1() + " " + model.getApellido2() + ".\n");
                                    
                        
			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			log.error("ERROR AL INTENTAR ENVIAR EL CORREO DE SUSCRIPCIÓN",e);
			//System.out.println("****** Sent message horribly.... " + e.getMessage());
			throw new RuntimeException(e);
		}
            
        } catch(Exception e) {
            log.error("ERROR AL REALIZAR LA SUSCRIPCIÓN", e);
        }
        return new SimpleObjectModel();
    }
}
