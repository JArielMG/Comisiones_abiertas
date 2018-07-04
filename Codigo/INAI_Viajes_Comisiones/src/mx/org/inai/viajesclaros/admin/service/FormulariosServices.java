package mx.org.inai.viajesclaros.admin.service;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.BasicTransformerAdapter;

import mx.org.inai.viajesclaros.admin.model.CamposFormulario;
import mx.org.inai.viajesclaros.admin.model.CatalogoElement;
import mx.org.inai.viajesclaros.admin.model.Comisiones;
import mx.org.inai.viajesclaros.admin.model.DatosFuncionariosVO;
import mx.org.inai.viajesclaros.admin.model.FlujosComisionesVO;
import mx.org.inai.viajesclaros.admin.model.GastosComision;
import mx.org.inai.viajesclaros.admin.model.ListaGastosComision;
import mx.org.inai.viajesclaros.admin.model.RegistrosGastosComisionVO;
import mx.org.inai.viajesclaros.admin.model.ReporteFlujoComisionVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesFormulario;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.util.TipoControl;

public class FormulariosServices {

	public ArrayList<DatosFuncionariosVO> obtenerDatosFuncionario(String username) {
		ArrayList<DatosFuncionariosVO> data = new ArrayList<DatosFuncionariosVO>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_detalle_usuario_por_nombre_usuario(:username)");
		query.addEntity(DatosFuncionariosVO.class);
		query.setString("username", username);
						
		List<DatosFuncionariosVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			DatosFuncionariosVO vo = (DatosFuncionariosVO)result.get(i);
			data.add(vo);
		}
		
