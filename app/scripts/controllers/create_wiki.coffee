'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, $state, marked, WikiAPI, _, storage, TagAPI, RSLLoading) ->
  $scope.markdown =
    content: ''
  $scope.pre = ''
  $scope.title = ''
  $scope.tags = []
  $scope.editorOptions =
    lineWrapping : true
    lineNumbers: true
    mode: 'markdown'

  $scope.load_tags = () ->
    return TagAPI.get_all().$promise

  $scope.markdown_change = () ->
    $scope.pre = marked($scope.markdown.content)
    previewElement = document.getElementById("preview-area")
    MathJax.Hub.Typeset(previewElement)

  $scope.postDoc = () ->
    $scope.errors = []
    if !$scope.title
      $scope.errors.push 'タイトルを入れてください'
    if !$scope.markdown.content
      $scope.errors.push '内容を入れてください'
    return if $scope.errors.length > 0
    RSLLoading.loading_start()
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown.content
      title: $scope.title
      tags: _.pluck($scope.tags, 'name')
    WikiAPI.create doc, (result) ->
      RSLLoading.loading_finish()
      $state.go 'wiki_list'
    , (e) ->
      RSLLoading.loading_finish()
      $scope.errors.push 'サーバーエラー'
