package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Personas.class)
public abstract class Personas_ {

	public static volatile SingularAttribute<Personas, Categoria> idCategoria;
	public static volatile SingularAttribute<Personas, String> titulo;
	public static volatile SingularAttribute<Personas, String> nombres;
	public static volatile SingularAttribute<Personas, String> email;
	public static volatile SingularAttribute<Personas, Posiciones> idPosicion;
	public static volatile CollectionAttribute<Personas, Comisiones> comisionesCollection;
	public static volatile SingularAttribute<Personas, String> apellidoMaterno;
	public static volatile SingularAttribute<Personas, String> apellidoPaterno;
	public static volatile SingularAttribute<Personas, TipoPersona> idTipoPersona;
	public static volatile SingularAttribute<Personas, Date> fechaIngreso;
	public static volatile CollectionAttribute<Personas, Usuarios> usuariosCollection;
	public static volatile SingularAttribute<Personas, Integer> idPersona;
	public static volatile SingularAttribute<Personas, String> cargo;
	public static volatile CollectionAttribute<Personas, AprobacionesBitacora> aprobacionesBitacoraCollection;

}

