myApp.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        //$httpProvider.defaults.withCredentials = true;
        delete $httpProvider.defaults.headers.common["X-Requested-With"];
        $httpProvider.defaults.headers.common["Accept"] = "application/json, text/plain, application/octet-stream";
        $httpProvider.defaults.headers.common["Content-Type"] = "application/json";
    }
]);
