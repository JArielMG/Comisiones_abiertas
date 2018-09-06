# Manual de Instalación
  
## I.	Instalación del Sitio Web Viajes Claros y Buscador

### Prerrequisitos

1.	Tener instalado un servidor de base de datos MySQL 5.5
2.	Tener instalado un servidor Apache
3.	JDK 1.7 o superior
4.	Usuario del sistema con permisos de administrador.
5.	Tener instalado el servidor de aplicaciones Glassfish 4.1
6.	Haber configurado en el servidor de aplicaciones el recurso JDBC con el nombre jndiViajesClaros, con el acceso a la base de datos.
7.	Contar con el archivo ViajesClaros.war que es la API para el sistema web que será instalada en el servidor.
8.	Contar con el archivo viajes-claros.zip, que es el sistema web (HTML).

### Instalación de la API

* Acceder al servidor (Linux Red Hat 6.4) por medio de SSH y dirigirse a la ruta donde se encuentran los archivos. 
	
	  [root@localhost /]# cd /root/viajes_claros_web/

*	Dar de baja el servicio de Glassfish.
	
	    [root@localhost /]# sh /opt/glassfish4/glassfish/bin/stopserv &

*	Copiar el archivo ViajesClaros.war a la ruta donde se encuentra el Glassfish.
	
        [root@localhost /viajes_claros_web]# cp ViajesClaros.war /opt/glassfish4/glassfish/domains/domain1/autodeploy/

*	Verificar la configuración para los property (user, password, porNumber, databaseName y serverName) del archivo domain.xml ubicado en /opt/glassfish4/glassfish/domains/domain1/config

        <jdbc-connection-pool name="JDBCViajesClaros" res-type="javax.sql.DataSource" datasource-classname="com.mysql.jdbc.jdbc2.optional.MysqlDataSource">
          <property name="user" value="viajes_admin"/>
          <property name="password" value="PASSWORD_VALUE"/>
          <property name="portNumber" value="PORT_NUMBER"/>
          <property name="databaseName" value="viajes_claros"></property>
          <property name="serverName" value="SERVER_NAME"></property>
        </jdbc-connection-pool>
        <jdbc-resource pool-name=" JDBCViajesClaros " description="Pool de Conexión a Viajes Claros" jndi-name="jndiViajesClaros"></jdbc-resource>

    Donde los valores del password, puerto y el server son representados por valores DUMMY a reemplazar por los valores que le correspondan en el ambiente.

*	Debajo de las líneas anteriores agregar la siguiente configuración:

        <jdbc-connection-pool driver-classname="com.mysql.jdbc.Driver" name="ViajesSoloLectura" res-type="java.sql.Driver">
            <property name="password" value="PASSWORD_VALUE"></property>
            <property name="user" value="viajes_lectura"></property>
            <property name="URL" value="jdbc:mysql://SERVER_NAME: PORT_NUMBER /viajes_claros"></property>
          </jdbc-connection-pool>
        <jdbc-resource pool-name="ViajesSoloLectura" description="Pool de Solo Lectura Viajes Claros" jndi-name="jndiViajesLectura"></jdbc-resource>

Donde los valores del password, puerto y el server son representados por valores DUMMY a reemplazar por los valores que le correspondan en el ambiente.

  Nota: Verificar la configuración para los property (user, password, URL)

*	En el archivo domain.xml ubicar la siguiente línea y actualizar el tamaño de la memoria a 512m en la propiedad -XX:MaxPermSize

        <jvm-options>-XX:MaxPermSize=512m</jvm-options>

*	En el archivo domain.xml ubicar la siguiente línea y actualizar el valor a –Xmx1024m

        <jvm-options>-Xmx1024m</jvm-options>

*	Guardar los cambios y levantar el servicio de Glassfish, la API de Viajes Claros se instalará automáticamente.

	      [root@localhost /]# sh /opt/glassfish4/glassfish/bin/startserv &

Nota: Como alternativa para levantar el servicio de Glassfish se puede ejecutar el comando /asadmin start-domain dentro de /apps/viajesclaros/glassfish4/glassfish/bin/

