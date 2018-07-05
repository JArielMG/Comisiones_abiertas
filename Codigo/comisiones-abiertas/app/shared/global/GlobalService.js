
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
    
	/**
         * obtiene los datos complementarios para el perfil del funcionario
         * @param {type} idFuncionario
         * @returns {undefined}
         */
		this.getComplementariosPerfil = function (funcionarioObj) {
            var url = config.restUrl + "funcionario/getComplementariosPerfilPorFuncionario/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionarioObj).then(function (response) {
                return response.data;
            });
            return promise;
        };
		
		/**
         * obtiene los días trabajados en comisiones nacionales para funcionario
         * @param {type} idFuncionario
         * @returns {undefined}
         */
		this.getDiasTrabajados = function (funcionarioObj) {
            var url = config.restUrl + "funcionario/getDiasTrabajadosComisNacionales/"+getAnioSeleccionado();
            var promise = $http.post(url, funcionarioObj).then(function (response) {
                return response.data;
            });
            return promise;
        };
		
}]);