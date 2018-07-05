
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
    
    /* Obtiene el anio seleccionado */
    function getAnioSeleccionado() {
        if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!=''&&$rootScope.anioConsulta!='todos los años')
    		return $rootScope.anioConsulta;
    	else if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta=='todos los años')
    		return 0;
    	else
    		return new Date().getFullYear();
    }

    this.getFuncionariosByDependencia = function () {
        var url = config.restUrl + "funcionario/funcionariosByDependencia/" + getIdDependencia()+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);