###	Instalación del sistema web

*	Acceder al servidor (Linux Red Hat 6.4) por medio de SSH y dirigirse a la ruta donde se encuentran los archivos. 
	
	      [root@localhost /]# cd /root/viajes_claros_web

*	Copiar el archivo comisiones-abiertas.zip a la carpeta de Apache.
	
	      [root@localhost /viajes_claros_web]#  cp comisiones-abiertas.zip /var/www/html/

*	Ir a la carpeta de Apache y descomprimir el archivo.

        [root@localhost /]#  cd /var/www/html/
        [root@localhost /]#  unzip comisiones-abiertas.zip

*	Eliminar el archivo comisiones-abiertas.zip

	      [root@localhost /]#  rm comisiones-abiertas.zip

###	Configuraciones adicionales

*	Para verificar que la URL de la API esté correctamente configurada, editar el archivo app.constant

	      [root@localhost /]#  nano /var/www/html/comisiones-abiertas/app/app.constant.js

*	Verificar que la configuración de la URL sea:

        myApp.constant('config', {
           restUrl: "http://localhost:9080/ViajesClaros/webresources/"
        });

    Nota: reemplazar localhost por la ip del equipo correspondiente.

*	Para salir del editor: Control + X

###	Validación

*	Acceder al sistema, en un navegador, con la ruta:
  
        http://IP_DEL_SERVIDOR/comisiones-abiertas


## II.	Instalación del Parametrizador

###	Prerrequisitos
1.	Tener instalado un servidor de base de datos MySQL 5.5
2.	JDK 1.7 o superior
3.	Usuario del sistema con permisos de administrador.
4.	Tener instalado el servidor de aplicaciones Glassfish 4.1
5.	Haber configurado en el servidor de aplicaciones el recurso JDBC con el nombre jndiViajesClaros, con el acceso a la base de datos.
6.	Contar con el archivo ViajesClarosAdmin-web.war que es el sistema parametrizador que será instalado en el servidor.
7.	Contar con el conector mysql-connector-java-5.1.35-bin.jar para la conexión de la base de datos.

###	Instalación 
*	Acceder al servidor (Linux Red Hat 6.4) por medio de SSH y dirigirse a la ruta donde se encuentra el 	archivo .war. 
	
	    [root@localhost /]# cd /root/viajes_claros_web/

*	Dar de baja el servicio de Glassfish.
	
	    [root@localhost /]# sh /opt/glassfish4/glassfish/bin/stopserv &

*	Copiar el archivo ViajesClarosAdmin-web.war a la ruta donde se encuentra el servidor de aplicaciones Glassfish.
	
        [root@localhost /viajes_claros_web]# cp ViajesClarosAdmin-web.war /opt/glassfish4/glassfish/domains/domain1/autodeploy/

*	Copiar el archivo mysql-connector-java-5.1.35-bin.jar a la ruta /opt/glassfish4/glassfish/domains/domain1/lib

        [root@localhost /viajes_claros_web]# cp mysql-connector-java-5.1.35-bin.jar /opt/glassfish4/glassfish/domains/domain1/lib

*	Levantar el servicio de Glassfish, el sistema parametrizador se instalará automáticamente.

	    [root@localhost /]# sh /opt/glassfish4/glassfish/bin/startserv &

###	Validación
*	Acceder al sistema, en un navegador, con la ruta:
	
	    http://localhost:9080/ViajesClarosAdmin-web

*	Ingresar con los datos (únicamente aplica para el ambiente de calidad):

        Usuario: admin
        Contraseña: admin
	
	
## III.	Instalación Gestión de Viajes de Trabajo

###	Prerrequisitos

Tener instalada una instancia de MySql 5.5, JDK 1.7.X o superior, herramientas para descomprimir archivos (WinZip p WinRar) y un usuario con privilegios suficientes para realizar la instalación (por ejemplo, root). Considerar los prerrequisitos de Bonita publicados en su portal, pero se anexa archivo adicional de referencia, llamado: Bonita - HW SW Requirements.pdf.

### Instalación

