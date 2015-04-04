'use strict'

angular.module('RSLWikiApp').controller 'SignUpCtrl', ($scope, $state, UserAPI, SessionAPI, storage) ->
  $scope.sign_up_params =
    name: ''
    login_id: ''
    password: ''
    password_confirmation: ''

  $scope.login = ()->
    UserAPI.create $scope.sign_up_params,
      (success) ->
        SessionAPI.login $scope.sign_up_params,
          (success) ->
            storage.set('rsl.access_token',success.access_token)
            storage.set('rsl.current_user',success.user)
            $state.go 'wiki_list'
          ,
          (error) ->
            console.log 'error'
      ,
      (error) ->
        console.log 'error'