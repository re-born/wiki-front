'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, moment) ->
  WikiAPI.get_list (result)->
    $scope.wikis = result
    for wiki in $scope.wikis
      wiki.created_at = moment(wiki.created_at).fromNow()
