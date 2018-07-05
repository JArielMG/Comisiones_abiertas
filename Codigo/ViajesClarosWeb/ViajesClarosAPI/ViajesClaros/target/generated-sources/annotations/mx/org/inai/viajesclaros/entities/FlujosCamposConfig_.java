package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(FlujosCamposConfig.class)
public abstract class FlujosCamposConfig_ {

	public static volatile SingularAttribute<FlujosCamposConfig, Integer> orden;
	public static volatile SingularAttribute<FlujosCamposConfig, Boolean> listaHabilitada;
	public static volatile SingularAttribute<FlujosCamposConfig, FlujosCamposConfigPK> flujosCamposConfigPK;
	public static volatile SingularAttribute<FlujosCamposConfig, Boolean> soloLectura;
	public static volatile SingularAttribute<FlujosCamposConfig, SeccionesFormulario> idSeccionFormulario;
	public static volatile SingularAttribute<FlujosCamposConfig, String> clase;
	public static volatile SingularAttribute<FlujosCamposConfig, FlujosTrabajo> flujosTrabajo;
	public static volatile SingularAttribute<FlujosCamposConfig, Short> obligatorio;
	public static volatile SingularAttribute<FlujosCamposConfig, String> etiqueta;
	public static volatile SingularAttribute<FlujosCamposConfig, String> subtipo;

}

