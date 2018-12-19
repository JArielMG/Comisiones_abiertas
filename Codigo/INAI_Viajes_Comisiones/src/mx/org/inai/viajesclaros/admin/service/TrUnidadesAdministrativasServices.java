package mx.org.inai.viajesclaros.admin.service;

import java.util.ArrayList;
import java.util.List;
import mx.org.inai.viajesclaros.admin.model.TrUnidadAdministrativaVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

public class TrUnidadesAdministrativasServices {

    public ArrayList<TrUnidadAdministrativaVO> obtenerUnidades() {

        ArrayList<TrUnidadAdministrativaVO> data = new ArrayList<TrUnidadAdministrativaVO>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        SQLQuery query = session.createSQLQuery("CALL viajes_claros.obtener_tr_unidades_administrativas()");
        query.addEntity(TrUnidadAdministrativaVO.class);

        List result = query.list();
        for (int i = 0; i < result.size(); i++) {
            TrUnidadAdministrativaVO vo = (TrUnidadAdministrativaVO) result.get(i);
            data.add(vo);
        }

        session.close();

        return data;
    }
}
