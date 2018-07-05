package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Categoria.class)
public abstract class Categoria_ {

	public static volatile SingularAttribute<Categoria, Integer> idCategoria;
	public static volatile SingularAttribute<Categoria, Double> topeHospedaje;
	public static volatile SingularAttribute<Categoria, String> nombreCategoria;
	public static volatile CollectionAttribute<Categoria, Personas> personasCollection;
	public static volatile SingularAttribute<Categoria, Double> topeViaticos;

}

