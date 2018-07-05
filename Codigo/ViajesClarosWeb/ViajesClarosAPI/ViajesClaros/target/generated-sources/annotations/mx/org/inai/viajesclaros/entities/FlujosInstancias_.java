package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(FlujosInstancias.class)
public abstract class FlujosInstancias_ {

	public static volatile SingularAttribute<FlujosInstancias, FlujosInstanciasPK> flujosInstanciasPK;
	public static volatile SingularAttribute<FlujosInstancias, Date> fechaFin;
	public static volatile SingularAttribute<FlujosInstancias, FlujosTrabajo> flujosTrabajo;
	public static volatile SingularAttribute<FlujosInstancias, Comisiones> comisiones;
	public static volatile SingularAttribute<FlujosInstancias, Boolean> asignado;
	public static volatile SingularAttribute<FlujosInstancias, Date> fechaInicio;
	public static volatile CollectionAttribute<FlujosInstancias, AprobacionesBitacora> aprobacionesBitacoraCollection;

}

