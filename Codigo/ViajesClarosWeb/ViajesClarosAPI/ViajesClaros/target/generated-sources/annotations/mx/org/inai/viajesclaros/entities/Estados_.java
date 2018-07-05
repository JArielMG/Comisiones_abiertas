package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Estados.class)
public abstract class Estados_ {

	public static volatile SingularAttribute<Estados, Paises> idPais;
	public static volatile SingularAttribute<Estados, String> nombreEstado;
	public static volatile SingularAttribute<Estados, Integer> idEstado;
	public static volatile CollectionAttribute<Estados, Ciudades> ciudadesCollection;

}

