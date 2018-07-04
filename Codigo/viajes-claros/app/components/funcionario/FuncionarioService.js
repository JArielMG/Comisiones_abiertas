
/**
 * Servicio para obtener los datos vía RESTful
 */
myApp.service('FuncionarioService', ['$http', 'config', '$log', '$rootScope',
    function ($http, config, $log, $rootScope) {

    function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 1;
        }
    }

    this.getFuncionariosByDependencia = function () {
        var url = config.restUrl + "funcionario/funcionariosByDependencia/" + getIdDependencia();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);