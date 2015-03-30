'use strict'
test_url = 'http://127.0.0.1:3000/api'
url = ''

angular.module('RSLWikiApp').factory "Users", ($location, $resource) ->
  $resource "#{test_url}/users",
      null
    ,
      create:
        method: 'POST'
        isArray: false

angular.module('RSLWikiApp').factory "SessionAPI", ($location, $resource) ->
  $resource "#{test_url}/sessions",
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
      logout:
        method: 'DELETE'
        url: "/session"
        params:
          auth_token: '@auth_token'
        isArray: false

angular.module('RSLWikiApp').factory "WikiAPI", ($location, $resource) ->
  $resource "#{test_url}/documents",
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
