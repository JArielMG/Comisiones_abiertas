/*
 * Copyright (C) 2016 victor.huerta
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
package mx.org.inai.viajesclaros.admin.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import static mx.org.inai.viajesclaros.admin.ejb.GastosService.log;
import mx.org.inai.viajesclaros.domain.CamposGastosDomain;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

/**
 *
 * @author victor.huerta
 */
@Stateless
public class GastosService {
    
    @PersistenceContext(unitName = "viajesclaros-PU")
    private EntityManager em;

    final static Logger log = Logger.getLogger(GastosService.class);
    
    /**
     * Guarda un campo de parametrización de las pantallas de flujos
     * @param campoGastoDomain
     * @throws Exception 
     */
    public void saveGastoCampoConfig(CamposGastosDomain campoGastoDomain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL insert_gastos_campos_config(:tabla, :campo, :etiqueta, "
                    + ":listaHabilitada, :obligatorio, :orden, :subtipo)")
                    .setParameter("tabla", campoGastoDomain.getTabla())
                    .setParameter("campo", campoGastoDomain.getCampo())
                    .setParameter("etiqueta", campoGastoDomain.getEtiqueta())
                    .setParameter("listaHabilitada", campoGastoDomain.getListaHabilitada())
                    .setParameter("obligatorio", campoGastoDomain.getObligatorio())
                    .setParameter("orden", campoGastoDomain.getOrden())                    
                    .setParameter("subtipo", campoGastoDomain.getSubtipo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL GUARDAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Elimina un campo de la tabla flujos_campos_config
     * @param campoGastoDomain
     * @throws Exception 
     */
    public void deleteGastoCampoConfig(CamposGastosDomain campoGastoDomain) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL delete_gasto_campo_config(:idGastoCampoConfig)")
                    .setParameter("idGastoCampoConfig", campoGastoDomain.getIdGastoCampoConfig())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ELIMINAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    public void updateGastoCampoConfig(CamposGastosDomain campo) throws Exception {
        try {
            Session session = em.unwrap(Session.class);
            session.createSQLQuery("CALL update_gastos_campos_config(:idGastoCampoConfig, :tabla, "
                    + ":campo, :etiqueta, :listaHab, :obligatorio, :orden, :subtipo)")
                    .setParameter("idGastoCampoConfig", campo.getIdGastoCampoConfig())
                    .setParameter("tabla", campo.getTabla())
                    .setParameter("campo", campo.getCampo())
                    .setParameter("etiqueta", campo.getEtiqueta())
                    .setParameter("listaHab", campo.getListaHabilitada())
                    .setParameter("obligatorio", campo.getObligatorio())
                    .setParameter("orden", campo.getOrden())
                    .setParameter("subtipo", campo.getSubtipo())
                    .executeUpdate();
            
            session.flush();
            session.clear();
        } catch(Exception e) {
            log.error("ERROR AL ACTUALIZAR EL CAMPO DE FLUJOS DE TRABAJO", e);
            throw new Exception(e.getMessage());
        }
    }
    
    /**
     * Obtiene los campos del flujo y de la categoría indicados
     * @param categoria
     * @return
     * @throws Exception 
     */
    public List<CamposGastosDomain> getGastosCamposConfig() throws Exception {
        Session session = em.unwrap(Session.class);
        List<CamposGastosDomain> campos = session.createSQLQuery("CALL get_gastos_campos_config_edit()")
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        CamposGastosDomain campoDomain = new CamposGastosDomain();
                        campoDomain.setIdGastoCampoConfig((Integer) tuple[0]);
                        campoDomain.setTabla((String) tuple[1]);
                        campoDomain.setCampo((String) tuple[2]);
                        campoDomain.setEtiqueta((String) tuple[3]);
                        campoDomain.setListaHabilitada((Boolean) tuple[4]);
                        Boolean b = (Byte) tuple[5] != 0;
                        campoDomain.setObligatorio(b);
                        campoDomain.setOrden((Integer) tuple[6]);
                        campoDomain.setIdLista((Integer) tuple[7]);
                        campoDomain.setTipoControl((String) tuple[8]);
                        campoDomain.setTipoDato((String) tuple[9]);
                        campoDomain.setSubtipo((String) tuple[10]);
                        return campoDomain;
                    }
                })
                .list();
       
        session.flush();
        session.clear();
        return campos;
    }
    
}
