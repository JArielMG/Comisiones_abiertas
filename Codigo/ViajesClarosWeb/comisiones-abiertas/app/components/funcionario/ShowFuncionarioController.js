
/**
 * Controlador para ver el detalle del funcionario indicado por su ID
 */
myApp.controller('ShowFuncionarioController', ['$scope', '$rootScope', '$routeParams', '$filter', '$modal', 'ShowFuncionarioService', 'MetaService', 'leafletData', 'filterFilter', 'orderByFilter',
    function ($scope, $rootScope, $routeParams, $filter, $modal, ShowFuncionarioService, MetaService, leafletData, filterFilter, orderByFilter) {
       
    if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!='')
    	$rootScope.thisYear = $rootScope.anioConsulta;
    else
    	$rootScope.thisYear = new Date().getFullYear();
       
       
    var idFuncionario = $routeParams.idFuncionario;
    var funcionario = {id: idFuncionario, nombres: $routeParams.n, apellido1: $routeParams.a1, apellido2: $routeParams.a2};
    
    $scope.toggleSidebar = false;
    $scope.selectedMarker = {};
    $scope.orderField = 'fecha';
	$scope.tipoComision = 'tipoComision';
    $scope.isReversed = false;
    $scope.filterNacionales = true;
    $scope.filterInternacionales = true;
    $scope.filterList = [];
    $scope.pageSize = 5;
    
    $scope.$watchGroup(['filterNacionales','filterInternacionales', 'orderField', 'isReversed', 'tipoComision'], function (filterValues) {
    	
		var obj = "";
        if(filterValues[0] && filterValues[1]){
	    	$scope.filterList = $scope.viajesSafe;
	    	$scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3], filterValues[4]);
	    }else if(filterValues[0] && !filterValues[1]){
	        obj = { paisDestino: 'México' };
	        $scope.filterList = filterFilter($scope.viajes, obj);
	        $scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3], filterValues[4]);
	    }else if(!filterValues[0] && filterValues[1]){
	    	obj = { paisDestino: '!México' };
	        $scope.filterList = filterFilter($scope.viajes, obj);
	        $scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3], filterValues[4]);
	    }else if(!filterValues[0] && !filterValues[1]){
	        $scope.filterList = {};
	    }
		
		if (filterValues[4] == 1){
			obj = { tipoComision: 'Comisión sin gasto para el sujeto obligado' };
			$scope.filterList = filterFilter($scope.viajes, obj);
			$scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3]);
		}else if (filterValues[4] == 2){
			obj = { tipoComision: 'Comisión con gasto mixto' };
			$scope.filterList = filterFilter($scope.viajes, obj);
			$scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3]);
		}else if (filterValues[4] == 3){
			obj = { tipoComision: 'Comisión costeada por el sujeto obligado' };
			$scope.filterList = filterFilter($scope.viajes, obj);
			$scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3]);
		}else if (filterValues[4] == 0){
			$scope.filterList = $scope.viajesSafe;
	    	$scope.filterList = orderByFilter($scope.filterList, filterValues[2], filterValues[3]);
		}
		
	    $scope.currentPage = 1;
    });
    
    $scope.filterTipo = function (item){ 
        if($scope.filterNacionales && $scope.filterInternacionales){
            return true;
        }else if($scope.filterNacionales && item.paisDestino == 'México'){
            return true;
        }else if($scope.filterInternacionales && item.paisDestino != 'México'){
            return true;
        }
        return false;
    };
    
    $scope.mapCenter = {
        lng : -50.133208,
        lat : 19.4326077,
        zoom : 3
    };
    
    var leafIcon = {
        iconUrl: 'assets/img/pin_mapa.png',
        iconSize:     [40, 44], // size of the icon
        iconAnchor:   [16, 36]  // point of the icon which will correspond to marker's location
    };
    
    ShowFuncionarioService.getFuncionarioById(funcionario).then(function(d) {
        $scope.funcionario = d;
        
        /* Se lanza para sustiruir los valores meta en el <head> (usados para compartir en facebook) */
        $rootScope.metaService.set(d.nombres + ' ' + d.apellido1 + ' ' + d.apellido2, 
            'Conoce los viajes de trabajo de ' + d.nombres + ' ' + d.apellido1 + ' ' + d.apellido2 + ' - @inaimexico URL vía @viajesclaros #ViajesClaros', 
            d.id + '?n=' + d.nombres.split(' ').join('%20') + '&a1=' + d.apellido1.split(' ').join('%20') + '&a2=' + d.apellido2.split(' ').join('%20'));
        
        /* Obtener los encabezados */
        ShowFuncionarioService.getEncabezados(d.idDependencia).then(function(d) { 
            $scope.headers = d;
        });
		
		/*ShowFuncionarioService.getUltimosViajes(d.idDependencia).then(function (d) {
			$scope.tresViajes = d;
		});
		
		ShowFuncionarioService.getUltimosViajesTitulares(d.idDependencia).then(function (d) {
			$scope.tresViajesTitulares = d;
		});
		
		ShowFuncionarioService.getFuncionariosMayorGasto(d.dependencia).then(function (d) {
			$scope.tresServidores = d;
		});
		
		ShowFuncionarioService.getFuncionariosMayorGastoTitulares(d.dependencia).then(function (d) {
			$scope.tresServidoresTitulares = d;
		});

		ShowFuncionarioService.getFuncionariosMasViajes(d.dependencia).then(function (d) {
			$scope.tresServidoresViajes = d;
		});
		
		ShowFuncionarioService.getFuncionariosMasViajesTitulares(d.dependencia).then(function (d) {
			$scope.tresServidoresViajesTitulares = d;
		});*/
		
    });
    
    ShowFuncionarioService.getFuncionarioResumen(funcionario).then(function(d) {
       $scope.funcionarioResumen = d; 
    });
	
	ShowFuncionarioService.getComplementariosPerfil(funcionario).then(function(d) {
       $scope.complementarioPerfil = d; 
    });
	
	ShowFuncionarioService.getDiasTrabajados(funcionario).then(function(d) {
       $scope.diasTrabajoNacionales = d; 
    });

    ShowFuncionarioService.getCargoFuncionario(funcionario).then(function(d) {
       $scope.cargoFuncionario = d; 
    });
    
    ShowFuncionarioService.getViajesByFuncionario(funcionario).then(function(d) {
        $scope.viajes = d;
        $scope.viajesSafe = d;
        $scope.filterList = d;
    });
    
    ShowFuncionarioService.getPorcentajeDiasComisionFuncionario(funcionario).then(function(d) {
        $scope.grafPorcentajes = {data: [], labels: [], totalDiasViaje: 0};
        $scope.grafPorcentajes.data = [$filter('number')(d.porcentajeViaje, 2), $filter('number')(d.porcentajeInstitucion, 2)];
        $scope.grafPorcentajes.labels = [$filter('number')(d.porcentajeViaje, 2) + ' % de viaje', $filter('number')(d.porcentajeInstitucion, 2) + ' % en la institución'];
        $scope.grafPorcentajes.totalDiasViaje = d.totalDiasViaje;
    });
    
    ShowFuncionarioService.getGraficaViaticosPorFuncionario(funcionario).then(function(d) {
        $scope.grafViaticos = {labels: [], values: [[]], series: ["", ""]};
        for (var i=0; i<d.values.length; i++) {
            $scope.grafViaticos.labels.push(d.values[i].label);
            $scope.grafViaticos.values[0].push(d.values[i].value);
        }
    });
	
	ShowFuncionarioService.getGraficaViaticosPorFuncionarioNacInter(funcionario).then(function(d) {
        $scope.grafViaticos = {labels: [], values: [[]], series: ["", ""]};
        for (var i=0; i<d.values.length; i++) {
            //$scope.grafViaticos.labels.push(d.values[i].label);
            //$scope.grafViaticos.values[0].push(d.values[i].value);
			$scope.grafViaticosNacionales = d.values[0].value;
			$scope.grafViaticosInter = d.values[1].value;
			$scope.grafGtosPasajesNac = d.values[2].value;
			$scope.grafGtosPasajesInter = d.values[3].value;
        }
    });
    	
    $scope.fbShare = function() {
        window.open(
        'https://www.facebook.com/sharer/sharer.php?u='+'http://comisionesabiertas.inai.org.mx/comisiones-abiertas/%23/funcionario/'+idFuncionario+'?n='+
        	funcionario.nombres.split(' ').join('%2520')+'%26a1='+funcionario.apellido1.split(' ').join('%2520')+'%26a2='+funcionario.apellido2.split(' ').join('%2520'), 
        'facebook-share-dialog', 
        'width=520,height=350'); 
        return false;
    };

    /* Ventana modal para suscripcin */
    $scope.open = function (size) {

        var modalInstance = $modal.open({
          animation: true,
          templateUrl: 'myModalContent.html',
          controller: 'ModalSuscribeController',
          size: size,
          scope: $scope,
          resolve: {
            func: function () {
              return funcionario;
            }
          }
        });
        
        modalInstance.result.then(function(result) {
            //
        }, function () {
            //$log.info('Modal dismissed at: ' + new Date());
        });
        
    };
    
    /* obtener los markers del mapa */
    ShowFuncionarioService.getUbicaciones(funcionario).then(function(d) {
        $scope.markers = [];
        for (var i=0; i<d.length; i++) {
            var msg = "<span class='map-marker-monto text-center'> $" + formatNumber(d[i].gastoTotal) + 
                    " MXP</span><br/> Monto ejercido en el periodo seleccionado en <b>" + d[i].ciudad + "</b>";
            var m = {lat: parseFloat(d[i].lat), lng: parseFloat(d[i].lng), message: msg, focus: false, 
                        icon: leafIcon, ciudad: d[i].ciudad, pais: d[i].pais};
            $scope.markers.push(m);
        }
    });
    
    $scope.$on('leafletDirectiveMarker.click', function(event, args){
        var lat = args.leafletEvent.latlng.lat;
        var lng = args.leafletEvent.latlng.lng;
        $scope.selectedMarker = args.model;
        /* Consultar los viajes de la ciudad seleccionada */
        getViajesOnMarker($scope.funcionario, $scope.selectedMarker.ciudad, $scope.selectedMarker.pais);
        $scope.mapCenter = {
            lng : lng,
            lat : lat,
            zoom : 5
        };
        
         // Código para centrar la vista del marker y popup en el mapa
	leafletData.getMap().then(function(map) {
	      	map.setView(new L.LatLng(lat, lng), 5);
	});
    });
    
    /* Consulta los viajes de la ciudad que se seleccionó en el mapa */
    function getViajesOnMarker(funcionario, ciudad, pais) {
        $scope.toggleSidebar = true;
        ShowFuncionarioService.getViajesOnMarker(funcionario, ciudad, pais).then(function (d) {
            $scope.viajesOnMarker = d;
        });
    };
	
	function formatNumber (num) {
    	num = Math.round(num * 100) / 100;
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
    }

}]).filter('start', function () {
                return function (input, start) {
                    if (!input || !input.length) { return; }
 
                    start = +start;
                    return input.slice(start);
                };
            });
