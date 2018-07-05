package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(FlujosTrabajo.class)
public abstract class FlujosTrabajo_ {

	public static volatile CollectionAttribute<FlujosTrabajo, FlujosInstancias> flujosInstanciasCollection;
	public static volatile SingularAttribute<FlujosTrabajo, Integer> idFlujo;
	public static volatile CollectionAttribute<FlujosTrabajo, SeccionesFormulario> seccionesFormularioCollection;
	public static volatile SingularAttribute<FlujosTrabajo, String> descripcion;
	public static volatile SingularAttribute<FlujosTrabajo, String> nombreFlujo;
	public static volatile CollectionAttribute<FlujosTrabajo, ConfiguracionAprobacion> configuracionAprobacionCollection;
	public static volatile CollectionAttribute<FlujosTrabajo, FlujosCamposConfig> flujosCamposConfigCollection;
	public static volatile SingularAttribute<FlujosTrabajo, String> version;

}

