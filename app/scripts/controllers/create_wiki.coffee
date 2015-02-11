'use strict'

angular.module('RSLWikiApp').controller 'CreateWikiCtrl', ($scope,marked) ->
  $scope.markdown = ''
  $scope.pre = ''
  $scope.markdown_change = ()->
    $scope.pre = marked($scope.markdown)
