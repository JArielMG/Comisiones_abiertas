
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
    
    this.getHotelesMasVisitados = function () {
        var url = config.restUrl + "grafica/getHotelesMasVisitados/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaTipoViaje = function() {
        var url = config.restUrl + "grafica/getGraficaTipoViaje/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaTipoPasaje = function() {
        var url = config.restUrl + "grafica/getGraficaTipoPasaje/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaAerolineas = function() {
        var url = config.restUrl + "grafica/getGraficaAerolineas/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaCdInternacionales = function() {
        var url = config.restUrl + "grafica/getGraficaCiudadesInternacionales/" + getIdDependencia();
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
        var url = config.restUrl + "grafica/getUltimosViajesPorUnidad/" + idUnidad;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getGraficaViajesPorMes = function() {
        var url = config.restUrl + "grafica/getGraficaViajesPorMes/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getTotalViaticos = function() {
        var url = config.restUrl + "grafica/getTotalViaticos/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getTotalGasto = function() {
        var url = config.restUrl + "util/totalGastoByDependencia/" + getIdDependencia();
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
    
}]);