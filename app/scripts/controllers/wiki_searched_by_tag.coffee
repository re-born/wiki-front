'use strict'

angular.module('RSLWikiApp').controller 'WikiSearchedByTagCtrl', ($scope, $state, TagAPI, RSLLoading) ->
  RSLLoading.loading_start()
  tag_id = $state.params.tag_id
  TagAPI.get_searched {"tag_id": tag_id}, (result)->
    RSLLoading.loading_finish()
    $scope.wikis = result
  ,(e)->
    RSLLoading.loading_finish()
