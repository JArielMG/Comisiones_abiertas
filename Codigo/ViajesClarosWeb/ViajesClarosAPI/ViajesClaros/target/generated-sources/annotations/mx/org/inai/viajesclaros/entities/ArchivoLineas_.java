package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ArchivoLineas.class)
public abstract class ArchivoLineas_ {

	public static volatile SingularAttribute<ArchivoLineas, Integer> idLinea;
	public static volatile SingularAttribute<ArchivoLineas, String> estatus;
	public static volatile SingularAttribute<ArchivoLineas, Integer> idError;
	public static volatile SingularAttribute<ArchivoLineas, ArchivosProcesados> idArchivo;
	public static volatile SingularAttribute<ArchivoLineas, String> comentarios;

}

