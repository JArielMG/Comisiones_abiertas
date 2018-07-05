
/**
 * Controlador para la pantalla de comparar
 */
myApp.controller('CompararController', ['$scope', '$rootScope', 
    function($scope, $rootScope) {
    
    	if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!='')
    		$rootScope.thisYear = $rootScope.anioConsulta;
    	else
    		$rootScope.thisYear = new Date().getFullYear();
    
        
}]);