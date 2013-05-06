var test = angular.module('Test', ['ngGrid', 'ui.compat', 'ui.bootstrap']);

test.config(function($routeProvider, $locationProvider, $httpProvider, $stateProvider) {
    
    var pageTemplateProvider = function($browser, $http, $stateParams, $templateCache, $rootScope, $state, pageMetaService) {
        //var pageUrl = $browser.url().replace('http://localhost', '');
        var pageUrl = $browser.url();
        return $http.get(pageUrl, {
                headers: {
                    'Accept': 'application/kap-page'
                },
                cache: $templateCache
            }).then(function(response) {
                var data = response.data;
                pageMetaService.setTitle(data.title);
                return data.content;
            });
    };
            
    $stateProvider
        .state('test_view', {
            url: '/test/index/view',
            templateProvider: pageTemplateProvider
        })
        .state('test', {
            url: '/test/index/uploader',
            templateProvider: pageTemplateProvider,
            controller: 'Test/Uploader'
        });
    
}).run(function($rootScope, $http, $state, aclService) {
    
});

test.controller('Test/Uploader', function($scope, $http, alertService, aclService) {
    $scope.submit = function(formData) {
        console.log(formData);
//        $http.post('identity/api/auth/login', formData).success(function(data, statusCode, headers) {
//        });
    }
});
