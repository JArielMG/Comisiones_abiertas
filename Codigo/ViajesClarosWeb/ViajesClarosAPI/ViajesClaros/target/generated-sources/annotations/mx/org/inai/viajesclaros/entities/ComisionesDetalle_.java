package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ComisionesDetalle.class)
public abstract class ComisionesDetalle_ {

	public static volatile SingularAttribute<ComisionesDetalle, String> campo;
	public static volatile SingularAttribute<ComisionesDetalle, Comisiones> idComision;
	public static volatile SingularAttribute<ComisionesDetalle, Integer> idDetalle;
	public static volatile SingularAttribute<ComisionesDetalle, Date> valorFecha;
	public static volatile SingularAttribute<ComisionesDetalle, Double> valorNumerico;
	public static volatile SingularAttribute<ComisionesDetalle, String> valorTexto;
	public static volatile SingularAttribute<ComisionesDetalle, String> tabla;

}

