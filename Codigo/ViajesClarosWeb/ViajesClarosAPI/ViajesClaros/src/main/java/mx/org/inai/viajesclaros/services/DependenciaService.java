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

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import mx.org.inai.viajesclaros.entities.CatDependencia;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author Sandro Alejandro
 */
@Stateless
public class DependenciaService {
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(DependenciaService.class);
    
    public List<CatDependencia> findAll() {
        Session session = em.unwrap(Session.class);
        
        List<CatDependencia> dependencias = session.createSQLQuery("CALL get_dependencias()")
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        CatDependencia catDependencia = new CatDependencia();
                        catDependencia.setIdDependencia((Integer) tuple[0]);
                        catDependencia.setDependecia((String) tuple[1]);
                        catDependencia.setSiglas((String) tuple[2]);

                        return catDependencia;
                    }
                })
                .list();
        
        session.flush();
        session.clear();
        
        return dependencias;
    }
}