El archivo “viajes_claros_install.zip” contiene los instaladores de las herramientas y las aplicaciones, y al descomprimir este archivo se encuentra la siguiente carpeta:
            
    /install

La cual, a su vez contiene las carpetas:

    /app
    /installers
    /libs
    /scripts
    /workflows

Ahora se sigue el presente proceso para realizar la instalación completa del producto.

  *	Conectarse a la base de datos de MySQL con las credenciales necesarias:
    Crear las bases de datos siguientes (cumplir con las minúsculas):
    -	bonita
    -	business_data
    -	viajes_claros
  *	Crear los siguientes usuarios de base de datos (cumplir con las minúsculas) y sus accesos a bases de datos:
    -	bonita : "Acceso a completo a BD bonita y BD business_data"
    - viajes_admin :	"Acceso completo a BD viajes_claros"
    - viajes_lectura : "Acceso restringido (select, execute y show view) a la BD viajes_claros"

  Nota: en caso de que las Bases de Datos se encuentren en el mismo servidor que el aplicativo otorgar a los usuarios los permisos: local, 127.0.0.1 y el nombre del servidor.

* Conectarse el servidor que hospedará la aplicación (Linux Red Hat 6.4) con usuario con suficientes privilegios para modificar archivos de sistema (perfiles y MySQL) e instalar aplicaciones.

      [root@localhost ~]#

* Dirigirse una carpeta de trabajo donde se descargarán los archivos para la instalación de la aplicación:

      [root@localhost /]# cd tmp
      [root@localhost tmp]# pwd
      /tmp
      [root@localhost tmp]# cp /root/viajes_claros_install.zip .
      [root@localhost tmp]# ls -ltr viajes_claros_install.zip
      -rw-r--r--. 1 root root 104175386 viajes_claros_install.zip
      [root@localhost tmp]#

*	Descomprimir el archivo copiado en la ruta actual para tener disponibles los archivos de instalación:

        [root@localhost tmp]# unzip viajes_claros_install.zip

        Archive:  /root/viajes_claros_install.zip
         creating: Install/
         creating: Install/app/
        inflating: Install/app/INAI_Viajes_Comisiones.war  
        inflating: Install/app/ViajesClaros.war  
        inflating: Install/app/ViajesClarosAdmin-web.war  
         creating: Install/installers/
        inflating: Install/installers/Bonita-7.1.2_Tomcat-7.0.55.zip  
         creating: Install/libs/
        inflating: Install/libs/commons-beanutils-1.9.2.jar  
        inflating: Install/libs/mysql-connector-java-5.1.37-bin.jar  
        inflating: Install/libs/shiro-core-1.2.4.jar  
        inflating: Install/libs/shiro-quartz-1.2.4.jar  
        inflating: Install/libs/shiro-tools-hasher-1.2.4-cli.jar  
        inflating: Install/libs/shiro-web-1.2.4.jar  
         creating: Install/scripts/
        inflating: Install/scripts/bonita_script.sql  
        inflating: Install/scripts/funciones.sql  
        inflating: Install/scripts/initial.sql  
        inflating: Install/scripts/viajes_claros_script.sql

        [root@localhost tmp]#

*	Se ingresa a la subcarpeta de “Install/scripts” para poder ejecutarlos. En primera instancia se ejecuta el script “viajes_claros_script.sql” con el usuario root, esto permitirá la creación de todas las tablas, funciones y procedimientos almacenados necesarios para la aplicación. 

        [root@localhost tmp]# cd Install/scripts
        [root@localhost scripts]# ls -ltr
        total 30
        -rw-r--r--. 1 root root 19701 viajes_claros_script.sql
        [root@localhost scripts]# mysql -u root -p < viajes_claros_script.sql
        Enter password: 
        [root@localhost scripts]#

*	Ejecutar el script primeracarga.sql, ubicado en la carpeta “Install/scripts”, para el llenado de los datos básicos en la BD.

        [root@localhost scripts]# mysql -u root -p < primeracarga.sql
        Enter password: 
        [root@localhost scripts]#

