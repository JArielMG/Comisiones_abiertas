package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(RegistrosGastosComision.class)
public abstract class RegistrosGastosComision_ {

	public static volatile SingularAttribute<RegistrosGastosComision, Comisiones> idComision;
	public static volatile SingularAttribute<RegistrosGastosComision, Integer> idRegistroGastoComision;
	public static volatile CollectionAttribute<RegistrosGastosComision, ComisionesDesgloseGastos> comisionesDesgloseGastosCollection;

}

