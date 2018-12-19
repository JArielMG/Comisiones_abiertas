package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;
import mx.org.inai.viajesclaros.admin.model.TrProgramaPresupuestalVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TrProgramaPresupuestalServices {

    public ArrayList<TrProgramaPresupuestalVO> obtenerProgramas(String ua) {
        int id_ua = Integer.parseInt(ua);
        ArrayList<TrProgramaPresupuestalVO> data = new ArrayList<TrProgramaPresupuestalVO>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            SQLQuery query = session.createSQLQuery("CALL obtener_tr_pp(:id)");
            query.setInteger("id", id_ua);
            query.addEntity(TrProgramaPresupuestalVO.class);
            List<TrProgramaPresupuestalVO> result = query.list();

            for (int i = 0; i < result.size(); i++) {
                TrProgramaPresupuestalVO vo = result.get(i);
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