*	Modificar el archivo /etc/my.cnf para ampliar el tamaño de los paquetes enviados. Reiniciar el servicio mysqld para aplicar este cambio.

        [mysqld]
        datadir=/var/lib/mysql
        socket=/var/lib/mysql/mysql.sock
        max_allowed_packet=256M

        [root@localhost scripts]# /etc/init.d/mysqld restart
        Stopping mysqld:                                           [  OK  ]
        Starting mysqld:                                           [  OK  ]
        [root@localhost scripts]#

        mysql> Select @@global.max_allowed_packet;
        +-----------------------------+
        | @@global.max_allowed_packet |
        +-----------------------------+
        |                   268435456 |
        +-----------------------------+
        1 row in set (0.00 sec)

*	Ahora descomprimir el archivo “Install/installers/Bonita-7.1.2_Tomcat-7.0.55.zip” en /etc y renombrar la carpeta al siguiente nombre “Bonita-Tomcat-7”, o establecer otro nombre.

        [root@localhost scripts]# cd /etc
        [root@localhost scripts]# unzip /tmp/Install/installers/Bonita-7.1.2_Tomcat-7.0.55.zip
        [root@localhost etc]# mv BonitaBPMCommunity-7.1.2-Tomcat-7.0.55 Bonita-Tomcat-7
        [root@localhost etc]# cd B*
        [root@localhost Bonita-Tomcat-7]# pwd
        /etc/Bonita-Tomcat-7
        [root@localhost Bonita-Tomcat-7]#

*	Agregar la variable de ambiente CATALINA_HOME apuntando a la carpeta donde se descomprimió el Tomcat con Bonita

        export CATALINA_HOME=/etc/Bonita-Tomcat-7

*	En la carpeta $CATALINA_HOME, modificar el archivo bin/setenv.sh para modificar las variables “sysprop.bonita.db.vendor” y “Dsysprop.bonita.bdm.db.vendor” y establecer mysql como el proveedor de base de datos.
    
        Define the RDMBS vendor use by Bonita Engine to store data
        DB_OPTS="-Dsysprop.bonita.db.vendor=mysql"

        Define the RDMBS vendor use by Bonita Engine to store Business Data
        If you use different DB engines by tenants, please update directly bonita-tenant-community-custom.properties
        BDM_DB_OPTS="-Dsysprop.bonita.bdm.db.vendor=mysql"

*	Copiar las librerías de la carpeta de instalación “Install/libs” a la carpeta $CATALINA_HOME/lib

        [root@localhost Install]# cd /etc/Bonita-Tomcat-7/lib
        [root@localhost lib]# cp /tmp/Install/libs/* .
        [root@localhost lib]# ls -ltr *.jar
        -rw-r--r--. 1 root root   36155 Jul 18  2014 websocket-api.jar
        -rw-r--r--. 1 root root   29458 Jul 18  2014 tomcat-util.jar
        -rw-r--r--. 1 root root  125457 Jul 18  2014 tomcat-jdbc.jar
        -rw-r--r--. 1 root root   47037 Jul 18  2014 tomcat-i18n-ja.jar
        -rw-r--r--. 1 root root   43799 Jul 18  2014 tomcat-i18n-fr.jar
        -rw-r--r--. 1 root root   71913 Jul 18  2014 tomcat-i18n-es.jar
        -rw-r--r--. 1 root root  234042 Jul 18  2014 tomcat-dbcp.jar
        -rw-r--r--. 1 root root  846113 Jul 18  2014 tomcat-coyote.jar
        -rw-r--r--. 1 root root    6142 Jul 18  2014 tomcat-api.jar
        -rw-r--r--. 1 root root  180506 Jul 18  2014 tomcat7-websocket.jar
        -rw-r--r--. 1 root root  197876 Jul 18  2014 servlet-api.jar
        -rw-r--r--. 1 root root   87808 Jul 18  2014 jsp-api.jar
        -rw-r--r--. 1 root root  602458 Jul 18  2014 jasper.jar
        -rw-r--r--. 1 root root  124147 Jul 18  2014 jasper-el.jar
        -rw-r--r--. 1 root root   55426 Jul 18  2014 el-api.jar
        -rw-r--r--. 1 root root 2298872 Jul 18  2014 ecj-4.4.jar
        -rw-r--r--. 1 root root  256780 Jul 18  2014 catalina-tribes.jar
        -rw-r--r--. 1 root root 1598533 Jul 18  2014 catalina.jar
        -rw-r--r--. 1 root root  132888 Jul 18  2014 catalina-ha.jar
        -rw-r--r--. 1 root root   53445 Jul 18  2014 catalina-ant.jar
        -rw-r--r--. 1 root root   15978 Jul 18  2014 annotations-api.jar
        -rw-r--r--. 1 root root  233859 Nov  6 17:50 commons-beanutils-1.9.2.jar
        -rw-r--r--. 1 root root  985603 Nov  6 17:50 mysql-connector-java-5.1.37-bin.jar
        -rw-r--r--. 1 root root   12391 Nov  6 17:50 shiro-quartz-1.2.4.jar
        -rw-r--r--. 1 root root  379541 Nov  6 17:50 shiro-core-1.2.4.jar
        -rw-r--r--. 1 root root  146970 Nov  6 17:50 shiro-web-1.2.4.jar
        -rw-r--r--. 1 root root  454894 Nov  6 17:50 shiro-tools-hasher-1.2.4-cli.jar
        [root@localhost lib]#

