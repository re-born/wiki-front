'use strict'

angular.module('RSLWikiApp').controller 'EditWikiCtrl', ($scope, $state, marked, WikiAPI, _, storage) ->
  wiki_id = $state.params.wiki_id
  $scope.tags = []
  WikiAPI.get {"id":wiki_id},(result)=>
    wiki = result
    $scope.title = wiki.title
    $scope.user_name = wiki.user.name
    $scope.markdown =
      content: wiki.content
    $scope.pre = marked($scope.markdown)
    _.each wiki.tags, (tag)=>
      $scope.tags.push {"text":tag.name}
  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown.content)
  $scope.postDoc = () ->
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown.content
      title: $scope.title
      tags: _.pluck($scope.tags, 'text')
    WikiAPI.update {"id":wiki_id},doc, (result) ->
      $state.go 'wiki_list'
    , (e) ->
      console.log e