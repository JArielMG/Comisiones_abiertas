package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ConfiguracionAprobacion.class)
public abstract class ConfiguracionAprobacion_ {

	public static volatile SingularAttribute<ConfiguracionAprobacion, String> nombre;
	public static volatile SingularAttribute<ConfiguracionAprobacion, FlujosTrabajo> idFlujo;
	public static volatile SingularAttribute<ConfiguracionAprobacion, Dependencias> idDependencia;
	public static volatile SingularAttribute<ConfiguracionAprobacion, Areas> idArea;
	public static volatile SingularAttribute<ConfiguracionAprobacion, Jerarquias> idJerarquia;
	public static volatile SingularAttribute<ConfiguracionAprobacion, Integer> idConfAprobacion;
	public static volatile SingularAttribute<ConfiguracionAprobacion, Boolean> editable;

}

