'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI, TagAPI, _, moment, RSLLoading, $q) ->
  $scope.candidate_tags = []
  $scope.selected_tags = []
  search_tag_ids = []
  tags = []
  wikis = []
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
    wikis = success[0]
    for wiki in wikis
      wiki.created_at = moment(wiki.created_at).fromNow()
    $scope.display_wikis = wikis
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
      $scope.candidate_tags.push({name:'一致するものはありません'}) if $scope.candidate_tags.length == 0

  tag_search = ()=>
    tag_ids = []
    $scope.display_wikis = []
    for tag in $scope.selected_tags
      tag_ids.push tag.id
    for wiki in wikis
      if(_.every(tag_ids, (num)-> return wiki.tag_ids.indexOf(num) != -1))
        $scope.display_wikis.push wiki

  $scope.set_tag = (tag)=>
    $scope.selected_tags.push(tag)
    $scope.candidate_tags = []
    $scope.input = {name: ''}
    tag_search()

  $scope.delete_tag = (index) =>
    $scope.selected_tags.splice(index,1)
    tag_search()
