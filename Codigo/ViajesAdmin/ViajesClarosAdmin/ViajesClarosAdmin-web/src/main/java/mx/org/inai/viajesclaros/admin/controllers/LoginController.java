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
package mx.org.inai.viajesclaros.admin.controllers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;

/**
 *
 * @author Sandro Alejandro
 */
@ManagedBean
@ViewScoped
public class LoginController {
    final static Logger log = Logger.getLogger(LoginController.class);
    
    /* Cuando el usuario accede al login y su sesión está abierta, redireccionar al buscador*/
    public void terminate() {
        try {
            FacesContext fc = FacesContext.getCurrentInstance();
            ExternalContext context = fc.getExternalContext();
            if (SecurityUtils.getSubject().isAuthenticated()) {
                context.redirect(context.getRequestContextPath() + "/filtros/filtros.xhtml");
            }
        } catch(Exception e) {
            log.error("Error al terminar la sesión, probablemente aún no existe.", e);
        }
    }
    
}
