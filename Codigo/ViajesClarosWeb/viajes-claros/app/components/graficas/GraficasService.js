
/**
 * Servicio para obtener los datos de la BD vía RESTful services, para la pantalla de gráficas
 **/
myApp.service('GraficasService', ['$http', '$log', '$rootScope', 'config', 
    function ($http, $log, $rootScope, config) {

    /* Obtiene el id de la dependencia seleccionada */
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
    
    this.getHotelesMasVisitados = function () {
        var url = config.restUrl + "grafica/getHotelesMasVisitados/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaTipoViaje = function() {
        var url = config.restUrl + "grafica/getGraficaTipoViaje/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaTipoPasaje = function() {
        var url = config.restUrl + "grafica/getGraficaTipoPasaje/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaAerolineas = function() {
        var url = config.restUrl + "grafica/getGraficaAerolineas/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaCdInternacionales = function() {
        var url = config.restUrl + "grafica/getGraficaCiudadesInternacionales/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaCdNacionales = function() {
        var url = config.restUrl + "grafica/getGraficaCiudadesNacionales/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getUnidadesAdministrativas = function() {
        var url = config.restUrl + "grafica/getUnidadesAdministrativas";
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    }
    
    this.getGraficaViajesPorUnidad = function(idUnidad) {
        var url = config.restUrl + "grafica/getUltimosViajesPorUnidad/" + idUnidad+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaViajesPorMes = function() {
        var url = config.restUrl + "grafica/getGraficaViajesPorMes/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getTotalViaticos = function() {
        var url = config.restUrl + "grafica/getTotalViaticos/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getTotalPasajes = function() {
        var url = config.restUrl + "grafica/getTotalPasajes/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getTotalGasto = function() {
        var url = config.restUrl + "util/totalGastoByDependenciaAnio/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficasParam = function() {
        var url = config.restUrl + "grafica/getGraficasParametrizadas/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.countViajes = function(dependencia) {
        var url = config.restUrl + "util/totalViajesByDependenciaAnio/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);