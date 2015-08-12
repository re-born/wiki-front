'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, TagAPI, moment, RSLLoading, $q) ->
  tags = []
  $scope.candidate_tags = []
  $scope.selected_tags = []
  RSLLoading.loading_start()

  $scope.input = {
    name:''
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
  , (error)=>
    RSLLoading.loading_finish()
  )

  $scope.edit_search_tag = () =>
    $scope.candidate_tags = []
    if $scope.input.name != ''
      for tag in tags
        if tag.name.indexOf($scope.input.name) != -1
          $scope.candidate_tags.push tag

  tag_search = ()=>

  $scope.set_tag = (tag)=>
    $scope.selected_tags.push(tag)
    $scope.candidate_tags = []
    $scope.input = {name: ''}
