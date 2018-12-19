package mx.org.inai.viajesclaros.admin.service;

import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mx.org.inai.viajesclaros.admin.model.AreaVO;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

import mx.org.inai.viajesclaros.admin.model.CamposFormulario;
import mx.org.inai.viajesclaros.admin.model.CatalogoElement;
import mx.org.inai.viajesclaros.admin.model.Comisiones;
import mx.org.inai.viajesclaros.admin.model.ComisionesDetalle;
import mx.org.inai.viajesclaros.admin.model.ComisionesUsuario;
import mx.org.inai.viajesclaros.admin.model.DatosFuncionariosVO;
import mx.org.inai.viajesclaros.admin.model.FlujosComisionesVO;
import mx.org.inai.viajesclaros.admin.model.GastosComision;
import mx.org.inai.viajesclaros.admin.model.ListaGastosComision;
import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.RegistrosGastosComisionVO;
import mx.org.inai.viajesclaros.admin.model.ReporteFlujoComisionCargoVO;
import mx.org.inai.viajesclaros.admin.model.ReporteFlujoComisionVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesFormulario;
import mx.org.inai.viajesclaros.admin.model.TrProgramaPresupuestalVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.util.EstatusComisiones;
import mx.org.inai.viajesclaros.admin.util.TipoControl;

public class FormulariosServices {

    public ArrayList<DatosFuncionariosVO> obtenerDatosFuncionario(String username) {
        ArrayList<DatosFuncionariosVO> data = new ArrayList<DatosFuncionariosVO>();

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_detalle_usuario_por_nombre_usuario(:username)");
        query.addEntity(DatosFuncionariosVO.class);
        query.setString("username", username);

        List<DatosFuncionariosVO> result = query.list();
        for (int i = 0; i < result.size(); i++) {
            DatosFuncionariosVO vo = (DatosFuncionariosVO) result.get(i);
            data.add(vo);
        }

        session.close();
        return data;
    }

    @SuppressWarnings("unchecked")
    public ArrayList<Comisiones> obtenerComisionFuncionario(Integer idComision) {
        ArrayList<Comisiones> data = new ArrayList<Comisiones>();

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_comision_por_id_comision(:idComision)");
        query.addEntity(Comisiones.class);
        query.setInteger("idComision", idComision);

        List<Comisiones> result = query.list();
        for (int i = 0; i < result.size(); i++) {
            Comisiones vo = (Comisiones) result.get(i);
            data.add(vo);
        }

        session.close();

        return data;
    }

    @SuppressWarnings("unchecked")
    public List<String> obtenerAreaAprobador(String usuario, Integer idFlujo) {

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_aprobador_usuario(:usuario,:idFlujo)");
        query.setString("usuario", usuario);
        query.setInteger("idFlujo", idFlujo);

        List<String> result = query.list();
        
        if(result.isEmpty()){
            result.add("0");
        }
        
        session.close();

        return result;
    }

    @SuppressWarnings("unchecked")
    public List<String> obtenerUnidadAdministrativa(String usuario) {

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_unidadAdministrativa_comisionados(:usuario)");
        query.setString("usuario", usuario);

        List<String> result = query.list();

        session.close();

        return result;
    }
    
