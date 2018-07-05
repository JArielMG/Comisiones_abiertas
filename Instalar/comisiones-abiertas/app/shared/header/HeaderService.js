
/**
 * Servicio para el encabezado
 */
myApp.service('HeaderService', ['$rootScope','$http', 'config', function ($rootScope, $http, config) {
    
    this.getDependencias = function() {
        var url = config.restUrl + "dependencia";
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    
    /* Obtiene el anio seleccionado */
    function getAnioSeleccionado() {
        if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!=''&&!isNaN($rootScope.anioConsulta)){
    		return $rootScope.anioConsulta;
    	}else if ($rootScope.anioConsulta!=null&&isNaN($rootScope.anioConsulta)){
    		return 0;
    	}else{
    		return new Date().getFullYear();
    	}
    }
    
	function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 4;
        }
    }
	
    /**
     * Obtiene los funcionarios de la dependencia actual seleccionada
     */
    this.getFuncionarios = function() {
        var url = config.restUrl + "funcionario/getAllResumen/"+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getPorcentajeDiasComisionFuncionario = function(funcionarioObj) {
        var url = config.restUrl + "funcionario/getPorcentajeDiasComision/"+getAnioSeleccionado();
        var promise = $http.post(url, funcionarioObj).then(function (response) {
            return response.data;
        });
        return promise;
    };
	
	this.getComplementariosPerfil = function (funcionarioObj) {
		var url = config.restUrl + "funcionario/getComplementariosPerfilPorFuncionario/"+getAnioSeleccionado();
		var promise = $http.post(url, funcionarioObj).then(function (response) {
			return response.data;
		});
		return promise;
	};
	
	this.getDiasTrabajados = function (funcionarioObj) {
		var url = config.restUrl + "funcionario/getDiasTrabajadosComisNacionales/"+getAnioSeleccionado();
		var promise = $http.post(url, funcionarioObj).then(function (response) {
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
    
}]);
