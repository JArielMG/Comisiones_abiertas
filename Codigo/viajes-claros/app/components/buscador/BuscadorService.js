
/**
 * Servicio para obtener los datos vía RESTful
 */
myApp.service('BuscadorService', ['$http', '$resource', 'config', '$log', '$rootScope', function ($http, $resource, config, $log, $rootScope) {
    
    function getIdDependencia() {
        if (typeof $rootScope.slcDependencia !== "undefined") {
            return $rootScope.slcDependencia.idDependencia;
        } else {
            return 1;
        }
    }
    
    /* Obtiene el anio seleccionado */
    function getAnioSeleccionado() {
        if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta!=''&&$rootScope.anioConsulta!='todos los años')
    		return $rootScope.anioConsulta;
    	else if ($rootScope.anioConsulta!=null&&$rootScope.anioConsulta=='todos los años')
    		return 0;
    	else
    		return new Date().getFullYear();
    }
    
    /**
     * Obtiene los filtros de búsqueda (dinámicos) para la dependencia indicada
     */
    this.getFiltros = function(dependencia) {
        var idDep = 1;
        if (typeof dependencia !== "undefined") {
            idDep = dependencia.idDependencia;
        }
        var url = config.restUrl + "busqueda/filtrosByDependencia/" + idDep;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los encabezados de la tabla de resultados
     * @param {type} dependencia
     */
    this.getEncabezados = function(dependencia) {
        var idDep = 1;
        if (typeof dependencia !== "undefined") {
            idDep = dependencia.idDependencia;
        }
        var url = config.restUrl + "busqueda/encabezados/" + idDep;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene los encabezados de la tabla de resultados
     * @param {type} dependencia
     */
    this.getEncabezadosComplete = function(dependencia) {
     	var idDep = 1;
        if (typeof dependencia !== "undefined") {
            idDep = dependencia.idDependencia;
        }
        var url = config.restUrl + "busqueda/encabezadosComplete/" + idDep;
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Muestra todos los viajes en un inicio
     */
    this.realizaBusqueda = function(dependencia) {
        var idDep = 1;
        if (typeof dependencia !== "undefined") {
            idDep = dependencia.idDependencia;
        }
        var url = config.restUrl + "busqueda/viajes/" + idDep+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Muestra todos los viajes en un inicio
     */
    this.realizaBusquedaComplete = function(dependencia) {
        var idDep = 1;
        if (typeof dependencia !== "undefined") {
            idDep = dependencia.idDependencia;
        }
        var url = config.restUrl + "busqueda/viajesComplete/" + idDep+','+getAnioSeleccionado();
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Procesa los filtros de búsqueda para poder realizar la búsqueda dinámica del lado del servidor
     * @param filtros   Objeto JSON que contiene los filtros de búsqueda
     */
    this.buscaByFiltros = function(filtros) {
        var url = config.restUrl + "busqueda/" + getIdDependencia()+','+getAnioSeleccionado();
        var objBusqueda = {"parametros": []};
        /* Procesar los filtros */
        objBusqueda.parametros = filtrosToRESTObjects(filtros);
        var promise = $http.post(url, objBusqueda).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    
    /**
     * Procesa los filtros de búsqueda para poder realizar la búsqueda dinámica del lado del servidor
     * @param filtros   Objeto JSON que contiene los filtros de búsqueda
     */
    this.buscaByFiltrosComplete = function(filtros) {
        var url = config.restUrl + "busqueda/complete/" + getIdDependencia()+','+getAnioSeleccionado();
        var objBusqueda = {"parametros": []};
        /* Procesar los filtros */
        objBusqueda.parametros = filtrosToRESTObjects(filtros);
        var promise = $http.post(url, objBusqueda).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
    /**
     * Obtiene el archivo CSV del servidor vía REST. 
     * Es necesario enviar los filtros para que sólo traiga los resultados de búsqueda en el archivo CSV.
     * @returns {String}
     */
    this.getCSV = function(filtros) {
        var objBusqueda = {"parametros": []};
        /* Procesar los filtros */
        objBusqueda.parametros = filtrosToRESTObjects(filtros);
        /* TODO. no se puede descargar directamente el archivo con http.post */
//        var url = config.restUrl + "busqueda/viajesCSV/" + getIdDependencia();
//        var promise = $http.post(url, objBusqueda).then(function (response) {
//            return response;
//        });
//        return promise;
    };
    
    /* Convierte los objectos "filtros" para enviarlos al REST Service */
    function filtrosToRESTObjects(filtros) {
        var jsonFiltros = [];
        for (i=0; i<filtros.length; i++) {
            var obj = {id: "", valor: "", idValor: 0, comparador: "", fecha: null, 
                        tipoDato: "string", tipoControl: "", descripcion: ""};
            obj.id = filtros[i].id;
            obj.comparador = filtros[i].comparador;
            obj.tipoControl = filtros[i].tipoControl;
            obj.descripcion = filtros[i].campo;
            if (obj.tipoControl === "SELECT" && typeof filtros[i].json !== "undefined" && filtros[i].json !== null && filtros[i].json !== "") {
                obj.valor = filtros[i].json.valor;
                //obj.idValor = filtros[i].json.id;
                jsonFiltros = jsonFiltros.concat(obj);
            } else if (obj.tipoControl === "TEXT" && typeof filtros[i].json !== "undefined" && filtros[i].json !== "") {
                obj.valor = filtros[i].json; //El valor se guarda directamente en la propiedad json
                jsonFiltros = jsonFiltros.concat(obj);
            } else if (obj.tipoControl === "DATE" && typeof filtros[i].json !== "undefined" 
                    && typeof filtros[i].json.date !== "undefined" && filtros[i].json !== null 
                    && filtros[i].json.date !== "") {
                var d = filtros[i].json.date;
                obj.valor = d.getUTCDate() + "/" + (d.getUTCMonth()+1) + "/" + d.getUTCFullYear();
                obj.fecha = d; 
                obj.tipoDato = "date";
                jsonFiltros = jsonFiltros.concat(obj);
            }
        }
        return jsonFiltros;
    }
    
}]);