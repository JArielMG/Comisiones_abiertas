myApp.config(function($routeProvider) {
    $routeProvider

    // route for the home page
    .when('/', {
        templateUrl : 'app/components/home/home.html',
        controller  : 'HomeController'
    })
    .when('/graficas', {
        templateUrl : 'app/components/graficas/graficas.html',
        controller  : 'GraficasController'
    })
    .when('/buscador', {
        templateUrl : 'app/components/buscador/buscador.html',
        controller  : 'BuscadorController'
    })
    .when('/comparar', {
        templateUrl : 'app/components/comparar/comparar.html',
        controller  : 'CompararController'
    })
    .when('/funcionario', {
        templateUrl : 'app/components/funcionario/list.html',
        controller  : 'FuncionarioController'
    })
    .when('/funcionario/:idFuncionario', {
        templateUrl : 'app/components/funcionario/show.html',
        controller  : 'ShowFuncionarioController'
    })
    .when('/viaje/:idViaje', {
        templateUrl : 'app/components/viaje/viaje.html',
        controller  : 'ViajeController'
    });
});
