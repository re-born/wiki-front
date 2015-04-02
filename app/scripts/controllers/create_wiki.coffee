'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, $state, marked, WikiAPI, _, storage) ->
  $scope.markdown = ''
  $scope.pre = ''
  $scope.title = ''
  $scope.tags = []
  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown)
  $scope.postDoc = () ->
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown
      title: $scope.title
      tags: _.pluck($scope.tags, 'text')
    WikiAPI.create doc, (result) ->
      console.log result
    , (e) ->
      console.log e