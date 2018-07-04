
/**
 * Controlador para ver el detalle del funcionario indicado por su ID
 */
myApp.controller('ViajeController', ['$scope', '$rootScope', '$routeParams', 'ViajeService', 'config',
    function ($scope, $rootScope, $routeParams, ViajeService, config) {
       
    var idViaje = $routeParams.idViaje;
    $scope.activeCat = 0;
    
    ViajeService.getResumenViaje(idViaje).then(function(d) {
        $scope.viajeResumen = d;
    });
    
    ViajeService.getFuncionarioByIdViaje(idViaje).then(function(d) {
        $scope.funcionario = d;
        
        /* Se lanza para sustiruir los valores meta en el <head> (usados para compartir en facebook) */
        $rootScope.metaService.set(d.nombres + ' ' + d.apellido1 + ' ' + d.apellido2, 
            'Conoce los viajes de trabajo de ' + d.nombres + ' ' + d.apellido1 + ' ' + d.apellido2 + ' - @inaimexico URL vía @viajesclaros #ViajesClaros', 
            d.id + '?n=' + d.nombres.split(' ').join('%20') + '&a1=' + d.apellido1.split(' ').join('%20') + '&a2=' + d.apellido2.split(' ').join('%20'));
    });
    
    /* Obtener las listas de datos por categorías para así mostrarlas en la pantalla */
    ViajeService.getDatosComision(idViaje).then(function(d) {
        $scope.datosComision = d;
    });
    ViajeService.getDatosEvento(idViaje).then(function(d) {
        $scope.datosEvento = d;
    });
    ViajeService.getDatosFuncionario(idViaje).then(function(d) {
        $scope.datosFuncionario = d;
    });
    ViajeService.getDatosVuelo(idViaje).then(function(d) {
        $scope.datosVuelo = d;
    });
    ViajeService.getDatosInforme(idViaje).then(function(d) {
        $scope.datosInforme = d;
    });
    ViajeService.getDatosObservaciones(idViaje).then(function(d) {
        $scope.datosObservaciones = d;
    });
    ViajeService.getDatosTipoViaje(idViaje).then(function(d) {
        $scope.datosTipoViaje = d;
    });
    ViajeService.getDatosViaticos(idViaje).then(function(d) {
        $scope.datosViaticos = d;
    });
    
    
    /* Cuando se navega hacia una sección, poner "activa" esa sección */
    $scope.setActiveCat = function(index) {
        $scope.activeCat = index;
    };
    
    $scope.isActiveCat = function(index) {
        return $scope.activeCat === index;
    };
    
    $scope.fbShare = function(idFuncionario) {
        window.open(
        'https://www.facebook.com/sharer/sharer.php?u='+'http://viajesclaros.inai.mx/funcionario/'+idFuncionario, 
        'facebook-share-dialog', 
        'width=520,height=350'); 
        return false;
    };
    
}]);