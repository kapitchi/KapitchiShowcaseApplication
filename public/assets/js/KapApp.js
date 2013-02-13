var kapApp = angular.module('KapApp', ['ngGrid']);
kapApp.config(['$routeProvider', '$locationProvider', '$httpProvider', function($routeProvider, $locationProvider, $httpProvider) {
    function updateCntl(x) {
        console.log(x);
    }
    
    $routeProvider.
        when('/', {templateUrl: '/'}).
        when('/identity/identity/index', {templateUrl: '/identity/identity/index'}).
        when('/identity/identity/update/:id', {templateUrl: function(routeMatch) {
            return '/identity/identity/update/' + routeMatch.id;
        }}).
        otherwise({redirectTo: '/'});
  
    $locationProvider.html5Mode(true);
    
}]).run(function($rootScope, $http) {
    //http://stackoverflow.com/questions/14833597/listen-for-multiple-events-on-a-scope
    
    //mz: add mime to route template requests
    var origAcceptHeader = $http.defaults.headers.common.Accept;
    $rootScope.$on('$routeChangeStart', function(e, fn) {
        $http.defaults.headers.common.Accept = "text/ng-template, " + origAcceptHeader;
    });
    $rootScope.$on('$routeChangeSuccess', function(e, fn) {
        $http.defaults.headers.common.Accept = origAcceptHeader;
    });
    $rootScope.$on('$routeChangeError', function(e, fn) {
        $http.defaults.headers.common.Accept = origAcceptHeader;
    });
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