'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, TagAPI, moment, RSLLoading, $q) ->
  tags = []
  $scope.display_tags = []
  RSLLoading.loading_start()

  $scope.input = {
    tag:''
  }

  all = $q.all([
    WikiAPI.get_list().$promise,
    TagAPI.get_all().$promise
  ])

  all.then((success)=>
    RSLLoading.loading_finish()
    $scope.wikis = success[0]
    for wiki in $scope.wikis
      wiki.created_at = moment(wiki.created_at).fromNow()
    tags = success[1]
    console.log tags
  , (error)=>
    RSLLoading.loading_finish()
  )

  $scope.edit_search_tag = () =>
    $scope.display_tags = []
    if $scope.input.tag != ''
      for tag in tags
        if tag.name.indexOf($scope.input.tag) != -1
          $scope.display_tags.push tag
