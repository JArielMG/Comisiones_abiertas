package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Jerarquias.class)
public abstract class Jerarquias_ {

	public static volatile CollectionAttribute<Jerarquias, JerarquiaMiembros> jerarquiaMiembrosCollection;
	public static volatile SingularAttribute<Jerarquias, Boolean> editable;
	public static volatile CollectionAttribute<Jerarquias, ConfiguracionAprobacion> configuracionAprobacionCollection;
	public static volatile SingularAttribute<Jerarquias, Integer> idJerarquia;
	public static volatile SingularAttribute<Jerarquias, String> nombreJerarquia;

}

