'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope, $state, marked, WikiAPI, _, storage) ->
  $scope.markdown = ''
  $scope.pre = ''
  $scope.title = ''
  $scope.tags = []
  $scope.editorOptions = 
    lineWrapping : true
    lineNumbers: true
    # matchBrackets: true
    # autofocus: true
    mode: 'markdown'

  $scope.markdown_change = (el) ->
    $scope.pre = marked(el.markdown)
  $scope.postDoc = () ->
    doc =
      user_id: storage.get('rsl.current_user').id
      content: $scope.markdown
      title: $scope.title
      tags: _.pluck($scope.tags, 'text')
    WikiAPI.create doc, (result) ->
      $state.go 'wiki_list'
    , (e) ->
      console.log e
