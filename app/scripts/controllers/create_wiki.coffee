'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, $state, marked, WikiAPI, _, storage) ->
  $scope.markdown =
    content: ''
  $scope.pre = ''
  $scope.title = ''
  $scope.tags = []
  $scope.editorOptions =
    lineWrapping : true
    lineNumbers: true
    mode: 'markdown'

  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown.content)

  $scope.postDoc = () ->
    $scope.errors = []
    if !$scope.title
      $scope.errors.push 'タイトルを入れてください'
    if !$scope.markdown.content
      $scope.errors.push '内容を入れてください'
    return if $scope.errors.length > 0
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown.content
      title: $scope.title
      tags: _.pluck($scope.tags, 'text')
    WikiAPI.create doc, (result) ->
      $state.go 'wiki_list'
    , (e) ->
      $scope.errors.push 'サーバーエラー'
