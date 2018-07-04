
/**
 * Controlador para la pantalla de gráficas
 */
myApp.controller("GraficasController", ['$scope', '$rootScope', 'GraficasService', 
    function ($scope, $rootScope, GraficasService) {

  $scope.onClick = function (points, evt) {
    console.log(points, evt);
  };

  $scope.graficasParam = [];
  $scope.viajesPorUnidad = [];
  
  GraficasService.getHotelesMasVisitados().then(function(d) {
      $scope.hotelesMas = d;
  });
  
  GraficasService.getGraficaTipoViaje().then(function(d) {
      $scope.tiposViaje = {labels: [], values: []};
      for (var i=0; i<d.values.length; i++) {
          $scope.tiposViaje.labels.push(d.values[i].label);
          $scope.tiposViaje.values.push(d.values[i].value);
      }
  });
  
  GraficasService.getGraficaTipoPasaje().then(function(d) {
      $scope.tiposPasaje = {labels: [], values: []};
      for (var i=0; i<d.values.length; i++) {
          $scope.tiposPasaje.labels.push(d.values[i].label);
          $scope.tiposPasaje.values.push(d.values[i].value);
      }
  });
  
  GraficasService.getGraficaAerolineas().then(function(d) {
      $scope.aerolineas = {labels: [], values: [[]]};
      var n = d.values.length;
      for (var i=0; i<n; i++) {
          $scope.aerolineas.labels.push(d.values[i].label);
          $scope.aerolineas.values[0].push(d.values[i].value);
      }
  });
  
  GraficasService.getGraficaCdInternacionales().then(function(d) {
      $scope.cdInternacionales = d.values;
  });
  
  GraficasService.getGraficaViajesPorMes().then(function(d) {
      $scope.viajesPorMes = {labels: [], values: [[]], series: [new Date().getFullYear(), ""]};
      for (var i=0; i<d.values.length; i++) {
          $scope.viajesPorMes.labels.push(d.values[i].label);
          $scope.viajesPorMes.values[0].push(d.values[i].value);
      }
  });
  
  GraficasService.getTotalViaticos().then(function(d) {
      $scope.totalViaticos = d.descripcion;
  });
  
  GraficasService.getTotalGasto().then(function(d) {
      $scope.totalGasto = d;
  });
  
  GraficasService.getGraficasParam().then(function(d) {
      $scope.graficasParam = d;
  });
  
  
  function getIdDependencia() {
    if (typeof $rootScope.slcDependencia !== "undefined") {
          return $rootScope.slcDependencia.idDependencia;
    } else {
        return 1;
    }
  }
  /* PARA INAI, Obtener las unidades administrativas que tienen viajes */
  
  if (getIdDependencia() === 1) {
    GraficasService.getUnidadesAdministrativas().then(function(d) {
        $scope.unidades = d;
        $scope.unidadSelected = d[0];
        $scope.changeUnidadAdministrativa($scope.unidadSelected);
    });
  }
  
  $scope.changeUnidadAdministrativa = function(unidad) {
    /* Obtener los últimos viajes por unidad administrativa */
    GraficasService.getGraficaViajesPorUnidad(unidad.id).then(function(d) {
        console.log(d);
       $scope.viajesPorUnidad = d; 
    });
  };
  
}]);
        