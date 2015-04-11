'use strict'

angular.module('RSLWikiApp', ['ui.router','ngCookies','ngResource','ngSanitize','marked','ngTagsInput','underscore', 'angularLocalStorage', 'ui.codemirror', 'ngMaterial'])
.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/login'

  wiki_header =
    header:
      templateUrl: 'views/header.html'
      controller: 'HeaderCtrl'

  $stateProvider.state 'login',
    url: '/login'
    auth: false
    views:
      content:
        templateUrl: 'views/login.html'
        controller: 'LoginCtrl'
  $stateProvider.state 'sign_up',
    url: '/sign_up'
    auth: false
    views:
      content:
        templateUrl: 'views/sign_up.html'
        controller: 'SignUpCtrl'
  .state 'main',
    url: '/main'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
  .state 'wiki_list',
    url: '/wiki_list'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/wiki_list.html'
        controller: 'WikiListCtrl'
  .state 'wiki',
    url: '/wiki/:wiki_id'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/wiki.html'
        controller: 'WikiCtrl'
  .state 'wiki_searched_by_tag',
    url: 'tags/:tag_id/wiki'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/wiki_list.html'
        controller: 'WikiSearchedByTagCtrl'
  .state 'create_wiki',
    url: '/create_wiki'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/wiki_form.html'
        controller: 'CreateWikiCtrl'
  .state 'edit_wiki',
    url: '/edit_wiki/:wiki_id'
    views:
      header: wiki_header.header
      content:
        templateUrl: 'views/wiki_form.html'
        controller: 'EditWikiCtrl'

angular.module('RSLWikiApp').config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
  $httpProvider.interceptors.push ($q, storage, $location) ->
    request: (config)->
      config.headers['Rsl-Http-Access-Token'] = storage.get('rsl.access_token')
      config
    responseError: (rejection)->
      if rejection.status == 401
        $location.path '/login'
        storage.clearAll()
      $q.reject(rejection)
]


#module化したライブラリ
angular.module('marked', []).factory 'marked', ()=> @.marked
angular.module('underscore', []).factory '_', ()=> @._
