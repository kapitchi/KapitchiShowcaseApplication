function IdentityIndexCtrl($scope, $resource) {
    var Identity = $resource('/user/:userId', {userId:'@id'});
    console.log(Identity);
    
  $scope.identities = [
    {"id": "Nexus S",
     "displayName": "The Next, Next Generation tablet."}
  ];
}

angular.module('KapitchiIdentity', ['ngResource']).
    factory('Identity', function($resource){
  return $resource('identity/api/identity/:id', {}, {
    query: {method: 'GET', params:{id: 'phones'}, isArray:true}
  });
});