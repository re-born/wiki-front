'use strict'

angular.module('RSLWikiApp').controller 'WikiCtrl', ($scope, $state, marked, WikiAPI) ->
  wiki_id = $state.params.wiki_id
  WikiAPI.get {"id":wiki_id},(result)=>
    wiki = result
    $scope.title = wiki.title
    $scope.user_name = wiki.user.name
    $scope.content = marked(wiki.content)