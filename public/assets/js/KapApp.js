var kapApp = angular.module('KapApp', ['ngGrid', 'ui.compat', 'ui.bootstrap']);

kapApp.config(function($routeProvider, $locationProvider, $httpProvider, $stateProvider) {
    
    var pageTemplateProvider = function($browser, $http, $stateParams, $templateCache, $rootScope, $state, pageMeta) {
        return $http.get($browser.url(), {
                headers: {
                    'Accept': 'application/kap-page'
                },
                cache: $templateCache
            }).then(function(response) {
                var data = response.data;
                pageMeta.setTitle(data.title);
                return data.content;
            });
    };
            
    $stateProvider
        .state('home', {
            url: '/',
            templateProvider: pageTemplateProvider
        }).state('page', {
            //url: '/:module/:entity',
            'abstract': true,
            template: '<div ng-view></div>'
        }).state('identity', {
            url: '/identity/identity',
            parent: 'page',
            template: '<div ng-view></div>',
            abstract: true
        }).state('identity.index', {
            url: '/index',
            updateUrl: '/identity/identity/update',
            templateProvider: pageTemplateProvider
        }).state('identity.update', {
            url: '/update/:id',
            restUrl: 'identity/api/identity',
            templateProvider: pageTemplateProvider
        }).state('contact', {
            url: '/contact/contact',
            parent: 'page',
            template: '<div ng-view></div>',
            abstract: true
        }).state('contact.index', {
            url: '/index',
            updateUrl: '/contact/contact/update',
            templateProvider: pageTemplateProvider
        }).state('contact.update', {
            url: '/update/:id',
            restUrl: 'contact/api/contact',
            templateProvider: pageTemplateProvider
        });
    
    $locationProvider.html5Mode(true);
    
}).run(function($rootScope, $http, $state) {
    $rootScope.$on('EntityIndex.get', function(e, params) {
        //console.log(e);
        //console.log(params);
        //console.log(a1);
        //console.log(a2);
        for(entity in params.data.entities) {
            params.data.entities[entity].contact = {id: 111};
        }
    });
    
    $rootScope.$on('EntityIndex.post', function(e, params) {
        //console.log(e);
        //console.log(params);
        //e.targetScope.gridColumnDefs.push({field: 'contact.id', displayName:'ID'});
    });
    
    $rootScope.$state = $state;
});

kapApp.service('pageMeta', function($rootScope) {
    this.setTitle = function(title) {
        $rootScope.title = title;
    };
});

kapApp.controller('EntityIndex', function($scope, $http, $stateParams, $state, $browser) {
    var options = {};
    
    $scope.init = function(opts) {
        angular.extend(options, opts);
        
        $http.get(options.apiUrl).success(function (data) {
            $scope.$emit('EntityIndex.get', {
                data: data
            });

            $scope.entities = data.entities;
            $scope.gridPagingOptions.totalServerItems = data.totalCount;
        });

        $scope.$emit('EntityIndex.init');
    };
    
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
                    '<a href="' + ($browser.baseHref() + $state.current.updateUrl).replace('//', '/') + '/{{row.getProperty(\'id\')}}">' +
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
    
});

kapApp.controller('EntityUpdate', function($scope, $http, $stateParams, $state, $browser) {
    //$scope.entity = {};
    console.log($state);
    $http.get($browser.baseHref() + $state.current.restUrl + '/' + $stateParams.id).success(function (data) {
        $scope.formData = data.entity;
    });
    
    $scope.save = function(entity) {
        $http.put($browser.baseHref() + $state.current.restUrl + '/' + $stateParams.id, entity).success(function (data) {
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
