package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;
import mx.org.inai.viajesclaros.admin.model.TrActividadPresupuestalVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TrActividadPresupuestalService {
    
    public ArrayList<TrActividadPresupuestalVO> obtenerActividades(String ua, String pp, String pe){
        int id_ua = Integer.parseInt(ua);
        ArrayList<TrActividadPresupuestalVO> data = new ArrayList<TrActividadPresupuestalVO>();
        
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            SQLQuery query = session.createSQLQuery("CALL obtener_tr_actividades(:id,:pp,:pe)");
            query.setInteger("id",id_ua);
            query.setString("pp", pp);
            query.setString("pe", pe);
            query.addEntity(TrActividadPresupuestalVO.class);
            List<TrActividadPresupuestalVO> result = query.list();

            for (int i = 0; i < result.size(); i++) {
                TrActividadPresupuestalVO vo = result.get(i);
                data.add(vo);
            }
            tx.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}
