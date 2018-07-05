
/**
 * Servicio para obtener los datos vía RESTful
 */
myApp.service('ViajeService', ['$http', 'config', '$log', '$rootScope',
    function ($http, config, $log, $rootScope) {
        
    /**
     * Obtiene los datos del viaje
     * @returns promesa
     */
    this.getResumenViaje = function(idViaje) {
        var url = config.restUrl + "viaje/getResumenById/" + idViaje;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getFuncionarioByIdViaje = function(idViaje) {
        var url = config.restUrl + "funcionario/getByIdViaje/" + idViaje;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'comision'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosComision = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "comision"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'evento'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosEvento = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "evento"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'funcionario
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosFuncionario = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "funcionario"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'informacion_vuelo'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosVuelo = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "informacion_vuelo"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'informe_comision'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosInforme = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "informe_comision"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'observaciones'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosObservaciones = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "observaciones"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'tipo_viaje'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosTipoViaje = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "tipo_viaje"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los datos de la categoría 'viaticos'
     * @param {type} idViaje
     * @returns {unresolved}
     */
    this.getDatosViaticos = function(idViaje) {
        var simpleObject = {id: idViaje, codigo: "viaticos"};
        var url = config.restUrl + "viaje/getDatosPorCategoria/";
        var promise = $http.post(url, simpleObject).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);