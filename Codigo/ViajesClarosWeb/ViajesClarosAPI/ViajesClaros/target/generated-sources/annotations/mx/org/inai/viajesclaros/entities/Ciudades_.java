package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Ciudades.class)
public abstract class Ciudades_ {

	public static volatile SingularAttribute<Ciudades, Paises> idPais;
	public static volatile SingularAttribute<Ciudades, String> latitud;
	public static volatile SingularAttribute<Ciudades, Integer> idCiudad;
	public static volatile SingularAttribute<Ciudades, Estados> idEstado;
	public static volatile SingularAttribute<Ciudades, String> longitud;
	public static volatile SingularAttribute<Ciudades, String> nombreCiudad;

}

