
/**
 * Controlador para ver el detalle del funcionario indicado por su ID
 */
myApp.controller('ViajeController', ['$scope', '$rootScope', '$routeParams', 'ViajeService', 'config','$window',
    function ($scope, $rootScope, $routeParams, ViajeService, config, $window) {
    
    /*angular.element(document).ready(function(){
	angular.element($window).bind("scroll", function() {
		setActiveCat(0);
	});
    });*/
    if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!='')
    	$rootScope.thisYear = $rootScope.anioConsulta;
    else
    	$rootScope.thisYear = new Date().getFullYear();
       
       
    var idViaje = $routeParams.idViaje;
	var idFuncionario = $routeParams.idFuncionario;	
	var funcionario = {id: idFuncionario};
	
    $scope.activeCat = 0;
    
    ViajeService.getResumenViaje(idViaje).then(function(d) {
        $scope.viajeResumen = d;
    });
    
    ViajeService.getFuncionarioByIdViaje(idViaje).then(function(d) {
        $scope.funcionario = d;
		$scope.datosFunc = d;
        
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
    
    
	ViajeService.getFuncionarioById(funcionario).then(function(d) {
        $scope.funcionario = d;
       
		ViajeService.getUltimosViajes(d.idDependencia).then(function (d) {
			$scope.tresViajes = d;
		});
		
		ViajeService.getUltimosViajesTitulares(d.idDependencia).then(function (d) {
			$scope.tresViajesTitulares = d;
		});
		
		ViajeService.getFuncionariosMayorGasto(d.dependencia).then(function (d) {
			$scope.tresServidores = d;
		});
		
		ViajeService.getFuncionariosMayorGastoTitulares(d.dependencia).then(function (d) {
			$scope.tresServidoresTitulares = d;
		});
		
		ViajeService.getFuncionariosMasViajes(d.dependencia).then(function (d) {
			$scope.tresServidoresViajes = d;
		});
				
		ViajeService.getFuncionariosMasViajesTitulares(d.dependencia).then(function (d) {
			$scope.tresServidoresViajesTitulares = d;
		});
		
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