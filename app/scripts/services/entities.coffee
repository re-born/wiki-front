'use strict'
url = ''

angular.module('RSLWikiApp').factory "Sessions", ($location, $resource) ->
  $resource "#{url}/session",
      null
    ,
      login:
        method: 'POST'
        isArray: false
      check:
        method: 'GET'
        url: "/session/check"
        params:
          auth_token: '@auth_token'
        isArray: false
      get_current_user:
        method: 'GET'
        isArray: false
      logout:
        method: 'DELETE'
        url: "/session"
        params:
          auth_token: '@auth_token'
        isArray: false

angular.module('RSLwikiApp').factory "UserManageAPI", ($location, $resource) ->
  $resource "#{url}/wiki",
      null
    ,
      get_list:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
        isArray: false
      delete:
        method: 'DELETE'
        params:
          id: '@id'
        isArray: false
      update:
        method: 'PUT'
        url: "/wiki/:id"
        isArray: false