		session.close();
		return data;
	}
	
	@SuppressWarnings("unchecked")
	public ArrayList<Comisiones> obtenerComisionesEnCursoFuncionario(Integer idPersona) {
		ArrayList<Comisiones> data = new ArrayList<Comisiones>();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_comisiones_en_curso_por_id_persona(:idPersona)");
		query.addEntity(Comisiones.class);
		query.setInteger("idPersona", idPersona);
						
		List<Comisiones> result = query.list();
		for(int i=0; i<result.size(); i++){
			Comisiones vo = (Comisiones)result.get(i);
			data.add(vo);
		}
		
		session.close();
		
		return data;
	}
	
	public Integer insertarNuevaComision(String estatus, Integer idDependencia, Integer idPersona, Integer idUsuario) {
		
		Integer idComision=0;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("SELECT viajes_claros.inserta_comision(:estatus,:idDependencia,:idPersona,:idUsuario)");
		query.setString("estatus", estatus);
		query.setInteger("idDependencia", idDependencia);
		query.setInteger("idPersona", idPersona);
		query.setInteger("idUsuario", idUsuario);
						
		idComision = (Integer)query.uniqueResult();
				
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
				
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_comision_detalle_id_comision(:idComision,:tabla,:campo,:tipoDato)");
		query.setInteger("idComision", idComision);
		query.setString("tabla", tabla);
		query.setString("campo", campo);
		query.setShort("tipoDato", tipoDato);
		
		Object res = query.uniqueResult();
		
		//Actualiza si el resultado es distinto a nulo
		if (res!=null){
			query = session.createSQLQuery("CALL viajes_claros.update_comision_detalle(:idComision,:tabla,:campo,:valorTexto,:valorNumerico,:valorFecha)");
			query.setInteger("idComision", idComision);
			query.setString("tabla", tabla);
			query.setString("campo", campo);
			query.setString("valorTexto", valorTexto);
			query.setDouble("valorNumerico", valorNumerico);
			query.setTimestamp("valorFecha", valorFecha);
							
			query.executeUpdate();
			
		}else{
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
				
		String resultado="";
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.get_comision_detalle_id_comision(:idComision,:tabla,:campo,:tipoDato)");
		query.setInteger("idComision", idComision);
		query.setString("tabla", tabla);
		query.setString("campo", campo);
		query.setShort("tipoDato", tipoDato);
		
		Object res = query.uniqueResult();
		
		if (res!=null)
			resultado = res.toString();
				
		session.close();
		
		return resultado;
	}
	
    @SuppressWarnings("unchecked")
	public List<SeccionesFormulario> getCamposFormulario(Integer idFlujo,Integer idTipoPersona,String tipoRepresentacion) {

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
	            if (cf.getTipoControl().equals(TipoControl.LISTA) && !cf.getTabla().equals("")) {
					List<CatalogoElement> cat = session.createSQLQuery("CALL get_catalogo_tabla_campo(:tabla, :campo)")
	                        .setParameter("tabla", cf.getTabla())
	                        .setParameter("campo", cf.getCampo())
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
	            } else if ((cf.getTipoControl().equals(TipoControl.LISTA) && cf.getListaHabilitada())||(cf.getTipoControl().equals(TipoControl.TEXTO) && cf.getListaHabilitada())) {
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
	            	}else*/ if (cf.getCampo().equals("homologacion")&&tipoRepresentacion.equals("AN")){
	            		List<CatalogoElement> catalog = new ArrayList<CatalogoElement>();
	            		CatalogoElement catalogOption = new CatalogoElement();
	            		catalogOption.setCodigo("NO");
            			catalogOption.setDescripcion("No");
	            		catalog.add(catalogOption);

		                cf.setCatalogo(catalog);
	            	}else{
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
					
	            }
	        }
	        sf.setCamposFormulario(camposFormulario);
		}
		
		session.close();

        return seccionesFormulario;
    }
    
    public List<CatalogoElement> getCatalogo(Integer idLista){

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
    
    public List<String> getEncabezadosGastos(){

		Session session = HibernateUtil.getSessionFactory().openSession();
		
    	@SuppressWarnings("unchecked")
		List<String> encabezados = session.createSQLQuery("CALL get_gastos_campos_config_headers()").list();
    	
    	session.close();
        return encabezados;
    }
    
    public List<ListaGastosComision> getListaGastosComision(Integer idComision){

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
                        return new ListaGastosComision(valor,idRegistroGastoComision);
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

                    	camposGastosComision.setCampo((String)tuple[0]);
                    	camposGastosComision.setEtiqueta((String)tuple[1]);
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
                    	camposGastosComision.setCampo((String)tuple[1]);
                    	camposGastosComision.setEtiqueta((String)tuple[2]);
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
		
		idRegistroGastoComision = (Integer)query.uniqueResult();
		
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
		if (res!=null){
			query = session.createSQLQuery("CALL viajes_claros.update_comision_desglose_gastos(:idComision,:idRegistroGastoComision,:campo,:valorTexto,:valorNumerico,:valorFecha)");
			query.setInteger("idComision", idComision);
			query.setInteger("idRegistroGastoComision", idRegistroGastoComision);
			query.setString("campo", campo);
			query.setString("valorTexto", valorTexto);
			query.setDouble("valorNumerico", valorNumerico);
			query.setTimestamp("valorFecha", valorFecha);
							
			query.executeUpdate();
			
		}else{
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
    
    public void eliminarRegistroGastosComision(Integer idComision,Integer idRegistroGastosComision){

		Session session = HibernateUtil.getSessionFactory().openSession();
		
    	@SuppressWarnings("unchecked")
    	SQLQuery query = session.createSQLQuery("CALL delete_registro_gastos_id_comision(:idComision,:idRegistroGastosComision)");
    	query.setInteger("idComision", idComision);
		query.setInteger("idRegistroGastosComision", idRegistroGastosComision);
		query.executeUpdate();
    	
    	session.close();
    }
    
    public List<RegistrosGastosComisionVO> obtenerRegistrosGastosIdComision(Integer idComision){

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
                return new RegistrosGastosComisionVO(idRegistroGasto,importe,concepto,tipoGasto,comprobante);
            }
        })
    	.list();
    	
    	session.close();
		return gastosFuncionario;
    }
    
    public List<FlujosComisionesVO> obtenerFlujosComision(Integer idPersona){

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
                return new FlujosComisionesVO(idComision,f1,f2,f3,f4);
            }
        })
    	.list();
    	
    	session.close();
		return flujosComision;
    }
    
    public List<ReporteFlujoComisionVO> obtenerReporteFlujoComision(Integer idComision,Integer idFlujo){

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
                System.out.println("idComision: "+idComision+", nombres: "+nombres+", apellidoPaterno: "+apellidoPaterno
                		+", apellidoMaterno: "+apellidoMaterno+", respuesta:"+respuesta+", nombreFlujo: "+nombreFlujo);
                return new ReporteFlujoComisionVO(idComision,nombres,apellidoPaterno,apellidoMaterno,respuesta,nombreFlujo);
            }
        })
    	.list();
    	
    	session.close();
		return reporteComision;
    }
    
}
