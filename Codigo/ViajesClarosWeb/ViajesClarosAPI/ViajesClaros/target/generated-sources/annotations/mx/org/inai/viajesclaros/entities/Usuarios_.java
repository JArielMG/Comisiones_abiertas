package mx.org.inai.viajesclaros.entities;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Usuarios.class)
public abstract class Usuarios_ {

	public static volatile SingularAttribute<Usuarios, Dependencias> idDependencia;
	public static volatile SingularAttribute<Usuarios, String> usuario;
	public static volatile SingularAttribute<Usuarios, String> idBonita;
	public static volatile SingularAttribute<Usuarios, String> descripcion;
	public static volatile SingularAttribute<Usuarios, String> contrasena;
	public static volatile SingularAttribute<Usuarios, Perfiles> idPerfil;
	public static volatile CollectionAttribute<Usuarios, JerarquiaMiembros> jerarquiaMiembrosCollection;
	public static volatile SingularAttribute<Usuarios, Integer> idUsuario;
	public static volatile SingularAttribute<Usuarios, Boolean> habilitado;
	public static volatile SingularAttribute<Usuarios, Boolean> jefeArea;
	public static volatile SingularAttribute<Usuarios, Areas> idArea;
	public static volatile SingularAttribute<Usuarios, Integer> intentos;
	public static volatile CollectionAttribute<Usuarios, SesionesLogin> sesionesLoginCollection;
	public static volatile CollectionAttribute<Usuarios, Comisiones> comisionesCollection;
	public static volatile SingularAttribute<Usuarios, Personas> idPersona;
	public static volatile SingularAttribute<Usuarios, String> salt;

}

