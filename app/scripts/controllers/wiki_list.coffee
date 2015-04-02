'use strict'

angular.module('RSLWikiApp').controller 'WikiListCtrl', ($scope, WikiAPI) ->
  WikiAPI.get_list (result)->
    $scope.wikis = result
