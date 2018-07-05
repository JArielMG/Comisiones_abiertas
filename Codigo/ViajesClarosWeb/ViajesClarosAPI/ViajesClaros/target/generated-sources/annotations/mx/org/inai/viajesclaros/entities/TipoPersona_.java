package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(TipoPersona.class)
public abstract class TipoPersona_ {

	public static volatile SingularAttribute<TipoPersona, String> codigoTipo;
	public static volatile CollectionAttribute<TipoPersona, Personas> personasCollection;
	public static volatile SingularAttribute<TipoPersona, String> descripcion;
	public static volatile SingularAttribute<TipoPersona, Integer> idTipo;

}

