'use strict'

angular.module('RSLWikiApp').controller 'LoginCtrl', ($scope, $state, SessionAPI, storage) ->
  return $state.go 'wiki_list' if storage.get('rsl.current_user')
  $scope.login_params =
    login_id: ''
    password: ''
  $scope.errors = []

  $scope.login = ()->
    SessionAPI.login $scope.login_params,
      (success) ->
        storage.set('rsl.access_token',success.access_token)
        storage.set('rsl.current_user',success.user)
        $state.go 'wiki_list'
      ,
      (error) ->
        $scope.errors = ['IDとパスワードが一致しません']