*	Modificar el archivo $CATALINA_HOME/conf/bitronix-resources.properties para ajustar los orígenes de datos de Bonita BPM.

        #MySQL 
        resource.ds1.className=com.mysql.jdbc.jdbc2.optional.MysqlXADataSource
        resource.ds1.driverProperties.user=bonita
        resource.ds1.driverProperties.password=bpm
        resource.ds1.driverProperties.URL=jdbc:mysql://localhost:3306/bonita?dontTrackOpenResources=true&useUnicode=true&characterEncoding=UTF-8
        resource.ds1.testQuery=SELECT 1

        #MySQL 
        resource.ds2.className=com.mysql.jdbc.jdbc2.optional.MysqlXADataSource
        resource.ds2.driverProperties.user=bonita
        resource.ds2.driverProperties.password=bpm
        resource.ds2.driverProperties.URL=jdbc:mysql://localhost:3306/business_data?dontTrackOpenResources=true&useUnicode=true&characterEncoding=UTF-8
        resource.ds2.testQuery=SELECT 1

      Nota: Es importante comentar todas las referencias ds1 y ds2 para h2.

        #H2 example 
        #resource.ds1.className=org.h2.jdbcx.JdbcDataSource
        #resource.ds1.driverProperties.user=sa
        #resource.ds1.driverProperties.password=
        #resource.ds1.driverProperties.URL=jdbc:h2:tcp://localhost:9091/bonita_journal.db;MVCC=TRUE;DB_CLOSE_ON_EXIT=TRUE;IGNORECASE=TRUE;
        #resource.ds1.testQuery=SELECT 1

        #resource.ds2.className=org.h2.jdbcx.JdbcDataSource
        #resource.ds2.driverProperties.user=sa
        #resource.ds2.driverProperties.password=
        #resource.ds2.driverProperties.URL=jdbc:h2:tcp://localhost:9091/business_data.db;MVCC=TRUE;DB_CLOSE_ON_EXIT=TRUE;IGNORECASE=TRUE;
        #resource.ds2.testQuery=SELECT 1 

*	Modificar el archivo $CATALINA_HOME/conf/context.xml para agregar el datasource de la base de datos operativa de viajes_claros.
    
        <Context>
        …
        <Resource name="INAI_Viajes_DS" auth="Container" type="javax.sql.DataSource"
                           maxActive="100" maxIdle="30" maxWait="10000"
                           username="viajes_admin" password="admin" driverClassName="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/viajes_claros"/>
        </Context>

