package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Posiciones.class)
public abstract class Posiciones_ {

	public static volatile SingularAttribute<Posiciones, Integer> idPosicion;
	public static volatile CollectionAttribute<Posiciones, Personas> personasCollection;
	public static volatile SingularAttribute<Posiciones, String> nombrePosicion;

}

