package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(CamposDinamicos.class)
public abstract class CamposDinamicos_ {

	public static volatile SingularAttribute<CamposDinamicos, String> descripcion;
	public static volatile SingularAttribute<CamposDinamicos, String> nombreCampo;
	public static volatile SingularAttribute<CamposDinamicos, CategoriaCampo> categoria;
	public static volatile SingularAttribute<CamposDinamicos, Integer> tipoControl;
	public static volatile CollectionAttribute<CamposDinamicos, Dependencias> dependenciasCollection;
	public static volatile SingularAttribute<CamposDinamicos, ListasValores> idLista;
	public static volatile SingularAttribute<CamposDinamicos, Boolean> busquedaDefecto;
	public static volatile SingularAttribute<CamposDinamicos, Integer> tipoDato;
	public static volatile SingularAttribute<CamposDinamicos, String> despliegue;

}

