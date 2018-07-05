package mx.org.inai.viajesclaros.entities;

import java.math.BigInteger;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ViajesClarosInstancias.class)
public abstract class ViajesClarosInstancias_ {

	public static volatile SingularAttribute<ViajesClarosInstancias, Comisiones> idComision;
	public static volatile CollectionAttribute<ViajesClarosInstancias, ViajesClarosDetalle> viajesClarosDetalleCollection;
	public static volatile SingularAttribute<ViajesClarosInstancias, BigInteger> idArchivo;
	public static volatile SingularAttribute<ViajesClarosInstancias, Date> fechaPublicacion;
	public static volatile SingularAttribute<ViajesClarosInstancias, Dependencias> idDependencia;
	public static volatile SingularAttribute<ViajesClarosInstancias, Integer> idViaje;

}

