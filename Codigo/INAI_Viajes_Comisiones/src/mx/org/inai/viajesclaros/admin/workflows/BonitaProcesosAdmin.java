package mx.org.inai.viajesclaros.admin.workflows;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mx.org.inai.viajesclaros.admin.model.ComisionVO;
import mx.org.inai.viajesclaros.admin.model.GrupoAprobacionVO;
import mx.org.inai.viajesclaros.admin.model.JerarMiembroVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.ComisionServices;
import mx.org.inai.viajesclaros.admin.service.GrupoAprobacionService;
import mx.org.inai.viajesclaros.admin.service.MiembroServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;
import mx.org.inai.viajesclaros.admin.util.SendMail;

import org.bonitasoft.engine.api.ProcessAPI;
import org.bonitasoft.engine.api.TenantAPIAccessor;
import org.bonitasoft.engine.bpm.contract.ContractViolationException;
import org.bonitasoft.engine.bpm.flownode.ActivityInstanceCriterion;
import org.bonitasoft.engine.bpm.flownode.FlowNodeExecutionException;
import org.bonitasoft.engine.bpm.flownode.HumanTaskInstance;
import org.bonitasoft.engine.bpm.flownode.UserTaskNotFoundException;
import org.bonitasoft.engine.bpm.process.ProcessDeploymentInfo;
import org.bonitasoft.engine.bpm.process.ProcessDeploymentInfoSearchDescriptor;
import org.bonitasoft.engine.bpm.process.ProcessInstance;
import org.bonitasoft.engine.exception.BonitaHomeNotSetException;
import org.bonitasoft.engine.exception.SearchException;
import org.bonitasoft.engine.exception.ServerAPIException;
import org.bonitasoft.engine.exception.UnknownAPITypeException;
import org.bonitasoft.engine.exception.UpdateException;
//import org.bonitasoft.engine.identity.User;
//import org.bonitasoft.engine.identity.UserCriterion;
import org.bonitasoft.engine.search.Order;
import org.bonitasoft.engine.search.SearchOptions;
import org.bonitasoft.engine.search.SearchOptionsBuilder;
import org.bonitasoft.engine.search.SearchResult;
import org.bonitasoft.engine.session.APISession;

public class BonitaProcesosAdmin extends BonitaAmbienteAdmin{
	
	public BonitaProcesosAdmin() {
		super();
	}

	public SearchResult<ProcessDeploymentInfo> obtenerProcesosActivos(APISession session) throws BonitaHomeNotSetException, ServerAPIException,
																								UnknownAPITypeException, SearchException {
		final ProcessAPI processAPI = TenantAPIAccessor.getProcessAPI(session);
		final SearchOptions searchOptions = new SearchOptionsBuilder(0, 100).sort(ProcessDeploymentInfoSearchDescriptor.DEPLOYMENT_DATE, Order.DESC).done();
		final SearchResult<ProcessDeploymentInfo> deploymentInfoResults = processAPI.searchProcessDeploymentInfos(searchOptions);
		
		return deploymentInfoResults;
	}
	
	public ProcessInstance crearInstancia(String processDefinitionName, String processVersion, Map<String, Serializable> variables, 
	        					APISession apiSession) {
		ProcessInstance instance = null;
		try {
	    	ProcessAPI processAPI = TenantAPIAccessor.getProcessAPI(apiSession);
	        long processId = processAPI.getProcessDefinitionId(processDefinitionName, processVersion);
	        instance = processAPI.startProcessWithInputs(processId, variables);
	        
		} catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return instance;
	
	}
	
	public boolean asignarNotificaciones(ProcesoVO flujo, String processDefinitionName, APISession apiSession,
										 ProcessInstance instance, ComisionVO comInst, UsuarioVO usuario) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException {
		int startIndex = 0;
	    int page = 1;
	    final int PAGE_SIZE = 30;
		List<HumanTaskInstance> pendingTasks = null;
		boolean result = false;
		long tarea = 0;
		//long userId = 0;
		ProcessAPI processAPI = TenantAPIAccessor.getProcessAPI(apiSession);
		ComisionServices comServ;
		GrupoAprobacionService grpServ;
		MiembroServices miemServ;
		UserServices userServ;
		int nacional = 0;
		
	    do {
	    	// get the current page
	        pendingTasks = processAPI.getPendingHumanTaskInstances(apiSession.getUserId(), startIndex, PAGE_SIZE, ActivityInstanceCriterion.LAST_UPDATE_ASC);
	        // print the current page
	        tarea = buscaTarea(page, pendingTasks, instance);
	        
	        if (tarea > 0) {
	        	// Siempre se regresa true para no congelar la pantalla
	        	result = true;
	        	
	        	comServ = new ComisionServices();
	        	grpServ = new GrupoAprobacionService();
	        	miemServ = new MiembroServices();
	        	userServ = new UserServices();
	        	
	        	try {
	        	
		        	switch (flujo.getId()) {
		        	case 1: {
		        		nacional = comServ.esComisionNacional(comInst.getId());
		        		// Es nacional
		        		if (nacional > 0) {
		        			// El comisionado es su autorizador
		        			if (usuario.getPersona().getTipoPersona().getDescripcion().equals("Comisionado")) {
		        				processAPI.assignUserTask(tarea, usuario.getIdBonita());
		        				SendMail.email(usuario.getPersona().getEmail(), flujo, instance);
		        			
		        			} else if (usuario.getJefeArea()) { // Es jefe area
		        				// Autoriza presidencia
		        				GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("Presidencia",flujo);
		        				
		        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
		        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
			        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
		        				}
		        			} else { // Es cualquier otro funcionario
		        				// Autoriza Jefe Area
		        				GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion(flujo, usuario.getDependencia(), usuario.getArea());
		        				
		        				// No hay grupo de aprobacion, intenta con calculo de empleados
		        				if (grpVO == null) {
		        					UsuarioVO jefe = userServ.obtenerUsuario(usuario.getDependencia(), usuario.getArea());
		        					
		        					if (jefe != null) {
		        						processAPI.assignUserTask(tarea, jefe.getIdBonita());
				        				SendMail.email(jefe.getPersona().getEmail(), flujo, instance);
		        					}
		        					
		        				} else { // Se toma la jerarquia para aprobar
		        					for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
			        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
				        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
			        				}
		        				}
		        			}
		        		} else { // Es internacional
		        			// El pleno autoriza
		        			if (usuario.getPersona().getTipoPersona().getDescripcion().equals("Comisionado")) {
		        				GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("Pleno",flujo);
		        				
		        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
		        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
			        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
		        				}
		        			} else if (usuario.getJefeArea()) { // Es jefe area
		        				// Autoriza presidencia
		        				GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("Presidencia",flujo);
		        				
		        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
		        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
			        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
		        				}
		        			} else { // Es cualquier otro funcionario
		        				// Autoriza Jefe Area
		        				GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion(flujo, usuario.getDependencia(), usuario.getArea());
		        				
		        				// No hay grupo de aprobacion, intenta con calculo de empleados
		        				if (grpVO == null) {
		        					UsuarioVO jefe = userServ.obtenerUsuario(usuario.getDependencia(), usuario.getArea());
		        					
		        					if (jefe != null) {
		        						processAPI.assignUserTask(tarea, jefe.getIdBonita());
				        				SendMail.email(jefe.getPersona().getEmail(), flujo, instance);
		        					}
		        					
		        				} else { // Se toma la jerarquia para aprobar
		        					for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
			        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
				        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
			        				}
		        				}
		        			}
		        		}
		        		break;
		        	}
		        	case 2: {
		        		GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("DGA",flujo);
        				
        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
	        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
        				}
        				
