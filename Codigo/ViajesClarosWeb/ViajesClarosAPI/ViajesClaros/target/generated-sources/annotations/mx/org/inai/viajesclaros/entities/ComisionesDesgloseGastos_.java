package mx.org.inai.viajesclaros.entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(ComisionesDesgloseGastos.class)
public abstract class ComisionesDesgloseGastos_ {

	public static volatile SingularAttribute<ComisionesDesgloseGastos, String> campo;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, Comisiones> idComision;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, RegistrosGastosComision> idRegistroGastoComision;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, Date> valorFecha;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, Double> valorNumerico;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, String> valorTexto;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, Integer> idDesgloseGastos;
	public static volatile SingularAttribute<ComisionesDesgloseGastos, String> tabla;

}

