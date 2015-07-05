'use strict'

angular.module('RSLWikiApp').controller 'SignUpCtrl', ($scope, $state, UserAPI, SessionAPI, storage, RSLLoading, $q) ->
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
    return if $scope.errors.length > 0
    RSLLoading.loading_start()
    UserAPI.create($scope.sign_up_params).$promise
      .then (success)->
        SessionAPI.login($scope.sign_up_params).$promise
      .then( (success) ->
            storage.set('rsl.access_token',success.access_token)
            storage.set('rsl.current_user',success.user)
          ,error)
      .then ()->
        RSLLoading.loading_finish()
        $state.go 'wiki_list'
      , error

  error = (error) ->
    RSLLoading.loading_finish()
    $scope.errors.push 'サーバーエラー'
    $q.reject('something error');
