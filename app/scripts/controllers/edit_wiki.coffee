'use strict'

angular.module('RSLWikiApp').controller 'EditWikiCtrl', ($scope, $state, marked, WikiAPI, TagAPI, _, storage, RSLLoading) ->
  wiki_id = $state.params.wiki_id
  $scope.tags = []
  WikiAPI.get {"id":wiki_id},(result)=>
    wiki = result
    $scope.title = wiki.title
    $scope.user_name = wiki.user.name
    $scope.markdown =
      content: wiki.content
    $scope.pre = marked($scope.markdown.content)
    $scope.tags = wiki.tags
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
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown.content
      title: $scope.title
      tags: _.pluck($scope.tags, 'name')
    RSLLoading.loading_start()
    WikiAPI.update {"id":wiki_id},doc, (result) ->
      RSLLoading.loading_finish()
      $state.go 'wiki_list'
    , (e) ->
      RSLLoading.loading_finish()
      $scope.errors.push "サーバーエラー"
