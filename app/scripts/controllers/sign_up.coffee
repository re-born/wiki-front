'use strict'

angular.module('RSLWikiApp').controller 'SignUpCtrl', ($scope, $state, UserAPI, SessionAPI, storage) ->
  $scope.sign_up_params =
    name: ''
    login_id: ''
    password: ''
    password_confirmation: ''

  $scope.login = ()->
    $scope.errors = []
    if !$scope.sign_up_params.name or !$scope.sign_up_params.login_id or !$scope.sign_up_params.password
      $scope.errors.push '全ての項目が必須です'
    if $scope.sign_up_params.password != $scope.sign_up_params.password_confirmation
      $scope.errors.push 'パスワードが一致しません'
    console.log $scope.errors
    return if $scope.errors.length > 0
    UserAPI.create $scope.sign_up_params,
      (success) ->
        SessionAPI.login $scope.sign_up_params,
          (success) ->
            storage.set('rsl.access_token',success.access_token)
            storage.set('rsl.current_user',success.user)
            $state.go 'wiki_list'
          ,
          (error) ->
            $scope.errors.push 'サーバーエラー'
      ,
      (error) ->
        $scope.errors.push 'サーバーエラー'