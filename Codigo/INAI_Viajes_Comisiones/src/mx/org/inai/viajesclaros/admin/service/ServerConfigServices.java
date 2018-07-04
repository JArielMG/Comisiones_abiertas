package mx.org.inai.viajesclaros.admin.service;

import java.util.List;

import mx.org.inai.viajesclaros.admin.model.MailConfigVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;

import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class ServerConfigServices {

	public MailConfigVO obtenerMailServer() {
		MailConfigVO vo = new MailConfigVO();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery("CALL viajes_claros.obten_mail_server()");
		query.addEntity(MailConfigVO.class);
						
		List<MailConfigVO> result = query.list();
		for(int i=0; i<result.size(); i++){
			vo = (MailConfigVO)result.get(i);
		}
		
		session.close();
		
		return vo;
	}
}
