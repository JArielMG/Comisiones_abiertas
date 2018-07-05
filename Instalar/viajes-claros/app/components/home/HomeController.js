
myApp.controller('HomeController', ['$scope', '$rootScope', '$log', '$route', 'HomeService', 'leafletData', 
    function ($scope, $rootScope, $log, $route, HomeService, leafletData) {
    
    $scope.toggleAirplane = true;
    $scope.toggleSidebar = false;
    $scope.dependencia = $rootScope.slcDependencia;
    $scope.selectedMarker = {};
    
    if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!='')
    	$rootScope.thisYear = $rootScope.anioConsulta;
    else
    	$rootScope.thisYear = new Date().getFullYear();
    
    HomeService.countViajes($scope.dependencia).then(function (d) {
	    $scope.totalViajes = d.descripcion;
	});
    
    HomeService.totalViaticos($scope.dependencia).then(function (d) {
	    $scope.totalGastado = d.descripcion;
	});

    HomeService.getFuncionariosMayorGasto($scope.dependencia).then(function (d) {
        $scope.tresServidores = d;
    });
    
    HomeService.getFuncionariosMasViajes($scope.dependencia).then(function (d) {
        $scope.tresServidoresViajes = d;
    });
    
    HomeService.getUltimosViajes($scope.dependencia).then(function (d) {
        $scope.tresViajes = d;
    });
    
    
    /* A CONTINUACIÓN, EL CÓDIGO PARA EL CONTROL DEL MAPA */
    $scope.mapCenter = {
		lng : -50.133208,
		lat : 19.4326077,
		zoom : 3
    };
    
    var leafIcon = {
        iconUrl: 'assets/img/pin_mapa.png',
        iconSize:     [33, 46], // size of the icon
        iconAnchor:   [16, 36]  // point of the icon which will correspond to marker's location
    };
        
    HomeService.getUbicaciones().then(function (d) {
        $scope.markers = [];
        for (var i=0; i<d.length; i++) {
            var msg = "<span class='map-marker-monto text-center'> $" + formatNumber(d[i].gastoTotal) + 
                    " MXP</span><br/> Gasto en el periodo seleccionado en <b>" + d[i].ciudad + "</b>";
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
        getViajesOnMarker($scope.selectedMarker.ciudad, $scope.selectedMarker.pais);
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
    function getViajesOnMarker(ciudad, pais) {
        $scope.toggleSidebar = true;
        HomeService.getViajesOnMarker(ciudad, pais).then(function (d) {
            $scope.viajesOnMarker = d;
        });
    };
    
    function formatNumber (num) {
    	num = Math.round(num * 100) / 100;
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
    }    
}]);
