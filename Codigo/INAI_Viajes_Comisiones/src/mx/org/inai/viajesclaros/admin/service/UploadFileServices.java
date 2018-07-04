package mx.org.inai.viajesclaros.admin.service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.type.StandardBasicTypes;

import mx.org.inai.viajesclaros.admin.model.DetalleInterfazVO;
import mx.org.inai.viajesclaros.admin.model.ErrorInterfazVO;
import mx.org.inai.viajesclaros.admin.model.HeaderInterfazVO;
import mx.org.inai.viajesclaros.admin.model.InterfazConfigVO;
import mx.org.inai.viajesclaros.admin.model.ProcesaInterfazVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

//@Stateless
//@LocalBean
public class UploadFileServices {
	
	public int tieneLayout(int idDep) {
		int result = 0;
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		System.out.println("**** Dependencia - Layout " + idDep);
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.tiene_layout(:id_dep)");			
		query.setInteger("id_dep", idDep);
						
		result = ((BigInteger)query.uniqueResult()).intValue();
		
		session.close();
		
		return result;
	}
	
	public ArrayList<InterfazConfigVO> obtenerLayout(int idDep) {
			ArrayList<InterfazConfigVO> data = new ArrayList<InterfazConfigVO>();
			
			Session session = HibernateUtil.getSessionFactory().openSession();
			SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_layout(:id_dep)");
			query.addEntity(InterfazConfigVO.class);
			query.setInteger("id_dep", idDep);
							
			List<InterfazConfigVO> result = query.list();
			for(int i=0; i<result.size(); i++){
				InterfazConfigVO vo = (InterfazConfigVO)result.get(i);
				data.add(vo);
			}
			
			session.close();
			
			return data;
		}
	 
	 public ArrayList<InterfazConfigVO> obtenerInterfazConfig(int idDep) {
			ArrayList<InterfazConfigVO> data = new ArrayList<InterfazConfigVO>();
			
			Session session = HibernateUtil.getSessionFactory().openSession();
			SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_interfaz_carga(:id_dep)");
			query.addEntity(InterfazConfigVO.class);	
			query.setInteger("id_dep", idDep);
							
			List<InterfazConfigVO> result = query.list();
			for(int i=0; i<result.size(); i++){
				InterfazConfigVO vo = (InterfazConfigVO)result.get(i);
				data.add(vo);
			}
			
			session.close();
			
			return data;
		}
	 
	 public int validaDato(String tabla, String campo, String filtro) {
		 int result = 0;
		 System.out.println("llegamos a enviar el query dinamico");
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery(" CALL viajes_claros.valida_dato(:tabla, :campo, :filtro)");
		 System.out.println("****//////***** SELECT count(*) FROM " + tabla + " WHERE " + campo + " = '" + filtro + "'");
		 query.setString("tabla", tabla);
		 query.setString("campo", campo);
		 query.setString("filtro", filtro);
						
		 result = ((BigInteger)query.uniqueResult()).intValue();
		
		 session.close();
		
		 return result;
	 }
	 
	 public Integer obtenerIdDependencia(String dependencia) {
		 Integer result = 0;
			
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_id_dependencia(:siglas_dep)");
		 query.setString("siglas_dep", dependencia);

		 result = (Integer)query.uniqueResult();
		 
		 session.close();
			
		 return result;
	 }
	 
	 
	 public Integer obtenerIdViaje(long llave) {
		 Integer result = 0;
			
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_id_viaje(:id_arch)");
		 query.setLong("id_arch", llave);
		
		 result = (Integer)query.uniqueResult();
			
		 session.close();
			
		 return result;
	 }
	 
	 public ProcesaInterfazVO obtenerBitacora(long llave) {
		 ProcesaInterfazVO vo = new ProcesaInterfazVO();
			
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_bitacora(:id_arch)");
		 query.addEntity(ProcesaInterfazVO.class);
		 query.setLong("id_arch", llave);
							
		 List result = query.list();
		 for(int i=0; i<result.size(); i++){
			 vo = (ProcesaInterfazVO)result.get(i);	
		 }
			
		 session.close();
			
		 return vo;
	 }
	 
	 public ArrayList<ErrorInterfazVO> obtenerErrores(long llave){
		 ArrayList<ErrorInterfazVO> data = new  ArrayList<ErrorInterfazVO>();
		 
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_errores_carga(:id_arch)");
		 query.addEntity(ErrorInterfazVO.class);
		 query.setLong("id_arch", llave);
							
		 List<ErrorInterfazVO> result = query.list();
		 for(int i=0; i<result.size(); i++){
			ErrorInterfazVO vo = (ErrorInterfazVO)result.get(i);
			data.add(vo);
		 }
			
		 session.close();
		 
		 return data;
	 }

	 public Integer insertaHeaderArchivo(Session session, HeaderInterfazVO hiVO) {
			Integer res = 0;
	    	
			if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
	    	
			SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_viajes_claros_instancias(:id_dep,:id_arch)");
			//query.addEntity(HeaderInterfazVO.class);
			query.setInteger("id_dep", hiVO.getIdDependencia());
			query.setLong("id_arch", hiVO.getIdArchivo());
			    	
	    	res = (Integer)query.uniqueResult();
	    	return res;
	    }
	 
