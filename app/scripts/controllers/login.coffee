'use strict'

angular.module('RSLWikiApp').controller 'LoginCtrl', ($scope, $state, SessionAPI, storage) ->
  $scope.login_params =
    login_id: ''
    password: ''

  $scope.login = ()=>
    SessionAPI.login $scope.login_params, (success)=>
      storage.set('rsl.access_token',success.access_token)
      storage.set('rsl.current_user',success.user)
      $state.go 'main'
