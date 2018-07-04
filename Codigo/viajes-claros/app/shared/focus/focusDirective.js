
/**
 * Directiva para seleccionar por defecto algún elemento en la pantalla (auto-focus)
 */
myApp.directive('focus', function ($timeout) {

    return {
        scope: {
            trigger: '@focus'

        },
        link: function (scope, element) {
            scope.$watch('trigger', function (value) {
                if (value === "true") {
                    $timeout(function () {
                        element[0].focus();
                    });
                }
            });
        }
    };

});