*	Modificar el archivo $CATALINA_HOME/conf/Catalina/localhost/bonita.xml para ajustar los orígenes de datos que utilizará la instancia de bonita. 

  Nota: Los Orígenes de Datos de H2 que predeterminadamente se encuentran habilitados en este archivo, deben ser comentados para evitar errores al iniciar Tomcat en pasos posteriores.

      <!-- MySQL -->
          <Resource name="bonitaSequenceManagerDS"
                    auth="Container"
                    type="javax.sql.DataSource"
                    maxActive="17"
                    minIdle="5"
                    maxWait="10000"
                    initialSize="3"
                    maxPoolSize="15"
                    minPoolSize="3"
                    maxConnectionAge="0"
                    maxIdleTime="1800"
                    maxIdleTimeExcessConnections="120"
                    idleConnectionTestPeriod="30"
                    acquireIncrement="3"
                    validationQuery="SELECT 1"
                    validationInterval="30000"
                    testConnectionOnCheckout="true"
                    removeAbandoned="true"
                    logAbandoned="true"
                    username="bonita"
                    password="bpm"
                    driverClassName="com.mysql.jdbc.Driver"
      url="jdbc:mysql://localhost:3306/bonita?dontTrackOpenResources=true&amp;useUnicode=true&amp;characterEncoding=UTF-8"/>

      <Resource name="NotManagedBizDataDS"
                    auth="Container"
                    type="javax.sql.DataSource"
                    maxActive="17"
                    minIdle="5"
                    maxWait="10000"
                    initialSize="3"
                    maxPoolSize="15"
                    minPoolSize="3"
                    maxConnectionAge="0"
                    maxIdleTime="1800"
                    maxIdleTimeExcessConnections="120"
                    idleConnectionTestPeriod="30"
                    acquireIncrement="3"
                    validationQuery="SELECT 1"
                    validationInterval="30000"
                    testConnectionOnCheckout="true"
                    removeAbandoned="true"
                    logAbandoned="true"
                    username="bonita"
                    password="bpm"
                    driverClassName="com.mysql.jdbc.Driver"
      url="jdbc:mysql://localhost:3306/business_data?dontTrackOpenResources=true&amp;useUnicode=true&amp;characterEncoding=UTF-8"/>

*	Eliminar los JARs asociados al conector de base de datos predeterminado de Bonita en Tomcat.

          [root@localhost lib]# cd bonita
          [root@localhost bonita]# ls -ltr *h2*
          -rw-r--r--. 1 root root 1469903 Oct  6 16:45 h2-1.3.170.jar
          -rw-r--r--. 1 root root    4168 Oct  6 16:45 bonita-tomcat-h2-listener-1.0.1.jar
          [root@localhost bonita]# pwd
          /etc/Bonita-Tomcat-7/lib/bonita
          [root@localhost bonita]# rm *h2*
          rm: remove regular file `bonita-tomcat-h2-listener-1.0.1.jar'? y
          rm: remove regular file `h2-1.3.170.jar'? y
          [root@localhost bonita]#

*	Modificar el archivo $CATALINA_HOME/conf/server.xml para eliminar la referencia al Listener de H2.
  
          <!-- Comment the following line for production as h2 is not intended to be used in production. Note: h2 listening port can conflict if you run both Bonita BPM 
                Studio and a bundle on a single computer -->
          <!--<Listener className="org.bonitasoft.tomcat.H2Listener" tcpPort="9091" baseDir="${catalina.home}/bonita/engine-server/work/platform" start="true" />-->

*	Ejecutar Tomcat para crear el ambiente de Bonita.

          [root@localhost Bonita-Tomcat-7]# cd bin
          [root@localhost bin]# sh startup.sh

*	Cuando la primera instancia de bonita se crea, en la base de datos de “bonita” se crea un registro en la tabla “platform” que indica la creación el ambiente.

          mysql> use bonita
          Reading table information for completion of table and column names
          You can turn off this feature to get a quicker startup with -A

          Database changed
          mysql> select * from platform;
          +----+---------+-----------------+----------------+---------------+---------------+-------------+
          | id | version | previousVersion | initialVersion | created       | createdBy     | information |
          +----+---------+-----------------+----------------+---------------+---------------+-------------+
          |  1 | 7.1.2   |                 | 7.1.2          | 1446855825599 | platformAdmin | NULL        |
          +----+---------+-----------------+----------------+---------------+---------------+-------------+
          1 row in set (0.00 sec)

