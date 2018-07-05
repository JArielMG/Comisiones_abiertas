package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Graficas.class)
public abstract class Graficas_ {

	public static volatile SingularAttribute<Graficas, Integer> idGrafica;
	public static volatile CollectionAttribute<Graficas, Dependencias> dependenciasCollection;
	public static volatile SingularAttribute<Graficas, String> descripcion;
	public static volatile SingularAttribute<Graficas, String> grafica;

}

