package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Comisiones.class)
public abstract class Comisiones_ {

	public static volatile CollectionAttribute<Comisiones, ViajesClarosInstancias> viajesClarosInstanciasCollection;
	public static volatile CollectionAttribute<Comisiones, RegistrosGastosComision> registrosGastosComisionCollection;
	public static volatile CollectionAttribute<Comisiones, FlujosInstancias> flujosInstanciasCollection;
	public static volatile SingularAttribute<Comisiones, Usuarios> idUsuario;
	public static volatile SingularAttribute<Comisiones, Dependencias> idDependencia;
	public static volatile SingularAttribute<Comisiones, Integer> idComision;
	public static volatile SingularAttribute<Comisiones, Personas> idPersona;
	public static volatile SingularAttribute<Comisiones, String> estatus;
	public static volatile CollectionAttribute<Comisiones, ComisionesDesgloseGastos> comisionesDesgloseGastosCollection;
	public static volatile CollectionAttribute<Comisiones, ComisionesDetalle> comisionesDetalleCollection;

}

