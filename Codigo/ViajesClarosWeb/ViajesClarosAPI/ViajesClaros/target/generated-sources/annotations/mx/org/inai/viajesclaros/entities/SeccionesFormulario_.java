package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(SeccionesFormulario.class)
public abstract class SeccionesFormulario_ {

	public static volatile SingularAttribute<SeccionesFormulario, String> etiqueta;
	public static volatile CollectionAttribute<SeccionesFormulario, FlujosCamposConfig> flujosCamposConfigCollection;
	public static volatile SingularAttribute<SeccionesFormulario, Integer> ordenSeccion;
	public static volatile SingularAttribute<SeccionesFormulario, FlujosTrabajo> idFlujo;
	public static volatile SingularAttribute<SeccionesFormulario, Integer> idSeccion;
	public static volatile SingularAttribute<SeccionesFormulario, String> nombreSeccion;

}

