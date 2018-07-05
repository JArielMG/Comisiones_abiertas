
/**
 * Servicio para obtener los datos del funcionario vía RESTful
 */
myApp.service('ShowFuncionarioService', ['$http', 'config', '$log', '$rootScope',
    function ($http, config, $log, $rootScope) {

    function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 1;
        }
    }
    
    /* Obtiene el anio seleccionado */
    function getAnioSeleccionado() {
        if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!=''&&$rootScope.anioConsulta!='todos los años')
    		return $rootScope.anioConsulta;
    	else if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta=='todos los años')
    		return 0;
    	else
    		return new Date().getFullYear();
    }

        /**
         * Obtiene los datos del funcionario
         * @param {type} idFuncionario
         * @returns {unresolved}
         */
        this.getFuncionarioById = function (funcionario) {
            var url = config.restUrl + "funcionario/getById";
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };

        /**
         * obtiene los datos que se muestran en el resumen (total gasto, total viajes...)
         * @param {type} idFuncionario
         * @returns {undefined}
         */
        this.getFuncionarioResumen = function (funcionario) {
            var url = config.restUrl + "funcionario/getResumenById/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };
        
        /**
         * obtiene el cargo de funcionario
         * @param {type} idFuncionario
         * @returns {undefined}
         */
        this.getCargoFuncionario = function (funcionario) {
            var url = config.restUrl + "funcionario/getCargoFuncionario";
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };

        /**
         * Obtiene la lista de viajes del funcionario
         * @param {type} idFuncionario
         * @returns {unresolved}
         */
        this.getViajesByFuncionario = function (funcionario) {
            var url = config.restUrl + "viaje/getViajesByFuncionario/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionario).then(function (response) {
            	angular.forEach(response.data, function (viajes) {
		  viajes.costoTotal = parseFloat(viajes.costoTotal);
		  var fechaInicioArray = viajes.fechaInicio.split('/');
		  var fechaFinArray = viajes.fechaFin.split('/');
		  viajes.fechaInicio = new Date(parseInt(fechaInicioArray[2]),parseInt(fechaInicioArray[1])-1,parseInt(fechaInicioArray[0]));
  		  viajes.fechaFin = new Date(parseInt(fechaFinArray[2]),parseInt(fechaFinArray[1])-1,parseInt(fechaFinArray[0]));
		});
                return response.data;
            });
            return promise;
        };

        /**
         * Obtiene los encabezados de la tabla de resultados
         * @param {type} dependencia
         */
        this.getEncabezados = function (idDependencia) {
            var idDep = 1;
            if (typeof idDependencia !== "undefined") {
                idDep = idDependencia;
            }
            var url = config.restUrl + "busqueda/encabezados/" + idDep;
            var promise = $http.get(url).then(function (response) {
                return response.data;
            });
            return promise;
        };

        this.getPorcentajeDiasComisionFuncionario = function (funcionario) {
            var url = config.restUrl + "funcionario/getPorcentajeDiasComision/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };

        this.getGraficaViaticosPorFuncionario = function (funcionario) {
            var url = config.restUrl + "grafica/getGraficaViaticosPorFuncionario/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };

        /**
         * Realiza la suscripción para recibir información de viajes del funcionario
         * @param {type} idFuncionario
         * @param {type} email
         * @returns {undefined}
         */
        this.suscribe = function (funcionario, email) {
            funcionario.email = email;
            var url = config.restUrl + "funcionario/suscribe";
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };
        
        /**
         * Obtiene las ubicaciones para pintar los marcadores en el mapa
         * @param {type} funcionario
         * @returns {unresolved}
         */
        this.getUbicaciones = function(funcionario) {
            var url = config.restUrl + "viaje/getUbicacionesPorFuncionario/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };
        
        /**
         * Obtiene todos los viajes de laubicación seleccionada del mapa
         * @param {type} ciudad
         * @param {type} pais
         * @returns {unresolved}
         */
        this.getViajesOnMarker = function(funcionario, ciudad, pais) {
            var url = config.restUrl + "viaje/getViajesPorCiudadPaisFuncionario/"+getAnioSeleccionado();
            var viaje = {idFuncionario: funcionario.id, nombres: funcionario.nombres, apellido1: funcionario.apellido1, apellido2: funcionario.apellido2, ciudadDestino: ciudad, paisDestino: pais};
            var promise = $http.post(url, viaje).then(function (response) {
                return response.data;
            });
            return promise;
        };

    }]);