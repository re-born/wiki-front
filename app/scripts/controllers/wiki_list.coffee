'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, TagAPI, moment, RSLLoading, $q) ->
  RSLLoading.loading_start()
  # WikiAPI.get_list (result)->
  #   RSLLoading.loading_finish()
  #   $scope.wikis = result
  #   for wiki in $scope.wikis
  #     wiki.created_at = moment(wiki.created_at).fromNow()
  # ,(e)->
  #   RSLLoading.loading_finish()
  all = $q.all([
    WikiAPI.get_list().$promise,
    TagAPI.get_all().$promise
  ])

  all.then((success)=>
    RSLLoading.loading_finish()
    $scope.wikis = success[0]
    for wiki in $scope.wikis
      wiki.created_at = moment(wiki.created_at).fromNow()
    $scope.tags = success[1]
  , (error)=>
    RSLLoading.loading_finish()
  )

  $scope.edit_search_tag = () =>
