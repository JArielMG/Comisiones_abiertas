
/**
 * Servicio para el controlador global
 */
myApp.service('GlobalService', ['$rootScope', '$http', 'config', '$log', function ($rootScope, $http, config, $log) {
     
    /**
     * Obtiene la dependencia seleccionada (default 1=INAI)
     */
    function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 1;
        }
    }
        
    /**
     * Obtiene los funcionarios de la dependencia actual seleccionada
     */
    this.getFuncionarios = function() {
        var url = config.restUrl + "funcionario/getAllResumen";
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    this.getPorcentajeDiasComisionFuncionario = function(funcionarioObj) {
        var url = config.restUrl + "funcionario/getPorcentajeDiasComision/";
        var promise = $http.post(url, funcionarioObj).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);