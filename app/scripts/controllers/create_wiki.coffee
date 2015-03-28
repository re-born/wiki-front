'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, marked, UserManageAPI, _) ->
  $scope.markdown = ''
  $scope.pre = ''
  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown)
  $scope.postDoc = () ->
    doc =
      user_id: 1
      content: $scope.markdown
      title: $scope.title
      tags: _.pluck($scope.tags, 'text')
    UserManageAPI.create doc, (result) ->
      console.log result
    , (e) ->
      console.log e
