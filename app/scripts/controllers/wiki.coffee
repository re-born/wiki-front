'use strict'

angular.module('RSLWikiApp').controller 'WikiCtrl', ($scope, $state, marked, WikiAPI, _, storage) ->
  $state.params.wiki_id
  WikiAPI.get