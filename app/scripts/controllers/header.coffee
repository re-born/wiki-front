'use strict'

angular.module('RSLWikiApp').controller 'HeaderCtrl', ($scope, $state, storage, SessionAPI) ->
  $scope.logout = ()=>
    SessionAPI.delete (result)=>
      storage.clearAll()
      $state.go 'login'