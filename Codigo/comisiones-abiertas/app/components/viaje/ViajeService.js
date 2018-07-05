
/**
 * Servicio para obtener los datos vía RESTful
 */
myApp.service('ViajeService', ['$http', 'config', '$log', '$rootScope',
    function ($http, config, $log, $rootScope) {
    
	function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 4;
        }
    }
	
	function getAnioSeleccionado() {
        if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!=''&&$rootScope.anioConsulta!='todos los años')
    		return $rootScope.anioConsulta;
    	else if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta=='todos los años')
    		return 0;
    	else
    		return new Date().getFullYear();
    }
	
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
    
	this.getUltimosViajes = function(dependencia) {
		var url = config.restUrl + "grafica/getUltimosViajes/" + getIdDependencia();
		var promise = $http.get(url).then(function (response) {
			return response.data;
		});
		return promise;
	};
	
	this.getUltimosViajesTitulares = function(dependencia) {
		var url = config.restUrl + "grafica/getUltimosViajesTitulares/" + getIdDependencia();
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
	
	this.getFuncionariosMayorGastoTitulares = function(dependencia) {
			var url = config.restUrl + "grafica/getFuncionariosMayorGastoTitulares/" + getIdDependencia()+','+getAnioSeleccionado();
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
	
	this.getFuncionariosMasViajesTitulares = function(dependencia) {
			var url = config.restUrl + "grafica/getFuncionariosMasViajesTitulares/" + getIdDependencia()+','+getAnioSeleccionado();
			var promise = $http.get(url).then(function (response) {
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
    
	this.getFuncionarioById = function (funcionario) {
		var url = config.restUrl + "funcionario/getById";
		var promise = $http.post(url, funcionario).then(function (response) {
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