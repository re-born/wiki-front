'use strict'
url = 'http://127.0.0.1:3000/api'

angular.module('RSLWikiApp').factory "UserAPI", ($location, $resource) ->
  $resource "#{url}/users",
      null
    ,
      create:
        method: 'POST'
        isArray: false

angular.module('RSLWikiApp').factory "SessionAPI", ($location, $resource) ->
  $resource "#{url}/sessions",
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
        url: "#{url}/session"
        isArray: false

angular.module('RSLWikiApp').factory "WikiAPI", ($location, $resource) ->
  $resource "#{url}/documents/:id",
      id: "@id"
    ,
      get:
        method: 'GET'
        url: "#{url}/documents/:id"
        isArray: false
      get_list:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
        isArray: false
      delete:
        method: 'DELETE'
        url: "#{url}/documents/:id"
        isArray: false
      update:
        method: 'PATCH'
        url: "#{url}/documents/:id"
        isArray: false
