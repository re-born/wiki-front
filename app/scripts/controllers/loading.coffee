'use strict'


angular.module('RSLWikiApp').factory 'RSLLoading', ($rootScope) ->
  loading_start: ()->
    $rootScope.$broadcast('loading_start')
  loading_finish: ()->
    $rootScope.$broadcast('loading_finish')

angular.module('RSLWikiApp').controller 'loadingCtrl', ($scope) ->
  $scope.hide = true
  $scope.$on 'loading_start', ()->
    $scope.hide = false
  $scope.$on 'loading_finish', ()->
    $scope.hide = true
