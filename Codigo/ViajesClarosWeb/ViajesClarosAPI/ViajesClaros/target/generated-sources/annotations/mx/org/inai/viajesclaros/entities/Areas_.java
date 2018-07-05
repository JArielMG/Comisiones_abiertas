package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Areas.class)
public abstract class Areas_ {

	public static volatile SingularAttribute<Areas, String> nombreArea;
	public static volatile SingularAttribute<Areas, Integer> idArea;
	public static volatile CollectionAttribute<Areas, ConfiguracionAprobacion> configuracionAprobacionCollection;
	public static volatile CollectionAttribute<Areas, Usuarios> usuariosCollection;
	public static volatile SingularAttribute<Areas, Dependencias> idDependencia;

}

