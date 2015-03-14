'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, marked, UserManageAPI) ->
  $scope.markdown = ''
  $scope.pre = ''
  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown)
  $scope.postDoc = () ->
    doc =
      user_id: 1
      content: $scope.markdown
      title: "testTitle"
    UserManageAPI.create doc, (result) ->
      console.log result
