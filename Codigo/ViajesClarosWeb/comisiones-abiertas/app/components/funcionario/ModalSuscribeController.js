
/**
 * Controlador para la ventana modal de suscripción
 */
myApp.controller('ModalSuscribeController', ['$scope', '$modalInstance', 'ShowFuncionarioService', 'func',
    function ($scope, $modalInstance, ShowFuncionarioService, func) {
        
    $scope.userEmail = "";
    $scope.emailRx = /^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/;
    
    $scope.suscribe = function() {
        ShowFuncionarioService.suscribe(func, $scope.userEmail).then(function(d) {
            $modalInstance.close($scope.data);
            alert('Recibirá un correo electrónico cuando se registre un nuevo viaje de este funcionario.');
        });
    };
    
    $scope.close = function () {
        $modalInstance.close();
    };

}]);