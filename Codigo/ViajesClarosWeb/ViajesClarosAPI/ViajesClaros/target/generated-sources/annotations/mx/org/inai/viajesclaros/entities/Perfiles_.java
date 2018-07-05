package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Perfiles.class)
public abstract class Perfiles_ {

	public static volatile SingularAttribute<Perfiles, Integer> idPerfil;
	public static volatile CollectionAttribute<Perfiles, Usuarios> usuariosCollection;
	public static volatile SingularAttribute<Perfiles, String> nombrePerfil;

}

