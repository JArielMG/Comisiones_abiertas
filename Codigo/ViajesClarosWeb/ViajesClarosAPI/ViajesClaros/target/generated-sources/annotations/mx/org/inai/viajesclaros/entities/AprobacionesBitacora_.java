package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(AprobacionesBitacora.class)
public abstract class AprobacionesBitacora_ {

	public static volatile SingularAttribute<AprobacionesBitacora, Date> fechaEvento;
	public static volatile SingularAttribute<AprobacionesBitacora, String> respuesta;
	public static volatile SingularAttribute<AprobacionesBitacora, Personas> personas;
	public static volatile SingularAttribute<AprobacionesBitacora, AprobacionesBitacoraPK> aprobacionesBitacoraPK;
	public static volatile SingularAttribute<AprobacionesBitacora, FlujosInstancias> flujosInstancias;

}

