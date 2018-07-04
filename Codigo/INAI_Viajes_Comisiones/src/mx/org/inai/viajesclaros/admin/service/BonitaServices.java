package mx.org.inai.viajesclaros.admin.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import org.bonitasoft.engine.bpm.contract.ContractViolationException;
import org.bonitasoft.engine.bpm.flownode.FlowNodeExecutionException;
import org.bonitasoft.engine.bpm.flownode.HumanTaskInstance;
import org.bonitasoft.engine.bpm.flownode.UserTaskNotFoundException;
import org.bonitasoft.engine.bpm.process.ProcessDeploymentInfo;
import org.bonitasoft.engine.bpm.process.ProcessInstance;
import org.bonitasoft.engine.exception.BonitaHomeNotSetException;
import org.bonitasoft.engine.exception.SearchException;
import org.bonitasoft.engine.exception.ServerAPIException;
import org.bonitasoft.engine.exception.UnknownAPITypeException;
import org.bonitasoft.engine.platform.LoginException;
import org.bonitasoft.engine.platform.UnknownUserException;
import org.bonitasoft.engine.search.SearchResult;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import mx.org.inai.viajesclaros.admin.exception.BonitaBPMException;
import mx.org.inai.viajesclaros.admin.model.BonitaErrorVO;
import mx.org.inai.viajesclaros.admin.model.ComisionVO;
import mx.org.inai.viajesclaros.admin.model.FlujosInstanciasVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.util.SendMail;
import mx.org.inai.viajesclaros.admin.workflows.BonitaProcesosAdmin;
import mx.org.inai.viajesclaros.admin.workflows.WorkflowAsignado;

public class BonitaServices {
	
	public BonitaErrorVO invocaProceso (ProcesoVO flujo, String us, Integer id_comision) {
		BonitaErrorVO error = new BonitaErrorVO();
		UserServices usServ = new UserServices();
		final UsuarioVO usuario = usServ.obtenerUsuario(us);
		boolean existe = false;
		Integer res = 0;
		
		final BonitaProcesosAdmin prAdmin = new BonitaProcesosAdmin();
		SearchResult<ProcessDeploymentInfo> procesos;
		ProcessInstance instance = null;
		
		try {
			procesos = prAdmin.obtenerProcesosActivos(prAdmin.bonitaSession(usuario.getUsuario(), usuario.getContra()));
		
			ProcessDeploymentInfo proceso = null;
			
			for (int i = 0 ; i < procesos.getResult().size(); i++) {
				proceso = procesos.getResult().get(i);
				
				if (proceso.getName().equals(flujo.getNombre())) {
					existe = true;
					break;
				}
			}
			
			if (existe) {
				Map<String, Serializable> atributos = new HashMap<String, Serializable>();
				if (flujo.getId() == 1) {
					atributos.put("id_comision", id_comision.toString());
				} else {
					atributos.put("id_comision", new Integer(id_comision));
				}
				
				instance = prAdmin.crearInstancia(proceso.getName(), flujo.getVersion(), atributos, prAdmin.bonitaSession(usuario.getUsuario(), usuario.getContra()));
				
				ComisionVO comInst = new ComisionVO();
				comInst.setId(id_comision);
				
				FlujosInstanciasVO flujoInst = new FlujosInstanciasVO();
				flujoInst.setInstancia(instance.getRootProcessInstanceId());
				flujoInst.setFlujo(flujo);
				flujoInst.setComision(comInst);
				
				res = insertaInstancia(flujoInst);
				
				if (res == 0) {
					error.setCodigo(0);
					error.setMensaje("Solicitud enviada correctamente.");
					
					Timer timer = new Timer();
					
					final ProcessInstance instanceCrono = instance;
					final ProcessDeploymentInfo procesoCrono = proceso;
					final ProcesoVO flujoCrono = flujo;
					final WorkflowAsignado wfAsignado = new WorkflowAsignado();
					final ComisionVO comInstCrono = comInst;
					
					TimerTask cronograma = new TimerTask() {
						@Override
				        public void run() {
							try {
								wfAsignado.setAsignado(prAdmin.asignarNotificaciones(flujoCrono, procesoCrono.getName(), prAdmin.bonitaSession(usuario.getUsuario(),
																					 usuario.getContra()), instanceCrono, comInstCrono, usuario));
								
							} catch (UnknownUserException e) {
								e.printStackTrace();
							} catch (BonitaHomeNotSetException e) {
								e.printStackTrace();
							} catch (ServerAPIException e) {
								e.printStackTrace();
							} catch (UnknownAPITypeException e) {
								e.printStackTrace();
							} catch (LoginException e) {
								e.printStackTrace();
							}
						}
					};
					
					timer.schedule(cronograma, 10, 3000);
					
					while (!wfAsignado.isAsignado()) {
						//System.out.println("********* Asignacion1: " + wfAsignado.isAsignado());
						System.out.print("");
					};
					cronograma.cancel();
					timer.cancel();
					timer.purge();
					
					flujoInst.setAsignado(true);
					res = actualizaInstancia(flujoInst);
					
				}
			} else {
				throw new BonitaBPMException(20, "Bonita BPM: Error en en el flujo de aprobaci&oacute;n seleccionado - " + flujo.getNombre());
			}
			
		} catch (BonitaHomeNotSetException | ServerAPIException
				| UnknownAPITypeException | SearchException | LoginException e) {
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error en la busqueda de flujos de aprobaci&oacute;n - " + e.getMessage());
		} catch (BonitaBPMException e) {
			error.setCodigo(e.getCodigo());
			error.setMensaje(e.getMensaje());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("********* Excepcion de correo" + e.getMessage());
		}
		
		return error;
	}
	
