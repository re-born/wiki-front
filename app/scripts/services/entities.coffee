'use strict'

angular.module('RSLWikiApp').factory "UserAPI", ($location, $resource, Settings) ->
  url = Settings.api_url
  $resource "#{url}/users",
      null
    ,
      create:
        method: 'POST'
        isArray: false

angular.module('RSLWikiApp').factory "TagAPI", ($location, $resource, Settings) ->
  url = Settings.api_url
  $resource "#{url}/tags",
      null
    ,
      get_all:
        method: 'GET'
        isArray: true
      get_searched:
        method: 'GET'
        url: "#{url}/tags/:tag_id/documents"
        params:
          tag_id: '@tag_id'
        isArray: true

angular.module('RSLWikiApp').factory "SessionAPI", ($location, $resource, Settings) ->
  url = Settings.api_url
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
        isArray: false

angular.module('RSLWikiApp').factory "WikiAPI", ($location, $resource, Settings) ->
  url = Settings.api_url
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
