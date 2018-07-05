package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ArchivosProcesados.class)
public abstract class ArchivosProcesados_ {

	public static volatile SingularAttribute<ArchivosProcesados, Integer> totalAceptados;
	public static volatile SingularAttribute<ArchivosProcesados, String> nombreArchivo;
	public static volatile SingularAttribute<ArchivosProcesados, Integer> totalRegistros;
	public static volatile SingularAttribute<ArchivosProcesados, Integer> totalRechazados;
	public static volatile SingularAttribute<ArchivosProcesados, Date> fechaCarga;
	public static volatile CollectionAttribute<ArchivosProcesados, ArchivoLineas> archivoLineasCollection;
	public static volatile SingularAttribute<ArchivosProcesados, Long> idArchivo;

}

