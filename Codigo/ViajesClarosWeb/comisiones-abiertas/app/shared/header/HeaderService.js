
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
    
}]);
