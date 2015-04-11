'use strict'

angular.module('RSLWikiApp').controller 'WikiSearchedByTagCtrl', ($scope, $state, TagAPI) ->
  tag_id = $state.params.tag_id
  TagAPI.get_searched {"tag_id": tag_id}, (result)->
    $scope.wikis = result