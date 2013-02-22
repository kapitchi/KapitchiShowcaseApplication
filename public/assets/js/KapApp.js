var kapApp = angular.module('KapApp', ['ngGrid', 'ui.compat']);
kapApp.config(function($routeProvider, $locationProvider, $httpProvider, $stateProvider) {
    
    
    $httpProvider.responseInterceptors.push(function($q) {
        return function(promise) {
            return promise.then(function(response) {
                //on success
                return response;
            }, function(response) {
//                if (canRecover(response)) {
//                    return responseOrNewPromise
//                }
                console.error(response.data.exception.message, response.data.exception.traceString);
                
                return $q.reject(response);
            });
        }
    });
    
    $stateProvider
        .state('home', {
            url: '/',
            templateProvider:
                [        '$timeout',
                function ($timeout) {
                    return $timeout(function () {return "Hello world"}, 100);
                }]
            }
        ).state('entity', {
            'abstract': true,
            template: '<div ng-view></div>'
        }).state('entity.identity', {
            url: '/identity/identity',
            'abstract': true,
            controller: function($scope) {
                //console.log($scope);
//                $scope.entities = [
//                    {id: 1},
//                    {id: 2},
//                ];
            },
            template: '<div ng-view></div>'
        }).state('entity.identity.index', {
            url: '/index',
            templateProvider: function($http, $templateCache, $rootScope) {
                return $http.get('/identity/identity/index', {
                        headers: {
                            'Accept': 'application/kap-page'
                        },
                        cache: $templateCache
                    }).then(function(response) {
                        var data = response.data;
                        
                        $rootScope.title = data.title;
                        return data.content;
                    });
            }
        }).state('entity.identity.update', {
            url: '/update/:id',
            templateProvider: function($http, $templateCache, $rootScope, $stateParams) {
                return $http.get('/identity/identity/update/' + $stateParams.id, {
//                        params: {
//                            id: $stateParams.id
//                        },
                        headers: {
                            'Accept': 'application/kap-page'
                        },
                        cache: $templateCache
                    }).then(function(response) {
                        var data = response.data;
                        
                        $rootScope.title = data.title;
                        
                        return data.content;
                    });
            }
        });
    
//    $routeProvider.
//        when('/', {requestUrl: '/'}).
//        when('/identity/identity/index', {requestUrl: '/identity/identity/index'}).
//        when('/identity/identity/update/:id', {requestUrl: function(routeMatch) {
//            return '/identity/identity/update/' + routeMatch.params.id;
//        }}).
//        otherwise({redirectTo: '/'});
  
    $locationProvider.html5Mode(true);
    
}).run(function($rootScope, $http) {
    //http://stackoverflow.com/questions/14833597/listen-for-multiple-events-on-a-scope
    
    //mz: add mime to route template requests
    //var origAcceptHeader = $http.defaults.headers.common.Accept;
    
//    $rootScope.title = 'XXXX';
//    $rootScope.$on('$routeChangeStart', function(e, routeMatch) {
//        console.log(e);
//        console.log(routeMatch);
//        
//    });
//    $rootScope.$on('$routeChangeSuccess', function(e, routeMatch) {
//        console.log(e);
//        console.log(routeMatch);
//        
//        var url = routeMatch.requestUrl;
//        if(angular.isFunction(url)) {
//            url = url(routeMatch);
//        }
//        
//        $http.get(url, {
//            headers: {
//                'Accept': 'application/kap-page'
//            }
//        }).success(function(data, status, headers, config) {
//            console.log(data);
//            $rootScope.title = data.title;
//            $rootScope.content = data.content;
//        }).error(function(data, status, headers, config) {
//            // called asynchronously if an error occurs
//            // or server returns response with an error status.
//        });
//    });
//    $rootScope.$on('$routeChangeError', function(e, routeMatch) {
//        //$http.defaults.headers.common.Accept = origAcceptHeader;
//        console.log(e);
//        console.log(routeMatch);
//        
//    });
    //END
    
});

kapApp.controller('IdentityIndex', function($scope, $http) {
    $scope.myData = [];
    
    $scope.gridOptions = {
        data: 'myData',
        //enablePaging: true,
        //pagingOptions: $scope.pagingOptions,
        //checkboxCellTemplate: '<div class="ngSelectionCell"><input tabindex="-1" class="ngSelectionCheckbox" type="checkbox" ng-checked="row.selected" /></div>',
        columnDefs: [
            {field: 'id', displayName: 'ID', cellTemplate: '<div ng-class="\'ngCellText colt\' + $index"><a href="/identity/identity/update/{{row.getProperty(\'id\')}}"><span ng-cell-text>{{COL_FIELD}}</span></a></div>'},
            {field: 'displayName', displayName:'Display name'},
            {field: 'authEnabled', displayName:'Auth. enabled', cellFilter: 'checkmark'},
            {field: 'created', displayName:'Created', cellFilter: 'date:"medium"'}
        ]
    };
    
    $scope.pagingOptions = {
        pageSizes: [250, 500, 1000],
        pageSize: 250,
        totalServerItems: 10,
        currentPage: 1
    };
    
    $http.get('/identity/api/identity').success(function (data) {
        $scope.myData = data.entities;
        $scope.pagingOptions.totalServerItems = data.totalCount;
        //$scope.$apply();
        //$scope.setPagingData(largeLoad,page,pageSize);
    });
    
    
});

kapApp.controller('IdentityUpdate', function($scope, $http) {
//    $http.get('/identity/api/identity').success(function (data) {
//        $scope.myData = data.entities;
//        $scope.pagingOptions.totalServerItems = data.totalCount;
//        //$scope.$apply();
//        //$scope.setPagingData(largeLoad,page,pageSize);
//    });
    $scope.xxx = function() {
        console.log($scope);
    };
});

kapApp.filter('checkmark', function() {
    return function(input) {
        return input == '1' ? '\u2713' : '\u2718';
    };
});

kapApp.filter('gridEntityUrl', function() {
    return function(input, url) {
        url = url.replace(':id', this.row.getProperty('id'));
        return '<a href="' + url + '">' + input + '</a>';
    };
});