		        		break;
		        	}
		        	case 3: {
		        		GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("DGA",flujo);
        				
        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
	        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
        				}
		        		
		        		break;
		        	}
		        	case 4: {
		        		GrupoAprobacionVO grpVO = grpServ.obtenerGrupoAprobacion("DGA",flujo);
        				
        				for (JerarMiembroVO miembro : miemServ.obtenerMiembros(grpVO.getJerarquia())) {
        					processAPI.assignUserTask(tarea, miembro.getUsuario().getIdBonita());
	        				SendMail.email(miembro.getUsuario().getPersona().getEmail(), flujo, instance);
        				}
        				
		        		break;
		        	}
		        	}
	        	} catch (UpdateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	/*List<User> users;
				try {
					users = TenantAPIAccessor.getIdentityAPI(apiSession).getUsers(0, 200, UserCriterion.FIRST_NAME_ASC);
					for(User u:users) {
						System.out.println("User_name: " + u.getUserName() + ", Id: " + u.getId());
						if (u.getId() == 101) {
							userId = u.getId();
							processAPI.assignUserTask(tarea, userId);
							SendMail.email("mikengel19@gmail.com", flujo, instance);
							//if (usuario.g)
						}
		        	}
						
				} catch (BonitaHomeNotSetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ServerAPIException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (UnknownAPITypeException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (UpdateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
	        }

	        // got to next page
	        startIndex += PAGE_SIZE;
	        page++;
	    } while (pendingTasks.size() == PAGE_SIZE);
	    
	    System.out.println("********* Asignacion: " + result);
	    return result;
	}
	
	public List<HumanTaskInstance> obtenerTareasPendientes (APISession apiSession, UsuarioVO usuario) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException {
		ProcessAPI processAPI = TenantAPIAccessor.getProcessAPI(apiSession);
		int startIndex = 0;
	    //int page = 1;
	    final int PAGE_SIZE = 30;
		List<HumanTaskInstance> pendingTasks = null;
		List<HumanTaskInstance> tareas = new ArrayList<HumanTaskInstance>();
		
		do {
	    	// get the current page
	        pendingTasks = processAPI.getAssignedHumanTaskInstances(apiSession.getUserId(), startIndex, PAGE_SIZE, ActivityInstanceCriterion.LAST_UPDATE_DESC);
	        
	        for (HumanTaskInstance task : pendingTasks) {
				if (task.getAssigneeId() == usuario.getIdBonita()) {
					tareas.add(task);
				}
			}
	        
	        // got to next page
	        startIndex += PAGE_SIZE;
	        //page++;
	    } while (pendingTasks.size() == PAGE_SIZE);
		
		return pendingTasks;
	}
	
	private long buscaTarea(int pagina, List<HumanTaskInstance> pendingTasks, ProcessInstance instance) {
		long result = 0;
		//System.out.println("*** Pendientes : " + pendingTasks.size());
		for (HumanTaskInstance task : pendingTasks) {
			if (task.getParentProcessInstanceId() == instance.getRootProcessInstanceId()) {
				result = task.getId();
			}
			/*System.out.println("Task_id: " + task.getId() + ", Name: " + task.getDisplayName() +
							   ", Parent: " + task.getParentProcessInstanceId() + " = " + instance.getRootProcessInstanceId());*/
		}
		return result;
	}
	
	public void responderNotificacion (APISession apiSession, long userId, long taskId, boolean respuesta) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException, UserTaskNotFoundException, FlowNodeExecutionException, ContractViolationException {
		final ProcessAPI processAPI = TenantAPIAccessor.getProcessAPI(apiSession);
		Map<String, Serializable> atributos = new HashMap<String, Serializable>();
		atributos.put("aprobado", respuesta);
		processAPI.executeUserTask(userId, taskId, atributos);
		
	}
}
