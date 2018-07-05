package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Dependencias.class)
public abstract class Dependencias_ {

	public static volatile CollectionAttribute<Dependencias, BuscadorFiltrosConfig> buscadorFiltrosConfigCollection;
	public static volatile SingularAttribute<Dependencias, Integer> idDependencia;
	public static volatile SingularAttribute<Dependencias, String> siglas;
	public static volatile CollectionAttribute<Dependencias, Areas> areasCollection;
	public static volatile SingularAttribute<Dependencias, String> nombreDependencia;
	public static volatile CollectionAttribute<Dependencias, CamposDinamicos> camposDinamicosCollection;
	public static volatile CollectionAttribute<Dependencias, BuscadorDespliegueConfig> buscadorDespliegueConfigCollection;
	public static volatile CollectionAttribute<Dependencias, ViajesClarosInstancias> viajesClarosInstanciasCollection;
	public static volatile CollectionAttribute<Dependencias, InterfazConfig> interfazConfigCollection;
	public static volatile CollectionAttribute<Dependencias, Graficas> graficasCollection;
	public static volatile CollectionAttribute<Dependencias, Comisiones> comisionesCollection;
	public static volatile CollectionAttribute<Dependencias, Usuarios> usuariosCollection;
	public static volatile SingularAttribute<Dependencias, Boolean> predeterminada;
	public static volatile CollectionAttribute<Dependencias, ConfiguracionAprobacion> configuracionAprobacionCollection;

}

