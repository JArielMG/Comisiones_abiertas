package mx.org.inai.viajesclaros.admin.workflows;

import mx.org.inai.viajesclaros.admin.model.UsuarioVO;

import org.bonitasoft.engine.api.IdentityAPI;
import org.bonitasoft.engine.api.TenantAPIAccessor;
import org.bonitasoft.engine.exception.AlreadyExistsException;
import org.bonitasoft.engine.exception.BonitaHomeNotSetException;
import org.bonitasoft.engine.exception.CreationException;
import org.bonitasoft.engine.exception.DeletionException;
import org.bonitasoft.engine.exception.SearchException;
import org.bonitasoft.engine.exception.ServerAPIException;
import org.bonitasoft.engine.exception.UnknownAPITypeException;
import org.bonitasoft.engine.exception.UpdateException;
import org.bonitasoft.engine.identity.ContactDataCreator;
import org.bonitasoft.engine.identity.Group;
import org.bonitasoft.engine.identity.GroupSearchDescriptor;
import org.bonitasoft.engine.identity.Role;
import org.bonitasoft.engine.identity.RoleSearchDescriptor;
import org.bonitasoft.engine.identity.User;
import org.bonitasoft.engine.identity.UserCreator;
import org.bonitasoft.engine.identity.UserNotFoundException;
import org.bonitasoft.engine.identity.UserUpdater;
import org.bonitasoft.engine.profile.Profile;
import org.bonitasoft.engine.profile.ProfileMemberCreator;
import org.bonitasoft.engine.profile.ProfileSearchDescriptor;
import org.bonitasoft.engine.search.SearchOptionsBuilder;
import org.bonitasoft.engine.search.SearchResult;
import org.bonitasoft.engine.session.APISession;

public class BonitaUsuariosAdmin extends BonitaAmbienteAdmin{

	public BonitaUsuariosAdmin() {
		super();
	}

	public User crearUsuario(APISession session, UsuarioVO usuario) throws AlreadyExistsException, CreationException, BonitaHomeNotSetException,
																			ServerAPIException, UnknownAPITypeException {
		final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(session);
		// create complex user 
		UserCreator creator = new UserCreator(usuario.getUsuario(), usuario.getContra());
		creator.setFirstName(usuario.getPersona().getNombres());
		creator.setLastName(usuario.getPersona().getApellidoPaterno() + " " + usuario.getPersona().getApellidoMaterno());
		creator.setTitle(usuario.getPersona().getTitulo());
		ContactDataCreator proContactDataCreator = new ContactDataCreator().setEmail(usuario.getPersona().getEmail());
		creator.setProfessionalContactData(proContactDataCreator);
		final User user = identityAPI.createUser(creator);
		
		return user;
	}
	
	public User actualizaUsuario(APISession session, UsuarioVO usuario) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException, UserNotFoundException, UpdateException {
		final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(session);
		UserUpdater updater = new UserUpdater();
		updater.setUserName(usuario.getUsuario());
		updater.setPassword(usuario.getContra());
		
		final User user = identityAPI.updateUser(usuario.getIdBonita(), updater);
		
		return user;
	}
	
	public void asignarPerfil(APISession session, String perfil, User usuario) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException,
																					SearchException, AlreadyExistsException, CreationException {
		org.bonitasoft.engine.api.ProfileAPI orgProfileAPI = TenantAPIAccessor.getProfileAPI(session);
		SearchOptionsBuilder searchOptionsBuilder = new SearchOptionsBuilder(0,10);
		searchOptionsBuilder.filter(ProfileSearchDescriptor.NAME, perfil);
		SearchResult<Profile> searchResultProfile = orgProfileAPI.searchProfiles(searchOptionsBuilder.done());
		    
		// we should find one result now
		if (searchResultProfile.getResult().size()!=1)
		        { return; }

		// now register the user in the profile
		Profile profile = searchResultProfile.getResult().get(0);
		ProfileMemberCreator profileMemberCreator = new ProfileMemberCreator( profile.getId());
		profileMemberCreator.setUserId( usuario.getId());
		orgProfileAPI.createProfileMember(profileMemberCreator);
	}
	
	public Group obtenerGrupo(APISession session, String grupo) throws BonitaHomeNotSetException, ServerAPIException,
																	UnknownAPITypeException, SearchException {
		// Groups
		final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(session);
		SearchOptionsBuilder searchOptionsBuilder = new SearchOptionsBuilder(0,10);
		searchOptionsBuilder.filter(GroupSearchDescriptor.NAME, grupo);
		SearchResult<Group> groupResults = identityAPI.searchGroups(searchOptionsBuilder.done());
		
		// we should find one result now
		if (groupResults.getResult().size()!=1)
		        { return null; }

		// now register the user in the profile
		Group group = groupResults.getResult().get(0);
		
		return group;
	}
	
	public Role obtenerRol(APISession session, String rol) throws BonitaHomeNotSetException, ServerAPIException, UnknownAPITypeException, SearchException {
		//Roles
		final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(session);
		SearchOptionsBuilder searchOptionsBuilder = new SearchOptionsBuilder(0,10);
		searchOptionsBuilder.filter(RoleSearchDescriptor.NAME, rol);
		SearchResult<Role> roleResults = identityAPI.searchRoles(searchOptionsBuilder.done());
		
		// we should find one result now
		if (roleResults.getResult().size()!=1)
		        { return null; }

		// now register the user in the profile
		Role role = roleResults.getResult().get(0);
		
		return role;
	}
	
	public boolean borrarUsuario(APISession session, UsuarioVO usuario) throws BonitaHomeNotSetException, ServerAPIException,
																			UnknownAPITypeException, DeletionException {
		boolean status = false;
		final IdentityAPI identityAPI = TenantAPIAccessor.getIdentityAPI(session);
		identityAPI.deleteUser(usuario.getUsuario());
		status = true;
		
		return status;
	}
}
