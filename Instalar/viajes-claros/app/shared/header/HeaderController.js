
/**
 * Controlador para el encabezado
 */
myApp.controller('HeaderController', ['$scope', '$rootScope', '$location', '$route', 'HeaderService', function($scope, $rootScope, $location, $route, HeaderService) {

    $scope.isCollapsed = true;

    $scope.isActive = function (viewLocation) { 
        return viewLocation === $location.path();
    };
    
    $scope.changeDependencia = function(dep) {
        $rootScope.slcDependencia = dep;
        $route.reload();
    };
    
    HeaderService.getDependencias().then(function(d) {
        $scope.listDependencias = d;
    }). finally(function() {
        $rootScope.slcDependencia = $scope.listDependencias[0];
    });
    
}]);