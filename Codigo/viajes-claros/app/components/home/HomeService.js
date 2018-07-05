
/**
 * Servicio para obtener los datos de la BD vía RESTful services,
 * para la pantalla de inicio
 **/
myApp.service('HomeService', ['$rootScope', '$http', '$log', 'config', function ($rootScope, $http, $log, config) {
    
    /* Obtiene el id de la dependencia seleccionada */
    function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 4;
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
    
    this.countViajes = function(dependencia) {
        var url = config.restUrl + "util/totalViajesByDependenciaAnio/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.totalViaticos = function(dependencia) {
        var url = config.restUrl + "util/totalGastoByDependenciaAnio/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getFuncionariosMayorGasto = function(dependencia) {
        var url = config.restUrl + "grafica/getFuncionariosMayorGasto/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getFuncionariosMasViajes = function(dependencia) {
        var url = config.restUrl + "grafica/getFuncionariosMasViajes/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getUltimosViajes = function(dependencia) {
        var url = config.restUrl + "grafica/getUltimosViajes/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getUbicaciones = function() {
        var url = config.restUrl + "viaje/getUbicacionesPorDependencia/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getViajesOnMarker = function(ciudad, pais) {
        var url = config.restUrl + "viaje/getViajesPorCiudadPais/"+getAnioSeleccionado();
        var viaje = {idDependencia: getIdDependencia(), ciudadDestino: ciudad, paisDestino: pais};
        var promise = $http.post(url, viaje).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);