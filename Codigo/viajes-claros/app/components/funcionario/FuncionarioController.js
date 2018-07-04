
/**
 * Controlador para la pantalla del Funcionarios
 */
myApp.controller('FuncionarioController', ['$scope', 'FuncionarioService', function ($scope, FuncionarioService) {
        
    $scope.pagItemsByPage = 20;
    
    FuncionarioService.getFuncionariosByDependencia().then(function(d) {
        $scope.funcionarios = d;
        $scope.funcionariosSafe = d;
        $scope.total = d.length;
        $scope.pagTotalPages = Math.floor($scope.total / $scope.pagItemsByPage);
    });
    
}]);