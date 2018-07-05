package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Paises.class)
public abstract class Paises_ {

	public static volatile SingularAttribute<Paises, String> clavePais;
	public static volatile CollectionAttribute<Paises, Estados> estadosCollection;
	public static volatile SingularAttribute<Paises, Integer> idPais;
	public static volatile SingularAttribute<Paises, Boolean> predeterminado;
	public static volatile CollectionAttribute<Paises, Ciudades> ciudadesCollection;
	public static volatile SingularAttribute<Paises, String> nombrePais;

}

