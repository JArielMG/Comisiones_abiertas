
/**
 * Servicio para el encabezado
 */
myApp.service('HeaderService', ['$http', 'config', function ($http, config) {
    
    this.getDependencias = function() {
        var url = config.restUrl + "dependencia";
        var promise = $http.get(url).then(function (response) {
            return response.data;
        });
        return promise;
    };
    
}]);
