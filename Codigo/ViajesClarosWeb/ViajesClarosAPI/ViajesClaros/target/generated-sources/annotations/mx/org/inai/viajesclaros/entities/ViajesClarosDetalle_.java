package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ViajesClarosDetalle.class)
public abstract class ViajesClarosDetalle_ {

	public static volatile SingularAttribute<ViajesClarosDetalle, ViajesClarosDetallePK> viajesClarosDetallePK;
	public static volatile SingularAttribute<ViajesClarosDetalle, Date> valorFecha;
	public static volatile SingularAttribute<ViajesClarosDetalle, ViajesClarosInstancias> viajesClarosInstancias;
	public static volatile SingularAttribute<ViajesClarosDetalle, String> valorTexto;
	public static volatile SingularAttribute<ViajesClarosDetalle, Double> valorNumerico;

}

