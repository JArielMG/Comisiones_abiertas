
/**
 * Controlador global, añadido en el body.
 * Principalmente se utiliza para controlar el comparador de funcionarios (lateral izquierdo).
 */
myApp.controller('GlobalController', ['$scope', '$rootScope', '$location', '$filter', 'GlobalService', 'MetaService',
    function ($scope, $rootScope, $location, $filter, GlobalService, MetaService) {
    
    $scope.toggleComparador = false;
    $rootScope.funcionariosCompara = [];
    $scope.funcSelected;
    
    $scope.years=['todos los años',2014,2015,2016];
    
    $rootScope.metaService = MetaService;
    
    $scope.closeSidebar = function() {
        $scope.toggleComparador = false;
    };
    
    $scope.openSidebar = function() {
        $scope.toggleComparador = true;
    };
    
    /* Observar el cambio de dependencia 
     * (si se quiere que sólo se muestren los funcionarios de la dependencia seleccionada) 
     **/
//    $scope.$watch(function() {
//        return $rootScope.slcDependencia;
//    }, function() {
//        GlobalService.getFuncionarios().then(function(d) {
//            $rootScope.funcionarios = d;
//        });
//    }, true);

    GlobalService.getFuncionarios().then(function(d) {
        $rootScope.funcionarios = d;
    });
    
    /* Agregar el funcionario seleccionado en el comparador */
    $scope.selectFuncionarioCompara = function($item, $model, $label) {
        // item es un objeto funcionario (con las propiedades id, nombres, apellido1 y apellido2)
        GlobalService.getPorcentajeDiasComisionFuncionario($item).then(function(d) {
            /* CONSULTAR EL PORCENTAJE DE DÍAS DE COMISIÓN Y DÍAS EN LA INSTITUCIÓN */
            var porcentajes = d;
            $item.chartPorc = {data: [], labels: [], options:{ showTooltips: false}};
            $item.chartPorc.data = [$filter('number')(porcentajes.porcentajeViaje, 2), $filter('number')(porcentajes.porcentajeInstitucion, 2)];
            $item.chartPorc.labels = [$filter('number')(porcentajes.porcentajeViaje, 2) + ' % de días de comisión del total de días laborales', 'Tiempo en la institución'];
            $item.totalDiasViaje = Math.abs(porcentajes.totalDiasViaje);
            $item.totalDiasInstitucion = porcentajes.totalDiasInstitucion;
            
            /* quitarlo de la lista de funcionarios y pasarlo a la lista de seleccionados*/
            removeFuncionarioByNombre($item);
            $rootScope.funcionariosCompara.push($item);
            $scope.funcSelected = "";
        });
    };
    
    $scope.removeFuncionarioCompara = function(index) {
        /* Regresar el funcionario a la lista original */
        $scope.funcionarios.push($rootScope.funcionariosCompara[index]);
        /* Eliminarlo de los funcionarios seleccionados */
        $rootScope.funcionariosCompara.splice(index, 1);
    };
    
    /**
     * Función para redireccionar
     */
    $scope.go = function(path) {
        $location.path( path );
    };  
    
    /* Quita de la lista original de funcionarios el que coincida con el id */
    function removeFuncionarioById(idFunc) {
        for (var i=0; i<$rootScope.funcionarios.length; i++) {
            if ($rootScope.funcionarios[i].id === idFunc) {
                $rootScope.funcionarios.splice(i, 1);
            }
        }
    }
    
    function removeFuncionarioByNombre(func) {
        for (var i=0; i < $rootScope.funcionarios.length; i++) {
            if ($rootScope.funcionarios[i].id === func.id 
                    && $rootScope.funcionarios[i].nombres === func.nombres
                    && $rootScope.funcionarios[i].apellido1 === func.apellido1
                    && $rootScope.funcionarios[i].apellido2 === func.apellido2) {
                $rootScope.funcionarios.splice(i, 1);
            }
        }
    }
    
}]);