	 public Integer insertaDetalleArchivo(Session session, DetalleInterfazVO diVO) {
			Integer res = 0;
	    	System.out.println("****//////***** " + diVO.getIdViaje() + "-" + diVO.getTabla() + "-" + diVO.getCampo() + "-" +
	    						diVO.getValorT() + "-" + diVO.getValorN() + "-" + diVO.getValorF());
	    	if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
			SQLQuery query = session.createSQLQuery("select viajes_claros.inserta_viajes_claros_det(:id_viaje, :tabla, :campo, :valorT, :valorN, :valorF)");
			query.setInteger("id_viaje", diVO.getIdViaje());
			query.setString("tabla", diVO.getTabla());
			query.setString("campo", diVO.getCampo());
			query.setString("valorT", diVO.getValorT());
			//query.setInteger("valorN", diVO.getValorN());
			query.setParameter("valorN", diVO.getValorN(), StandardBasicTypes.INTEGER);
			query.setTimestamp("valorF", diVO.getValorF());	
			
	    	res = (Integer)query.uniqueResult();
	    	return res;
	    }
	 
	 
	 
	 public ArrayList<Integer> obtenerDetalleViajesFecha(Date fechaSalida) {
		 ArrayList<Integer> data = new ArrayList<Integer>();
			
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_viajes_fecha(:fecha_salida)");
		 //query.addEntity(DetalleInterfazVO.class);
		 query.setTimestamp("fecha_salida", fechaSalida);
							
		 List<Integer> result = query.list();
		 for(int i=0; i<result.size(); i++){
			Integer id = (Integer)result.get(i);
			data.add(id);
		 }
		 
		 session.close();
			
		 return data;
	 }
	 
	 public ArrayList<DetalleInterfazVO> obtenerDetalleViajeId(int idViaje) {
		 ArrayList<DetalleInterfazVO> data = new ArrayList<DetalleInterfazVO>();
			
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 System.out.println("******* Viaje: " + idViaje);
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_viaje_x_id(:id)");
		 query.addEntity(DetalleInterfazVO.class);
		 query.setInteger("id", idViaje);
							
		 List<DetalleInterfazVO> result = query.list();
		 for(int i=0; i<result.size(); i++){
			DetalleInterfazVO vo = (DetalleInterfazVO)result.get(i);
			data.add(vo);
		 }
		 
		 session.close();
			
		 return data;
	 }
	 
	 public Integer actualizaDetalleArchivo(Session session, DetalleInterfazVO diVO) {
		Integer res = 0;
	    	
		
		if (session == null || !session.isOpen()) {
	    	session = HibernateUtil.getSessionFactory().openSession();
	    }
			
		SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_viajes_claros_det(:id, :tab, :camp, :valorT, :valorN, :valorF)");
		query.setInteger("id", diVO.getIdViaje());
		query.setString("tab", diVO.getTabla());
		query.setString("camp", diVO.getCampo());
		query.setString("valorT", diVO.getValorT());
		//query.setInteger("valorN", diVO.getValorN());
		query.setParameter("valorN", diVO.getValorN(), StandardBasicTypes.INTEGER);
		query.setTimestamp("valorF", diVO.getValorF());
			
	    res = (Integer)query.uniqueResult();
	    return res;
	 }
	 
	 public Integer eliminaDetalleArchivo(Session session, DetalleInterfazVO diVO) {
			Integer res = 0;
	    	
			if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
			
			SQLQuery query = session.createSQLQuery("select viajes_claros.elimina_viajes_claros_det(:id, :tab, :camp, :valorT, :valorN, :valorF)");
			query.setInteger("id", diVO.getIdViaje());
			query.setString("tab", diVO.getTabla());
			query.setString("camp", diVO.getCampo());
			query.setString("valorT", diVO.getValorT());
			//query.setInteger("valorN", diVO.getValorN());
			query.setDate("valorF", diVO.getValorF());
			query.setParameter("valorN", diVO.getValorN(), StandardBasicTypes.INTEGER);
			
	    	res = (Integer)query.uniqueResult();
	    	return res;
	    }
	 
	 public void insertaProcesamiento(Session session, long llave, String nomArchivo){
		 	if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
	    	SQLQuery query = session.createSQLQuery("CALL viajes_claros.inserta_archivos_procesados(:id_arch, :nom_archivo)");	    	
	    	query.setLong("id_arch", llave);
	    	query.setString("nom_archivo", nomArchivo);
	    	
	    	//res = (Integer)query.uniqueResult();
	    	query.executeUpdate();
	    	//return res;
	 }
	 
	 public Integer actualizaArchivosProcesados(Session session, long llave, int totReg, int errorCount, int aceptados){
		 Integer res = 0;
	    	
		 	if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
	    	SQLQuery query = session.createSQLQuery("select viajes_claros.actualiza_archivos_procesados(:id,:tot,:rech,:acep)");
			query.setLong("id", llave);
	    	//query.setString("nom", nombreArchivo);
			query.setInteger("tot", totReg);
			query.setInteger("rech", errorCount);
			query.setInteger("acep", aceptados);		
	    	
	    	res = (Integer)query.uniqueResult();
	    	return res;
	 }
	 
	 public void insertaDetalleError(Session session, long llave, int numReg, String error){
		 if (session == null || !session.isOpen()) {
	    		session = HibernateUtil.getSessionFactory().openSession();
	    	}
	 	 SQLQuery query = session.createSQLQuery("CALL viajes_claros.inserta_archivos_procesados_det(:id_arch, :num_reg, :error)");
		 query.setLong("id_arch", llave);
		 query.setInteger("num_reg", numReg);
		 query.setString("error", error);
		
		 query.executeUpdate();
    	 //query.uniqueResult();
	 }

	 
	 public void eliminaDetalleError(long llave){
		 Session session = HibernateUtil.getSessionFactory().openSession();
		 SQLQuery query = session.createSQLQuery("CALL viajes_claros.elimina_procesados_det(:id_arch)");
		 query.setLong("id_arch", llave);
			
		 query.executeUpdate();
		 //query.uniqueResult();
			
		 session.close();
	 }
	 
}	

