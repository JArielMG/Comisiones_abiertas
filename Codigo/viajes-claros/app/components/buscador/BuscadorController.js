
/**
 * Controlador para la pantalla del Buscador
 */
myApp.controller('BuscadorController', ['$scope', '$rootScope', '$log', 'BuscadorService', function ($scope, $rootScope, $log, BuscadorService) {

        $scope.filtros = [];
        $scope.csvHeaders = [];
        $scope.pagItemsByPage = 20;
        $scope.dependencia = $rootScope.slcDependencia;
        $scope.viajesSafe = "";
        $scope.viajesSafeComplete = "";

        /**
         * Obtiene los filtros de búsqueda (parametrizados en base de datos) para mostrarlos en la pantalla
         */
        BuscadorService.getFiltros($scope.dependencia).then(function (d) {
            $scope.filtros = d;
        });

        /**
         * Obtiene los encabezados de las columnas de la tabla de resultados
         */
        BuscadorService.getEncabezados($scope.dependencia).then(function (d) {
            $scope.headers = d;
        });
        
        /**
         * Obtiene los encabezados de las columnas de la tabla de resultados
         */
        BuscadorService.getEncabezadosComplete($scope.dependencia).then(function (d) {
            $scope.headersComplete = d;
            /* Encabezados para la exportación a CSV */
            for (var i = 0; i < $scope.headersComplete.length; i++) {
                $scope.csvHeaders.push($scope.headersComplete[i].descripcion);
            }
        });

        /**
         * Mostrar los viajes sin filtros en un inicio
         */
        BuscadorService.realizaBusqueda($scope.dependencia).then(function (d) {
            $scope.viajes = d;
            $scope.viajesSafe = d;

            $scope.total = d.length;
            $scope.pagTotalPages = Math.floor($scope.total / $scope.pagItemsByPage);
        });
        
        /**
         * Mostrar los viajes sin filtros en un inicio
         */
        BuscadorService.realizaBusquedaComplete($scope.dependencia).then(function (d) {
            $scope.viajesComplete = d;
            $scope.viajesSafeComplete = d;

            /* Escapar los datos para la exportación a CSV */
            var A = [];
            for (var i = 0; i < d.length; i++) {
                A.push({datos: []});
                for (var j = 0; j < d[i].datos.length; j++) {
                    A[i].datos.push("\"" + d[i].datos[j] + "\"");
                }
            }
            $scope.viajesCSVEscaped = A;
        });

       /**
         * Realiza la búsqueda
         */
        $scope.realizaBusqueda = function () {
            BuscadorService.buscaByFiltros($scope.filtros).then(function (d) {
                $scope.viajes = d;
                $scope.viajesSafe = d;

                $scope.total = d.length;
                $scope.pagTotalPages = Math.floor($scope.total / $scope.pagItemsByPage);
                
                BuscadorService.buscaByFiltrosComplete($scope.filtros).then(function (d) {
	                $scope.viajesComplete = d;
	                $scope.viajesSafeComplete = d;
	
	                /* Escapar los datos para la exportación a CSV */
	                var A = [];
	                for (var i = 0; i < d.length; i++) {
	                    A.push({datos: []});
	                    for (var j = 0; j < d[i].datos.length; j++) {
	                        A[i].datos.push("\"" + d[i].datos[j] + "\"");
	                    }
	                }
	                $scope.viajesCSVEscaped = A;
	            });
            });
        };

        $scope.saveJSON = function () {
            var data = "";
            if (typeof $scope.viajesSafeComplete === 'object') {
                data = angular.toJson($scope.viajesSafeComplete);
            }

            var blob = new Blob([data], {type: 'text/json'}),
                    e = document.createEvent('MouseEvents'),
                    a = document.createElement('a');

            a.download = "viajes_json.txt";
            a.href = window.URL.createObjectURL(blob);
            a.dataset.downloadurl = ['text/json', a.download, a.href].join(':');
            e.initMouseEvent('click', true, false, window,
                    0, 0, 0, 0, 0, false, false, false, false, 0, null);
            a.dispatchEvent(e);
        };

        $scope.saveXML = function () {
            var data = json2xml($scope.viajesSafeComplete, " ");

            var blob = new Blob([data], {type: 'application/xml'}),
                    e = document.createEvent('MouseEvents'),
                    a = document.createElement('a');

            // IE 10 / 11 
            if (window.navigator.msSaveOrOpenBlob) {
                console.log("IE!");
                window.navigator.msSaveOrOpenBlob(blob, "viajes_xml.xml");
            } else {
                console.log("A true browser");
                a.download = "viajes_xml.xml";
                a.href = window.URL.createObjectURL(blob);
                a.dataset.downloadurl = ['application/xml', a.download, a.href].join(':');
                e.initMouseEvent('click', true, false, window,
                        0, 0, 0, 0, 0, false, false, false, false, 0, null);
                a.dispatchEvent(e);
            }
        };

        /* Obtiene el archivo CSV vía REST */
//        $scope.saveCSV = function () {
//            BuscadorService.getCSV($scope.filtros).then(function (d) {
////            window.location = d;
//            });
//        };

    }]);
