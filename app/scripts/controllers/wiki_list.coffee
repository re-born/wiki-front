'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, moment, RSLLoading) ->
  RSLLoading.loading_start()
  WikiAPI.get_list (result)->
    RSLLoading.loading_finish()
    $scope.wikis = result
    for wiki in $scope.wikis
      wiki.created_at = moment(wiki.created_at).fromNow()
  ,(e)->
    RSLLoading.loading_finish()
