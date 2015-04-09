'use strict'

angular.module('RSLWikiApp').controller 'WikiCtrl', ($scope, $state, marked, WikiAPI, storage) ->
  current_user = storage.get('rsl.current_user')
  $scope.wiki_id = $state.params.wiki_id
  $scope.is_edit = false

  WikiAPI.get {"id":$scope.wiki_id},(result)=>
    wiki = result
    if current_user.id == wiki.user_id
      $scope.is_edit = true
    $scope.title = wiki.title
    $scope.user_name = wiki.user.name
    $scope.content = marked(wiki.content)