*	Dar de bajar el servidor de Tomcat, copiar las aplicaciones localizadas en la carpeta “Install/app” a la carpeta $CATALINA_HOME/webapps y volver a iniciar el servidor de Tomcat para que se carguen las aplicaciones de viajes claros.

*	Carga de Workflows, para realizar esta acción es necesario conectarse a la siguiente ruta desde dentro del servidor o su equivalente para accesos remotos: http://localhost:8080/bonita/login.jsp?redirectUrl=portal/homepage

*	Usar las credenciales install/install para acceder al sitio

*	En el menú Organization/Users, crear un usuario nuevo con el botón + Create

* Crear el usuario admin/admin y los identificadores necesarios para el mismo. 

      Nota 1: Este usuario será el administrador de todo el portal y podrá revisar las instancias de los WFs y realizar las posteriores instalaciones de este manual.

      Nota 2: Si se requiere asignar una nueva contraseña es necesario recompilar la aplicación.

      Nota 3: El password del usuario admin únicamente aplica para el ambiente de calidad, se sugiere utilizar otro password para el ambiente productivo

*	Ahora ir al menú Organizations/Profiles

* Seleccionar el perfil Administrator y dar click en el botón More…

* Dar click en el botón Add A User y agregar el usuario recién creado admin y dar click en Add

* Ir al menú BPM Services y dar clic en el botón Pause para pausar el servicio y poder cargar los archivos de configuración

* Confirmar la pausa del servicio

* Verificar que el botón Resume se activa, pero no ejecutarlo en este momento

* Ir al menú Business Data Model y en el campo para cargar archivo, seleccionar el archivo bdm.zip de la carpeta de instalación /workflows, dar clic en el botón Activate si el archivo es reconocido por el portal

* Ratificar la instalación del archivo cuando el mensaje de Advertencia aparezca

* Aparece un mensaje de éxito en la instalación, dar clic en el botón OK

* Ir al menú Organization Import / Export y en la sección Import an existing organization, cargar el archivo INAI.xml, de la carpeta de instalación /workflows

* Regresar al menú BPM Services y dar clic en el botón Resume, esto permitirá reanudar los servicios del Workflow y se podrán instalar los workflows de Viajes Claros

* Confirmar el mensaje de reactivación de Servicios

* Validar que el estatus del servicio es Running y el botón Pause es reactivado

* Hacer logout en la aplicación de Bonita BPM

* Volver a conectarse al portal de Bonita BPM usando las credenciales admin/admin, recordando que únicamente aplica para el ambiente de calidad.

* Ir al menú BPM/Processes y dar clic en el botón + Install

* Seleccionar el archivo Solicitud de Comision--1.0.bar de la carpeta de instalación /workflows e instalar el proceso

* Es probable que el Proceso se instale como inactivo, por lo que hay que seleccionarlo en el Proceso y dar clic en el botón More…

* Ir a la opción de Actors y validar que el usuarios, roles, grupos y miembros queden de la siguiente manera:

          Users: admin 
                 admin
          Roles: solicitantes 
                 aprobadores
          Groups: Generico
          Memberships: aprobadores of Generico
                       solicitantes of Generico

* Regresar a la opción General y en el botón Activation state, cambiar el estado de Disabled a Enabled

* Repetir el proceso para cada workflow siguiente y respetar el orden:

          - Solicitud de Viaticos (Solicitud de Viaticos--1.0.bar)
              - Los siguientes permisos aplican para Solicitud de viáticos y solicitud de comisión
          - Ingreso de Comprobantes (Ingreso de Comprobantes--1.0.bar)
          - Solicitud de Publicacion (Solicitud de Publicacion--1.0.bar)

* Validar que los cuatro procesos se encuentran listados en la opción Enabled

## Validación

    Ingresar a la ruta: http://localhost:8080/bonita para corroborar que el portal de Bonita es accesible correctamente. Ingresar con las credenciales install/install.
