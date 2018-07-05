package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ListasValores.class)
public abstract class ListasValores_ {

	public static volatile CollectionAttribute<ListasValores, CamposDinamicos> camposDinamicosCollection;
	public static volatile SingularAttribute<ListasValores, String> nombreLista;
	public static volatile SingularAttribute<ListasValores, Boolean> habilitada;
	public static volatile SingularAttribute<ListasValores, Integer> idLista;
	public static volatile CollectionAttribute<ListasValores, ValoresDinamicos> valoresDinamicosCollection;

}

