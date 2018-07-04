
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
            var url = config.restUrl + "funcionario/getResumenById";
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
            var url = config.restUrl + "viaje/getViajesByFuncionario";
            var promise = $http.post(url, funcionario).then(function (response) {
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
            var url = config.restUrl + "funcionario/getPorcentajeDiasComision";
            var promise = $http.post(url, funcionario).then(function (response) {
                return response.data;
            });
            return promise;
        };

        this.getGraficaViaticosPorFuncionario = function (funcionario) {
            var url = config.restUrl + "grafica/getGraficaViaticosPorFuncionario";
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
            var url = config.restUrl + "viaje/getUbicacionesPorFuncionario";
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
        this.getViajesOnMarker = function(ciudad, pais) {
            var url = config.restUrl + "viaje/getViajesPorCiudadPais";
            var viaje = {idDependencia: getIdDependencia(), ciudadDestino: ciudad, paisDestino: pais};
            var promise = $http.post(url, viaje).then(function (response) {
                return response.data;
            });
            return promise;
        };

    }]);