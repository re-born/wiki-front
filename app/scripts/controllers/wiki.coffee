'use strict'

angular.module('RSLWikiApp').controller 'WikiCtrl', ($scope, $state, marked, WikiAPI, storage) ->
  current_user = storage.get('rsl.current_user')
  $scope.wiki_id = $state.params.wiki_id
  $scope.is_edit = false

  WikiAPI.get {"id":$scope.wiki_id},(result)=>
    wiki = result
    if current_user.id == wiki.user_id
      $scope.is_edit = true
    $scope.title = wiki.title
    $scope.tags = wiki.tags
    $scope.user_name = wiki.user.name
    $scope.content = marked(wiki.content)

  $scope.show_comfirmation = ()->
    swal {
      title: "削除しますか?"
      type: "warning"
      showCancelButton: true
      confirmButtonColor: "#DD6B55"
      confirmButtonText: "削除する"
      closeOnConfirm: false
    },()->
      wiki_delete()

  wiki_delete = ()->
    WikiAPI.delete {"id":$scope.wiki_id}, (result)->
      swal("削除しました", "", "success")
      $state.go 'wiki_list'
    ,(error)->
      swal("失敗しました", "", "error")
