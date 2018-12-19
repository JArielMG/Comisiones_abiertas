package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;
import mx.org.inai.viajesclaros.admin.model.TrProgramaEspecialVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TrProgramaEspecialService {

    public ArrayList<TrProgramaEspecialVO> obtenerProyectos(String ua, String pp) {
        int id_ua = Integer.parseInt(ua);
        ArrayList<TrProgramaEspecialVO> data = new ArrayList<TrProgramaEspecialVO>();

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            SQLQuery query = session.createSQLQuery("CALL obtener_tr_proyectos_especiales(:id,:pp)");
            query.setInteger("id", id_ua);
            query.setString("pp", pp);
            query.addEntity(TrProgramaEspecialVO.class);
            List<TrProgramaEspecialVO> result = query.list();

            for (int i = 0; i < result.size(); i++) {
                TrProgramaEspecialVO vo = result.get(i);
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