	public BonitaErrorVO respondeNotificacion (FlujosInstanciasVO instancia, long taskId, String us, boolean respuesta, String comentarios) {
		BonitaErrorVO error = new BonitaErrorVO();
		UserServices usServ = new UserServices();
		UsuarioVO usuario = usServ.obtenerUsuario(us);
		BonitaProcesosAdmin prAdmin = new BonitaProcesosAdmin();
		String estado = null;
		ComisionServices comServ;
		
		try {
			prAdmin.responderNotificacion(prAdmin.bonitaSession(usuario.getUsuario(), usuario.getContra()), usuario.getIdBonita(), taskId, respuesta);
			insertaBitacora(instancia, usuario, respuesta, comentarios);
			
			switch (instancia.getFlujo().getId()) {
			case 1: {
				if (respuesta) {
					estado = "A";
				} else {
					estado = "R";
				}
				break;
			}
			case 2: {
				if (respuesta) {
					estado = "F";
				} else {
					estado = "RV";
				}
				break;
			}
			case 3: {
				if (respuesta) {
					estado = "CM";
				} else {
					estado = "RG";
				}
				break;
			}
			case 4: {
				if (respuesta) {
					estado = "P";
				} else {
					estado = "RP";
				}
				break;
			}
			}
			
			if (estado != null) {
				comServ = new ComisionServices();
				comServ.actualizaComision(instancia.getComision().getId(), estado);
				
				if (estado.equals("P")) {
					comServ.publicaViaje(instancia.getComision().getId(), instancia.getComision().getDependencia().getId());
				}
			}
			
			error.setCodigo(0);
			error.setMensaje("Notificaci&oacute;n respondida.");
			
		} catch (UserTaskNotFoundException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (FlowNodeExecutionException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (UnknownUserException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (BonitaHomeNotSetException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (ServerAPIException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (UnknownAPITypeException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (ContractViolationException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		} catch (LoginException e) {
			e.printStackTrace();
			error.setCodigo(10);
			error.setMensaje("Bonita BPM: Error al responder la notificaci&oacute;n - " + e.getMessage());
		}
		
		return error;
		
	}
	
	private void insertaBitacora(FlujosInstanciasVO instancia, UsuarioVO usuario, boolean respuesta, String comentarios) {
		Integer res = 0;
		
		String resp = (respuesta ? "Aprobado: " : "Rechazado: ") + comentarios;
		Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_bitacora(:inst,:flujo,:com,:func,:resp)");
    	query.setLong("inst", instancia.getInstancia());
    	query.setInteger("flujo", instancia.getFlujo().getId());
    	query.setInteger("com", instancia.getComision().getId());
		query.setInteger("func", usuario.getPersona().getId());
		query.setString("resp", resp);
    	
		res = (Integer)query.uniqueResult();
    	
    	session.close();
	}
	
	private Integer insertaInstancia(FlujosInstanciasVO instancia) {
		Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_instancia(:fluj,:inst,:com)");
		query.setInteger("fluj", instancia.getFlujo().getId());
		query.setLong("inst", instancia.getInstancia());
		query.setInteger("com", instancia.getComision().getId());
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
	
	private Integer actualizaInstancia(FlujosInstanciasVO instancia) {
		Integer res = 0;
    	
    	Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_instancia(:fluj,:inst,:com,:fin,:asig)");
		query.setInteger("fluj", instancia.getFlujo().getId());
		query.setLong("inst", instancia.getInstancia());
		query.setInteger("com", instancia.getComision().getId());
		query.setBoolean("asig", instancia.getAsignado());
		if (instancia.getAsignado()) {
			query.setBoolean("fin", false);
		} else {
			query.setBoolean("fin", true);
		}
    	
    	res = (Integer)query.uniqueResult();
    	
    	session.close();
    	
    	return res;
	}
	
	public FlujosInstanciasVO obtenerInstancia(long instanceId) {
		FlujosInstanciasVO vo = new FlujosInstanciasVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_instancia(:id)");
		query.addEntity(FlujosInstanciasVO.class);
		query.setLong("id", instanceId);
						
		List<FlujosInstanciasVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (FlujosInstanciasVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
	
	public List<NotificacionVO> obtenerTareasPendientes (UsuarioVO usuario) {
		BonitaProcesosAdmin prAdmin = new BonitaProcesosAdmin();
		
		List<HumanTaskInstance> tareas = new ArrayList<HumanTaskInstance>();
		ArrayList<NotificacionVO> notificaciones = new ArrayList<NotificacionVO>();
		UserServices usServ = new UserServices();
		
		try {
			tareas = prAdmin.obtenerTareasPendientes(prAdmin.bonitaSession(usuario.getUsuario(), usuario.getContra()), usuario);
			
			for (HumanTaskInstance tarea : tareas) {
				NotificacionVO notificacion = new NotificacionVO();
				
				/*System.out.println("***** Notificacion: " + tarea.getAssigneeId() + " - " + tarea.getName() + " - " + tarea.getDisplayName() +
								   " - " + tarea.getActorId() + " - " + tarea.getParentProcessInstanceId() + " - " + tarea.getReachedStateDate() +
								   " - " + tarea.getLastUpdateDate());*/
				
				notificacion.setId(tarea.getId());
				notificacion.setDisplay(tarea.getDisplayName());
				notificacion.setInstanceId(obtenerInstancia(tarea.getParentProcessInstanceId()));
				notificacion.setActor(usServ.obtenerUsuario(obtenerInstancia(tarea.getParentProcessInstanceId()).getComision().getUsuario().getIdBonita()));
				notificacion.setLastUpdateDate(tarea.getLastUpdateDate());
				
				notificaciones.add(notificacion);
			}
			
		} catch (UnknownUserException e) {
			e.printStackTrace();
		} catch (BonitaHomeNotSetException e) {
			e.printStackTrace();
		} catch (ServerAPIException e) {
			e.printStackTrace();
		} catch (UnknownAPITypeException e) {
			e.printStackTrace();
		} catch (LoginException e) {
			e.printStackTrace();
		}
		
		return notificaciones;
	}
}
