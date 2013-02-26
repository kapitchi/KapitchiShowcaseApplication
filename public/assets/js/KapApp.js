var kapApp = angular.module('KapApp', ['ngGrid', 'ui.compat', 'ui.bootstrap']);
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
            url: '/:module/:entity',
            'abstract': true,
            template: '<div ng-view></div>'
        }).state('entity.index', {
            url: '/index',
            templateProvider: function($http, $stateParams, $templateCache, $rootScope) {
                return $http.get('/' + $stateParams.module + '/' + $stateParams.entity + '/index', {
                        headers: {
                            'Accept': 'application/kap-page'
                        },
                        cache: $templateCache
                    }).then(function(response) {
                        var data = response.data;
                        
                        //$rootScope.title = data.title;
                        return data.content;
                    });
            }
        }).state('entity.update', {
            url: '/update/:id',
            templateProvider: function($http, $templateCache, $stateParams) {
                return $http.get('/' + $stateParams.module + '/' + $stateParams.entity + '/update/' + $stateParams.id, {
//                        params: {
//                            id: $stateParams.id
//                        },
                        headers: {
                            'Accept': 'application/kap-page'
                        },
                        cache: $templateCache
                    }).then(function(response) {
                        var data = response.data;
                        
                        //$rootScope.title = data.title;
                        //$state.current.title = data.title;
                        
                        return data.content;
                    });
            }
        });
    
    $locationProvider.html5Mode(true);
    
}).run(function($rootScope, $http, $state) {
    $rootScope.$on('EntityIndex.get', function(e, params) {
        console.log(e);
        console.log(params);
        //console.log(a1);
        //console.log(a2);
        for(entity in params.data.entities) {
            params.data.entities[entity].contact = {id: 111};
        }
    });
    
    $rootScope.$on('EntityIndex.post', function(e, params) {
        console.log(e);
        console.log(params);
        e.targetScope.gridColumnDefs.push({field: 'contact.id', displayName:'ID'});
    });
    
    $rootScope.page = {
        title: 'My Application'
    };
    
    $rootScope.$state = $state;
});

kapApp.controller('EntityIndex', function($scope, $http, $stateParams) {
    $scope.selectedEntities = [];
    $scope.entities = [];
    $scope.gridColumnDefs = [
        {field: '_rowSelection',
                    width: 100,
                    sortable: false,
                    resizable: false,
                    groupable: false,
                    headerCellTemplate: '<div><div>',
//                    cellTemplate: '<div class="ngSelectionCell">' +
//                    '<a class="dropdown-toggle">' +
//                    '    Click me for a dropdown, yo!' +
//                    '</a>' +
//                    '<ul class="dropdown-menu">' +
//                    '    <li>' +
//                    '    <a>XXX</a>' +
//                    '    </li>' +
//                    '</ul>' +
//                    '</div>' },
                    cellTemplate: '<div class="ngSelectionCell">' +
                    '<a href="/' + $stateParams.module + '/' + $stateParams.entity + '/update/{{row.getProperty(\'id\')}}">' +
                    '    Edit' +
                    '</a>' +
                    '</div>'},
            {field: 'id', displayName: 'ID'},
            {field: 'displayName', displayName:'Display name'},
            {field: 'authEnabled', displayName:'Auth. enabled', cellFilter: 'checkmark'},
            {field: 'created', displayName:'Created', cellFilter: 'date:"medium"'}
        ];
    
    $scope.gridPagingOptions = {
        pageSizes: [250, 500, 1000],
        pageSize: 250,
        totalServerItems: 0,
        currentPage: 1
    };
    
    $scope.gridCheckboxHeaderTemplate = '<div><input class="ngSelectionHeader" type="checkbox" ng-show="multiSelect" ng-model="allSelected" ng-change="toggleSelectAll(allSelected)"/></div>';
    $scope.gridOptions = {
        data: 'entities',
        selectedItems: $scope.selectedEntities,
        checkboxHeaderTemplate: $scope.gridCheckboxHeaderTemplate,
        multiSelect: true,
        enablePaging: true,
        pagingOptions: $scope.gridPagingOptions,
        displaySelectionCheckbox: false,
        selectWithCheckboxOnly: true,
        //checkboxCellTemplate: '<div class="ngSelectionCell"><input tabindex="-1" class="ngSelectionCheckbox" type="checkbox" ng-checked="row.selected" /></div>',
        columnDefs: 'gridColumnDefs'
    };
    
    setTimeout(function() {
        //$scope.gridCheckboxHeaderTemplate = '<div>XXX<input class="ngSelectionHeader" type="checkbox" ng-show="multiSelect" ng-model="allSelected" ng-change="toggleSelectAll(allSelected)"/></div>';
        //console.log('NOW');
    }, 2000);
    
    console.log($scope.options);
    
    $http.get($scope.options.apiUrl).success(function (data) {
        $scope.$emit('EntityIndex.get', {
            data: data
        });
        
        $scope.entities = data.entities;
        $scope.gridPagingOptions.totalServerItems = data.totalCount;
        //$scope.$apply();
        //$scope.setPagingData(largeLoad,page,pageSize);
    });
    
    $scope.$emit('EntityIndex.post');
});

kapApp.controller('EntityUpdate', function($scope, $http, $stateParams, $state) {
    //$scope.entity = {};
    $http.get('/' + $stateParams.module + '/api/' + $stateParams.entity + '/' + $stateParams.id).success(function (data) {
        $scope.entity = data.entity;
    });
    
    $scope.save = function(entity) {
        $http.put('/' + $stateParams.module + '/api/' + $stateParams.entity + '/' + entity.id, entity).success(function (data) {
            $scope.entity = data.entity;
            $state.transitionTo('entity.index', {
                module: $stateParams.module,
                entity: $stateParams.entity
            });
        }); 
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