    public List<String> obtenerTrNombreUa(String cve_ua) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_tr_nombre_ua(:cve_ua)");
        query.setString("cve_ua", cve_ua);
        List<String> result = query.list();
        session.close();
        return result;
    }
    
    public List<String> obtenerTrNombrePp(String cve_pp) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_tr_nombre_pp(:cve_pp)");
        query.setString("cve_pp", cve_pp);
        List<String> result = query.list();
        session.close();
        return result;
    }
    
    public List<String> obtenerTrNombrePe(String cve_pe,String cve_pp, String cve_ua) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_tr_nombre_pe(:cve_pe,:cve_pp,:cve_ua)");
        query.setString("cve_pe", cve_pe);
        query.setString("cve_pp", cve_pp);
        query.setString("cve_ua", cve_ua);
        List<String> result = query.list();
        session.close();
        return result;
    }

    public List<String> obtenerTrNombreAc(String prs,String cve_ua,String cve_pp, String cve_pe) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_tr_nombre_ac(:prs,:cve_ua,:cve_pp,:cve_pe)");
        query.setString("prs", prs);
        query.setString("cve_ua", cve_ua);
        query.setString("cve_pp", cve_pp);
        query.setString("cve_pe", cve_pe);
        List<String> result = query.list();
        session.close();
        return result;
    }
    
    public Integer insertarNuevaComision(String estatus, Integer idDependencia, Integer idPersona, Integer idUsuario) {

        Integer idComision = 0;

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("SELECT viajes_claros.inserta_comision(:estatus,:idDependencia,:idPersona,:idUsuario)");
        query.setString("estatus", estatus);
        query.setInteger("idDependencia", idDependencia);
        query.setInteger("idPersona", idPersona);
        query.setInteger("idUsuario", idUsuario);

        idComision = (Integer) query.uniqueResult();

        session.close();

        return idComision;
    }

    public void actualizaEstatusComision(Integer idComision, String estatus) {

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.update_comision(:idComision,:estatus)");
        query.setInteger("idComision", idComision);
        query.setString("estatus", estatus);

        query.executeUpdate();

        session.close();
    }

    public void insertarActualizarComisionDetalle(Integer idComision, String tabla, String campo, String valorTexto, Double valorNumerico, Date valorFecha, Short tipoDato) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_existe_comision_detalle(:idComision,:tabla,:campo)");
        query.setInteger("idComision", idComision);
        query.setString("tabla", tabla);
        query.setString("campo", campo);

        Object res = query.uniqueResult();

        //Actualiza si el resultado es distinto a nulo
        if (res != null) {
            query = session.createSQLQuery("CALL viajes_claros.update_comision_detalle(:idComision,:tabla,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setString("tabla", tabla);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();

        } else {
            query = session.createSQLQuery("CALL viajes_claros.insert_comisiones_detalle(:idComision,:tabla,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setString("tabla", tabla);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();
        }

        session.close();
    }

    public String obtenerDetalleComision(Integer idComision, String tabla, String campo, Short tipoDato) {
        System.out.println("mx.org.inai.viajesclaros.admin.service.FormulariosServices.obtenerDetalleComision() values idComision :: " + idComision + 
                " value of tabla:: " + tabla + " value of campo:: " + campo + " value of tipoDato:: " + tipoDato);
        String resultado = "";

        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_comision_detalle_id_comision(:idComision,:tabla,:campo,:tipoDato)");
        query.setInteger("idComision", idComision);
        query.setString("tabla", tabla);
        query.setString("campo", campo);
        query.setShort("tipoDato", tipoDato);

        Object res = query.uniqueResult();

        if (res != null) {
            resultado = res.toString();
        }

        session.close();
        
        System.out.println("Resultado :::: " + resultado);
        return resultado;
    }

    @SuppressWarnings("unchecked")
    public List<SeccionesFormulario> getCamposFormulario(Integer idFlujo, Integer idTipoPersona, String tipoRepresentacion) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        List<SeccionesFormulario> seccionesFormulario = session.createSQLQuery("CALL get_secciones_formulario_por_id_flujo(:idFlujo)")
                .setParameter("idFlujo", idFlujo)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        SeccionesFormulario seccionesFormulario = new SeccionesFormulario();

                        seccionesFormulario.setIdSeccion((Integer) tuple[0]);
                        seccionesFormulario.setEtiqueta((String) tuple[1]);
                        seccionesFormulario.setNombreSeccion((String) tuple[2]);
                        seccionesFormulario.setIdFlujo((Integer) tuple[3]);
                        seccionesFormulario.setOrden((Integer) tuple[4]);
                        return seccionesFormulario;
                    }
                })
                .list();

        /* Si el filtro es catálogo, se deben traer los elementos del catálogo */
        for (SeccionesFormulario sf : seccionesFormulario) {
            List<CamposFormulario> camposFormulario = session.createSQLQuery("CALL get_flujos_campos_config_por_flujo_tipo_persona_seccion(:idFlujo,:idTipoPersona,:idSeccionFormulario)")
                    .setParameter("idFlujo", idFlujo)
                    .setParameter("idTipoPersona", idTipoPersona)
                    .setParameter("idSeccionFormulario", sf.getIdSeccion())
                    .setResultTransformer(new BasicTransformerAdapter() {
                        private static final long serialVersionUID = 1L;

                        @Override
                        public Object transformTuple(Object[] tuple, String[] aliases) {
                            CamposFormulario campoFormulario = new CamposFormulario();

                            campoFormulario.setIdFlujo((Integer) tuple[0]);
                            campoFormulario.setTabla((String) tuple[1]);
                            campoFormulario.setCampo((String) tuple[2]);
                            campoFormulario.setEtiqueta((String) tuple[3]);
                            campoFormulario.setListaHabilitada((Boolean) tuple[4]);
                            campoFormulario.setIdSeccionFormulario((Integer) tuple[5]);
                            campoFormulario.setObligatorio((Byte) tuple[6]);
                            campoFormulario.setOrden((Integer) tuple[7]);
                            campoFormulario.setIdLista((Integer) tuple[8]);
                            campoFormulario.setTipoControl((String) tuple[9]);
                            campoFormulario.setTipoDato((String) tuple[10]);
                            campoFormulario.setSubtipo((String) tuple[11]);
                            campoFormulario.setSoloLectura((Boolean) tuple[12]);
                            campoFormulario.setClase((String) tuple[13]);
                            return campoFormulario;
                        }
                    })
                    .list();
            for (CamposFormulario cf : camposFormulario) {
                cf.setCatalogo(new ArrayList());

                if (cf.getTipoControl().equals(TipoControl.LISTA) && !cf.getTabla().equals("")) {
                    String campo = "";
                    if (cf.getTabla().equals("paises") && (cf.getCampo().equals("pais_destino") || cf.getCampo().equals("pais_origen"))) {
                        campo = "nombre_pais";
                    } else if (cf.getTabla().equals("estados") && (cf.getCampo().equals("estado_destino") || cf.getCampo().equals("estado_origen"))) {
                        campo = "nombre_estado";
                    } else if (cf.getTabla().equals("ciudades") && (cf.getCampo().equals("ciudad_destino") || cf.getCampo().equals("ciudad_origen"))) {
                        campo = "nombre_ciudad";
                    } else {
                        campo = cf.getCampo();
                    }

                    System.out.println("Campo: " + campo);
                    List<CatalogoElement> cat = session.createSQLQuery("CALL get_catalogo_tabla_campo(:tabla, :campo)")
                            .setParameter("tabla", cf.getTabla())
                            .setParameter("campo", campo)
                            .setResultTransformer(new BasicTransformerAdapter() {
                                private static final long serialVersionUID = 1L;

                                @Override
                                public Object transformTuple(Object[] tuple, String[] aliases) {
                                    Integer id = (Integer) tuple[0];
                                    String descripcion = (String) tuple[1];

                                    return new CatalogoElement(id, "", descripcion);
                                }
                            })
                            .list();
                    cf.setCatalogo(cat);
                } else if ((cf.getTipoControl().equals(TipoControl.LISTA) && cf.getListaHabilitada()) || (cf.getTipoControl().equals(TipoControl.LISTA) && !cf.getListaHabilitada()) || (cf.getTipoControl().equals(TipoControl.TEXTO) && cf.getListaHabilitada())) {
                    /* Es un catálogo de campos dinámicos */
 /*if (cf.getCampo().equals("tipo_representacion")){
	            		List<CatalogoElement> catalog = new ArrayList<CatalogoElement>();
	            		CatalogoElement catalogOption = new CatalogoElement();
	            		if (tipoRepresentacion.equals("TEC")){
	            			catalogOption.setCodigo(tipoRepresentacion);
	            			catalogOption.setDescripcion("Técnico");
	            		}else if (tipoRepresentacion.equals("AN")){
	            			catalogOption.setCodigo(tipoRepresentacion);
	            			catalogOption.setDescripcion("Alto Nivel");
	            		} 
	            		catalog.add(catalogOption);

		                cf.setCatalogo(catalog);
	            	}else if (cf.getCampo().equals("homologacion")&&tipoRepresentacion.equals("2")){
	            		List<CatalogoElement> catalog = new ArrayList<CatalogoElement>();
	            		CatalogoElement catalogOption = new CatalogoElement();
	            		catalogOption.setCodigo("NO");
            			catalogOption.setDescripcion("No");
	            		catalog.add(catalogOption);

		                cf.setCatalogo(catalog);
	            	}else{*/
                    if (!cf.getCampo().equals("ua_presupuesto")
                            && !cf.getCampo().equals("ua_presupuesto")
                            && !cf.getCampo().equals("cve_programa_pre")
                            && !cf.getCampo().equals("cve_proyecto_estrategico")
                            && !cf.getCampo().equals("proyecto_actividades")
                            && !cf.getCampo().equals("cve_proyecto_actividades")) {

                        List<CatalogoElement> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                                .setParameter("idLista", cf.getIdLista())
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat);
                    }

                    if (cf.getCampo().equals("ua_presupuesto")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_unidades_administrativas()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }

                    if (cf.getCampo().equals("cve_ua_presupuesto")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_cve_unidades_administrativas()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }

                    if (cf.getCampo().equals("cve_programa_pre")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_cve_pp()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }

                    
                    if (cf.getCampo().equals("proyecto_estrategico")) {
                        List<CatalogoElement> cat_pe = session.createSQLQuery("CALL viajes_claros.obtener_cat_tr_pe()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_pe);
                    }
                    
                    if (cf.getCampo().equals("cve_proyecto_estrategico")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_cve_pe()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }
                    
                    if (cf.getCampo().equals("cve_proyecto_actividades")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_cve_actividades()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }
                    
                    if (cf.getCampo().equals("proyecto_actividades")) {
                        List<CatalogoElement> cat_ua = session.createSQLQuery("CALL viajes_claros.obtener_tr_actividades_todas()")
                                .setResultTransformer(new BasicTransformerAdapter() {
                                    private static final long serialVersionUID = 1L;

                                    @Override
                                    public Object transformTuple(Object[] tuple, String[] aliases) {
                                        Integer id = (Integer) tuple[0];
                                        String codigo = (String) tuple[1];
                                        String descripcion = (String) tuple[2];
                                        return new CatalogoElement(id, codigo, descripcion);
                                    }
                                })
                                .list();
                        cf.setCatalogo(cat_ua);
                    }


                }
            }
            sf.setCamposFormulario(camposFormulario);

        }

        session.close();

        return seccionesFormulario;
    }

    public List<CatalogoElement> getCatalogo(Integer idLista) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<CatalogoElement> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                .setParameter("idLista", idLista)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer id = (Integer) tuple[0];
                        String codigo = (String) tuple[1];
                        String descripcion = (String) tuple[2];
                        return new CatalogoElement(id, codigo, descripcion);
                    }
                })
                .list();

        session.close();
        return cat;
    }

    public List<String> getEncabezadosGastos() {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<String> encabezados = session.createSQLQuery("CALL get_gastos_campos_config_headers()").list();

        session.close();
        return encabezados;
    }

    public List<String> obtenerTarifas() {

        Session session = HibernateUtil.getSessionFactory().openSession();
        @SuppressWarnings("unchecked")
        List<String> tarifas = session.createSQLQuery("CALL obtener_tarifas()").list();

        session.close();
        return tarifas;
    }

    public List<String> obtenerPernocta() {

        Session session = HibernateUtil.getSessionFactory().openSession();
        @SuppressWarnings("unchecked")
        List<String> pernocta = session.createSQLQuery("CALL obtener_pernocta()").list();

        session.close();
        return pernocta;
    }

    public List<ListaGastosComision> getListaGastosComision(Integer idComision) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<ListaGastosComision> cat = session.createSQLQuery("CALL get_comision_desglose_gastos_id_comision(:idComision)")
                .setParameter("idComision", idComision)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Object valor = tuple[0];
                        Integer idRegistroGastoComision = (Integer) tuple[1];
                        return new ListaGastosComision(valor, idRegistroGastoComision);
                    }
                })
                .list();

        session.close();
        return cat;
    }

    @SuppressWarnings("unchecked")
    public List<GastosComision> getCamposGastosComision() {

        Session session = HibernateUtil.getSessionFactory().openSession();

        List<GastosComision> elementosFormulario = session.createSQLQuery("CALL get_gastos_campos_config()")
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        GastosComision camposGastosComision = new GastosComision();

                        camposGastosComision.setCampo((String) tuple[0]);
                        camposGastosComision.setEtiqueta((String) tuple[1]);
                        camposGastosComision.setListaHabilitada((Boolean) tuple[2]);
                        camposGastosComision.setObligatorio((Byte) tuple[3]);
                        camposGastosComision.setOrden((Integer) tuple[4]);
                        camposGastosComision.setIdLista((Integer) tuple[5]);
                        camposGastosComision.setTipoControl((String) tuple[6]);
                        camposGastosComision.setTipoDato((String) tuple[7]);
                        camposGastosComision.setSubtipo((String) tuple[8]);
                        return camposGastosComision;
                    }
                })
                .list();

        /* Si el filtro es catálogo, se deben traer los elementos del catálogo */
        for (GastosComision ef : elementosFormulario) {
            if (ef.getTipoControl().equals(TipoControl.LISTA) && ef.getListaHabilitada()) {
                List<CatalogoElement> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                        .setParameter("idLista", ef.getIdLista())
                        .setResultTransformer(new BasicTransformerAdapter() {
                            private static final long serialVersionUID = 1L;

                            @Override
                            public Object transformTuple(Object[] tuple, String[] aliases) {
                                Integer id = (Integer) tuple[0];
                                String codigo = (String) tuple[1];
                                String descripcion = (String) tuple[2];
                                return new CatalogoElement(id, codigo, descripcion);
                            }
                        })
                        .list();
                ef.setCatalogo(cat);

            }
        }

        session.close();

        return elementosFormulario;
    }

    @SuppressWarnings("unchecked")
    public List<GastosComision> getCamposGastosComision(Integer idRegistro) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        List<GastosComision> elementosFormulario = session.createSQLQuery("CALL get_comision_desglose_gastos_id_registro_gasto(:idRegistro)")
                .setParameter("idRegistro", idRegistro)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        GastosComision camposGastosComision = new GastosComision();
                        camposGastosComision.setIdRegistroGasto((Integer) tuple[0]);
                        camposGastosComision.setCampo((String) tuple[1]);
                        camposGastosComision.setEtiqueta((String) tuple[2]);
                        camposGastosComision.setValorCampo(tuple[3].toString());
                        camposGastosComision.setListaHabilitada((Boolean) tuple[4]);
                        camposGastosComision.setObligatorio((Byte) tuple[5]);
                        camposGastosComision.setOrden((Integer) tuple[6]);
                        camposGastosComision.setIdLista((Integer) tuple[7]);
                        camposGastosComision.setTipoControl((String) tuple[8]);
                        camposGastosComision.setTipoDato((String) tuple[9]);
                        camposGastosComision.setSubtipo((String) tuple[10]);
                        return camposGastosComision;
                    }
                })
                .list();

        /* Si el filtro es catálogo, se deben traer los elementos del catálogo */
        for (GastosComision ef : elementosFormulario) {
            if (ef.getTipoControl().equals(TipoControl.LISTA) && ef.getListaHabilitada()) {
                List<CatalogoElement> cat = session.createSQLQuery("CALL get_valores_dinamicos_por_id(:idLista)")
                        .setParameter("idLista", ef.getIdLista())
                        .setResultTransformer(new BasicTransformerAdapter() {
                            private static final long serialVersionUID = 1L;

                            @Override
                            public Object transformTuple(Object[] tuple, String[] aliases) {
                                Integer id = (Integer) tuple[0];
                                String codigo = (String) tuple[1];
                                String descripcion = (String) tuple[2];
                                return new CatalogoElement(id, codigo, descripcion);
                            }
                        })
                        .list();
                ef.setCatalogo(cat);

            }
        }

        session.close();

        return elementosFormulario;
    }

    public Integer insertarRegistroGastoComision(Integer idComision) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        Integer idRegistroGastoComision = 0;

        SQLQuery query = session.createSQLQuery("SELECT viajes_claros.inserta_registro_gasto_comision(:idComision)");
        query.setInteger("idComision", idComision);

        idRegistroGastoComision = (Integer) query.uniqueResult();

        session.close();

        return idRegistroGastoComision;
    }

    public void insertarActualizarGastoComision(Integer idComision, Integer idRegistroGastoComision, String campo, String valorTexto, Double valorNumerico, Date valorFecha, Short tipoDato) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_desglose_gastos_id_comision(:idComision,:idRegistroGastoComision,:campo,:tipoDato)");
        query.setInteger("idComision", idComision);
        query.setInteger("idRegistroGastoComision", idRegistroGastoComision);
        query.setString("campo", campo);
        query.setShort("tipoDato", tipoDato);

        Object res = query.uniqueResult();

        //Actualiza si el resultado es distinto a nulo
        if (res != null) {
            query = session.createSQLQuery("CALL viajes_claros.update_comision_desglose_gastos(:idComision,:idRegistroGastoComision,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setInteger("idRegistroGastoComision", idRegistroGastoComision);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();

        } else {
            query = session.createSQLQuery("CALL viajes_claros.insert_comisiones_desglose_gastos(:idComision,:idRegistroGastoComision,:campo,:valorTexto,:valorNumerico,:valorFecha)");
            query.setInteger("idComision", idComision);
            query.setInteger("idRegistroGastoComision", idRegistroGastoComision);
            query.setString("campo", campo);
            query.setString("valorTexto", valorTexto);
            query.setDouble("valorNumerico", valorNumerico);
            query.setTimestamp("valorFecha", valorFecha);

            query.executeUpdate();
        }

        session.close();
    }

    public void eliminarRegistroGastosComision(Integer idComision, Integer idRegistroGastosComision) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        SQLQuery query = session.createSQLQuery("CALL delete_registro_gastos_id_comision(:idComision,:idRegistroGastosComision)");
        query.setInteger("idComision", idComision);
        query.setInteger("idRegistroGastosComision", idRegistroGastosComision);
        query.executeUpdate();

        session.close();
    }

    public List<RegistrosGastosComisionVO> obtenerRegistrosGastosIdComision(Integer idComision) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<RegistrosGastosComisionVO> gastosFuncionario = session.createSQLQuery("CALL get_registros_gastos_por_id_comision(:idComision)")
                .setParameter("idComision", idComision)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer idRegistroGasto = (Integer) tuple[0];
                        Double importe = (Double) tuple[1];
                        String concepto = (String) tuple[2];
                        String tipoGasto = (String) tuple[3];
                        String comprobante = (String) tuple[4];
                        return new RegistrosGastosComisionVO(idRegistroGasto, importe, concepto, tipoGasto, comprobante);
                    }
                })
                .list();

        session.close();
        return gastosFuncionario;
    }

    public List<FlujosComisionesVO> obtenerFlujosComision(Integer idPersona) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<FlujosComisionesVO> flujosComision = session.createSQLQuery("CALL get_flujos_comision_reporte(:idPersona)")
                .setParameter("idPersona", idPersona)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer idComision = (Integer) tuple[0];
                        String f1 = (String) tuple[1];
                        String f2 = (String) tuple[2];
                        String f3 = (String) tuple[3];
                        String f4 = (String) tuple[4];
                        return new FlujosComisionesVO(idComision, f1, f2, f3, f4);
                    }
                })
                .list();

        session.close();
        return flujosComision;
    }

    public List<ComisionesUsuario> obtenerComisionesUsuario(Integer idPersona) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<ComisionesUsuario> comisionesUsuarios = session.createSQLQuery("CALL get_comisiones_por_id_usuario(:idPersona)")
                .setParameter("idPersona", idPersona)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer idComision = (Integer) tuple[0];
                        String estatus = regresaEstatusComisionEmpleado((String) tuple[1]);
                        String fechaSalida = (String) tuple[2];
                        String fechaRegreso = (String) tuple[3];
                        String paisDestino = (String) tuple[4];
                        String ciudadDestino = (String) tuple[5];
                        return new ComisionesUsuario(idComision, estatus, fechaSalida, fechaRegreso, paisDestino, ciudadDestino);
                    }
                })
                .list();

        session.close();
        return comisionesUsuarios;
    }

    public List<ReporteFlujoComisionVO> obtenerReporteFlujoComision(Integer idComision, Integer idFlujo) {

        Session session = HibernateUtil.getSessionFactory().openSession();

        @SuppressWarnings("unchecked")
        List<ReporteFlujoComisionVO> reporteComision = session.createSQLQuery("CALL get_reporte_comision_por_flujo(:idComision,:idFlujo)")
                .setParameter("idComision", idComision)
                .setParameter("idFlujo", idFlujo)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer idComision = (Integer) tuple[0];
                        String nombres = (String) tuple[1];
                        String apellidoPaterno = (String) tuple[2];
                        String apellidoMaterno = (String) tuple[3];
                        String respuesta = (String) tuple[4];
                        String nombreFlujo = (String) tuple[5];
                        System.out.println("idComision: " + idComision + ", nombres: " + nombres + ", apellidoPaterno: " + apellidoPaterno
                                + ", apellidoMaterno: " + apellidoMaterno + ", respuesta:" + respuesta + ", nombreFlujo: " + nombreFlujo);
                        return new ReporteFlujoComisionVO(idComision, nombres, apellidoPaterno, apellidoMaterno, respuesta, nombreFlujo);
                    }
                })
                .list();

        session.close();
        return reporteComision;
    }

    public String regresaEstatusComisionEmpleado(String estatus) {
        if (estatus.equals("C")) {
            return EstatusComisiones.C;
        } else if (estatus.equals("EA")) {
            return EstatusComisiones.EA;
        } else if (estatus.equals("R")) {
            return EstatusComisiones.R;
        } else if (estatus.equals("A")) {
            return EstatusComisiones.A;
        } else if (estatus.equals("EV")) {
            return EstatusComisiones.EV;
        } else if (estatus.equals("RV")) {
            return EstatusComisiones.RV;
        } else if (estatus.equals("F")) {
            return EstatusComisiones.F;
        } else if (estatus.equals("EG")) {
            return EstatusComisiones.EG;
        } else if (estatus.equals("RG")) {
            return EstatusComisiones.RG;
        } else if (estatus.equals("CM")) {
            return EstatusComisiones.CM;
        } else if (estatus.equals("EP")) {
            return EstatusComisiones.EP;
        } else if (estatus.equals("RP")) {
            return EstatusComisiones.RP;
        } else if (estatus.equals("P")) {
            return EstatusComisiones.P;
        } else {
            return "";
        }
    }

    public Map<String,Object> getReporteOficioComision(int idComision, int idFlujo, String username) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<ComisionesDetalle> comisionesDetalle = session.createSQLQuery("CALL viajes_claros.get_comision_detalle_by_id_comision(:idComision)")
                            .setParameter("idComision", idComision).setResultTransformer(new BasicTransformerAdapter() {
                                private static final long serialVersionUID = 1L;
                                @Override
                                public Object transformTuple(Object[] tuple, String[] aliases) {
                                    Integer idDetalle = (Integer) tuple[0];
                                    Integer idComision = (Integer) tuple[1];
                                    String tabla = (String) tuple[2];
                                    String campo = (String) tuple[3];
                                    String valorTexto = (String) tuple[4];
                                    Double valorNumerico = (Double) tuple[5];
                                    java.sql.Timestamp fecha = (java.sql.Timestamp) tuple[6];                                    
                                    java.sql.Date valorFecha = fecha != null ? new java.sql.Date(fecha.getTime()) : null;
                                    return new ComisionesDetalle(idDetalle, idComision, tabla, campo, valorTexto, valorNumerico, valorFecha);
                                }
                            }).list();
        
        Map<String,Object> mapa = new HashMap<String,Object>();
        for (ComisionesDetalle comisionDetalle : comisionesDetalle){
            if(comisionDetalle.getValorTexto() != null){
                mapa.put(comisionDetalle.getCampo(), comisionDetalle.getValorTexto());
            }else if(comisionDetalle.getValorNumerico()!= null){
                mapa.put(comisionDetalle.getCampo(), comisionDetalle.getValorNumerico());
            }else if(comisionDetalle.getValorFecha()!= null){
                Calendar cal = Calendar.getInstance();
                cal.setTimeInMillis(comisionDetalle.getValorFecha().getTime());   
                Date fecha = cal.getTime();
                mapa.put(comisionDetalle.getCampo(), fecha);
            }else{
                mapa.put(comisionDetalle.getCampo(), null);
            }           
        }    
        
        @SuppressWarnings("unchecked")
        ReporteFlujoComisionCargoVO reporteComisionCargo = (ReporteFlujoComisionCargoVO) session.createSQLQuery("CALL get_reporte_comision_cargo_por_flujo(:idComision,:idFlujo)")
                .setParameter("idComision", idComision)
                .setParameter("idFlujo", idFlujo)
                .setResultTransformer(new BasicTransformerAdapter() {
                    private static final long serialVersionUID = 1L;
                    @Override
                    public Object transformTuple(Object[] tuple, String[] aliases) {
                        Integer idComision = (Integer) tuple[0];
                        String nombres = (String) tuple[1];
                        String apellidoPaterno = (String) tuple[2];
                        String apellidoMaterno = (String) tuple[3];
                        String respuesta = (String) tuple[4];
                        String nombreFlujo = (String) tuple[5];
                        String cargo = (String) tuple[6];
                        return new ReporteFlujoComisionCargoVO(idComision, nombres, apellidoPaterno, apellidoMaterno, respuesta, nombreFlujo, cargo);
                    }
                }).uniqueResult();
        
         @SuppressWarnings("unchecked")
        PersonaVO persona = (PersonaVO) session.createSQLQuery("CALL get_detalle_usuario_por_nombre_usuario(:username)")
            .setParameter("username", username)
            .setResultTransformer(new BasicTransformerAdapter() {
                private static final long serialVersionUID = 1L;
                @Override
                public Object transformTuple(Object[] tuple, String[] aliases) {
                    Integer idPersona = (Integer) tuple[0];
                    String nombres = (String) tuple[1];
                    String apellidoPaterno = (String) tuple[2];
                    String apellidoMaterno = (String) tuple[3];
                    String cargo = (String) tuple[9];
                    PersonaVO per = new PersonaVO();
                    per.setId(idPersona);
                    per.setNombres(nombres);
                    per.setApellidoPaterno(apellidoPaterno);
                    per.setApellidoMaterno(apellidoMaterno);
                    per.setCargo(cargo);
                    return per;
                }
            }).uniqueResult();
         
        String cvePP = mapa.get("programa_presupuestal").toString();
        String cveArea = mapa.get("cve_ua_presupuesto").toString();
        
        @SuppressWarnings("unchecked")
        TrProgramaPresupuestalVO trProgramaPresupuestal = null;
        if(cvePP != null){            
            trProgramaPresupuestal = (TrProgramaPresupuestalVO) session.createSQLQuery("CALL obtener_tr_pp_by_cve_pp(:cvePp)")
               .setParameter("cvePp", cvePP)
               .setResultTransformer(new BasicTransformerAdapter() {
                   private static final long serialVersionUID = 1L;
                   @Override
                   public Object transformTuple(Object[] tuple, String[] aliases) {
                       Integer id = (Integer) tuple[0];
                       String cve = (String) tuple[1];
                       String descripcion = (String) tuple[2];
                       TrProgramaPresupuestalVO trP = new TrProgramaPresupuestalVO();
                       trP.setIdProgramaPresupuestal(id);
                       trP.setCvePp(cve);
                       trP.setDescripcionPp(descripcion);
                       return trP;
                   }
               }).uniqueResult();
        }
         
        @SuppressWarnings("unchecked")
        AreaVO area = (AreaVO) session.createSQLQuery("CALL obten_area(:idArea)")
            .setParameter("idArea", cveArea)
            .setResultTransformer(new BasicTransformerAdapter() {
                private static final long serialVersionUID = 1L;
                @Override
                public Object transformTuple(Object[] tuple, String[] aliases) {
                    Integer id = (Integer) tuple[0];
                    String nombre = (String) tuple[1];
                    AreaVO ar = new AreaVO();
                    ar.setId(id);
                    ar.setNombre(nombre);
                    return ar;
                }
            }).uniqueResult();
         
         
        String nombreAut = reporteComisionCargo != null ? reporteComisionCargo.getNombres() + " " + reporteComisionCargo.getApellidoPaterno() + " " + reporteComisionCargo.getApellidoMaterno() : null;
        String cargoAut = reporteComisionCargo != null ? reporteComisionCargo.getCargo() : null;
        String nombreEnc = persona != null ? persona.getNombres() + " " + persona.getApellidoPaterno() + " " + persona.getApellidoMaterno() : null;
        String cargoEnc = persona != null ? persona.getCargo() : null;  
        String desTrPP = trProgramaPresupuestal != null ? trProgramaPresupuestal.getDescripcionPp() : null;
        String descUA  =  area != null ? area.getNombre() : null;
        
        mapa.put("nombre_enc", nombreEnc);
        mapa.put("cargo_enc", cargoEnc);
        mapa.put("nombre_autorizo", nombreAut);
        mapa.put("cargo_autorizo", cargoAut);
        mapa.put("programa_presupuestal",desTrPP);
        mapa.put("ua_presupuesto",descUA);
        mapa.put("cve_ua_presupuesto", cveArea);
        mapa.put("cve_programa_pre", cvePP);
        
        return mapa;
    }
}
