var kapApp = angular.module('KapApp', ['Test', 'ngGrid', 'ui.compat', 'ui.bootstrap']);

kapApp.config(function($routeProvider, $locationProvider, $httpProvider, $stateProvider) {
    
    var pageTemplateProvider = function($browser, $http, $stateParams, $templateCache, $rootScope, $state, pageMetaService, navigationService) {
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
                navigationService.setBreadcrumbsHtml(data.breadcrumbsHtml);
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
        }).state('login', {
            url: '/identity/auth/login',
            parent: 'page',
            controller: 'Identity/AuthLoginController',
            templateProvider: pageTemplateProvider
        }).state('logout', {
            url: '/identity/auth/logout',
            parent: 'page',
            controller: 'Identity/AuthLogoutController'
        }).state('AuthSessionController/index', {
            url: '/identity/auth-session/index',
            parent: 'page',
            controller: 'GenericPageController',
            templateProvider: pageTemplateProvider
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
        }).state('default', {
            url: '/:url',
            parent: 'page',
            controller: 'GenericPageController',
            templateProvider: pageTemplateProvider
        });
    
    $locationProvider.html5Mode(true);
    
}).run(function($rootScope, $http, $state, aclService) {
    $rootScope.$state = $state;
    
    aclService.load();
});

kapApp.service('pageMetaService', function($rootScope) {
    this.setTitle = function(title) {
        $rootScope.pageMeta = {};
        $rootScope.pageMeta.title = title;
    };
});

kapApp.service('navigationService', function($rootScope) {
    this.setBreadcrumbsHtml = function(html) {
        $rootScope.breadcrumbsHtml = html;
    };
});

kapApp.service('alertService', function($rootScope) {
    this.add = function(alert) {
        if(!$rootScope.alerts) {
            $rootScope.alerts = [];
            $rootScope.closeAlert = function(index) {
                $rootScope.alerts.splice(index, 1);
            }
        }
        $rootScope.alerts.push(alert);
    };
    
});

kapApp.service('aclService', function($rootScope) {
    var service = this;
    
    //init
    $rootScope.acl = {
        perms: {}
    };
    
    this.isAllowed = function(resource) {
        if($rootScope.acl.perms[resource]) {
            return true;
        }
        
        return false;
    }
    
    this.load = function(domain) {
        $rootScope.acl = {
            perms: {
                default_true: true,
                identity_auth_login: true,
                identity_auth_logout: false,
                contact_contact_index: false,
                identity_identity_index: false
            }
        };
    };
    
    this.reload = function(domain) {
        $rootScope.acl = {
            perms: {
                default_true: true,
                identity_auth_login: false,
                identity_auth_logout: true,
                contact_contact_index: true,
                identity_identity_index: true
            }
        };
    };
    
});

kapApp.service('appStateService', function($rootScope) {
    //TODO
});

kapApp.controller('Identity/AuthLoginController', function($scope, $http, alertService, aclService) {
    $scope.formData = {};
    
    $scope.login = function(formData) {
        console.log($scope.loginForm.username.$setValidity('xxx', false));
        //$scope.loginForm.$setValidity('xxx', false);
        //console.log($scope.loginForm['credential[username]'].$setValidity('xx', false));
    
        //console.log(formData);
        return;
        
        $http.post('identity/api/auth/login', formData).success(function(data, statusCode, headers) {
//            $scope.loginForm['credential[username]'].$valid = false;
//            $scope.loginForm['credential[username]'].$error = {xxx: 'My validation'};
            
            //$state.transitionTo('home');
            switch(data.result.code) {
                case 1:
                    alertService.add({type: 'success', msg: 'Logged in!'});
                    break;
                default:
                    //$rootScope.acl.perms.login = false;
                    //$rootScope.acl.perms.logout = true;
                    for(var msg in data.result.messages) {
                        alertService.add({type: 'error', msg: data.result.messages[msg]});
                    }
                    break;
            }
            
            aclService.reload();
        }).error(function(data, statusCode, headers) {
            console.log(data);
            alertService.add({type: 'error', msg: data.formMessages});
            
//            for(var msg in data.formMessages.credential) {
//                alertService.add({type: 'error', msg: data.formMessages.credential[msg]});
//            }
            //console.log($scope);
//            $scope.$apply(function(s) {
//                $scope.loginForm["credential[password]"].$setValidity('xxx', false);
//            });
//            $scope.$evalAsync(function(scope) {
//                $scope.loginForm["credential[password]"].$setValidity('xxx', false);
//                console.log($scope);
//            })
            //$scope.$digest();
            
            //$scope.formData.credential.$setValidity('username', 'dfd');
            //console.log(data.formMessages.credential.username);
            //$scope.loginForm['formData.credential.username'].$error.xxx = 'XXX';
            //console.log($scope.loginForm);
            //console.log(statusCode);
            //console.log(headers);
        });
    }
});

kapApp.controller('GenericPageController', function($scope, $rootScope, $http, $stateParams, $state, $browser, alert) {
    console.log($stateParams);
});

kapApp.controller('NavigationController', function($scope, $browser, aclService) {
    
    //@todo how can we use function with ng-show?
    $scope.canShow = function(item) {
        if(item.acl) {
            aclService.load(item.acl.domain);
            return aclService.isAllowed(item.acl.resource);
        }
        
        return true;
    };
    
    $scope.baseUrl = $browser.baseHref();
    $scope.navigation = {
        items: [
            {
                label: "Home",
                url: '',
                state: 'home',
                acl: {
                    resource: 'default_true',
                    domain: 'default'
                }
            },
            {
                label: "Identities",
                url: 'identity/identity/index',
                state: 'identity',
                acl: {
                    resource: 'identity_identity_index',
                    domain: 'identity'
                }
            },
            {
                label: "Contacts",
                url: 'contact/contact/index',
                state: 'contact',
                acl: {
                    resource: 'contact_contact_index',
                    domain: 'contact'
                }
            },
            {
                label: "Log in",
                url: 'identity/auth/login',
                state: 'login',
                acl: {
                    resource: 'identity_auth_login',
                    domain: 'identity'
                }
            },
            {
                label: "Log out",
                url: 'identity/auth/logout',
                state: 'logout',
                acl: {
                    resource: 'identity_auth_logout',
                    domain: 'identity'
                }
            }
        ]
    }
});

kapApp.controller('Identity/AuthLogoutController', function($http, $state, alertService, aclService) {
    $http.get('identity/api/auth/logout').success(function(data, statusCode, headers) {
        alertService.add({type: 'success', msg: 'You have been logged out'});
        aclService.reload();
        $state.transitionTo('home');
    });
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
        showGroupPanel: true,
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
