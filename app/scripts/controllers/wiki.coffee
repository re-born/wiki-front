'use strict'

angular.module('RSLWikiApp').controller 'WikiCtrl', ($scope, $state, marked, WikiAPI, storage, RSLLoading) ->
  current_user = storage.get('rsl.current_user')
  $scope.wiki_id = $state.params.wiki_id
  $scope.is_edit = false
  RSLLoading.loading_start()

  WikiAPI.get {"id":$scope.wiki_id},(result)=>
    RSLLoading.loading_finish()
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
    RSLLoading.loading_start()
    WikiAPI.delete {"id":$scope.wiki_id}, (result)->
      RSLLoading.loading_finish()
      swal("削除しました", "", "success")
      $state.go 'wiki_list'
    ,(error)->
      RSLLoading.loading_finish()
      swal("失敗しました", "", "error")
