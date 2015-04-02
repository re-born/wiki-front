'use strict'

angular.module('RSLWikiApp', ['ui.router','ngCookies','ngResource','ngSanitize','marked','ngTagsInput','underscore', 'angularLocalStorage'])
.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/login'
  $stateProvider.state 'login',
    url: '/login'
    auth: false
    templateUrl: 'views/login.html'
    controller: 'LoginCtrl'
  .state 'main',
    url: '/main'
    templateUrl: 'views/main.html'
    controller: 'MainCtrl'
  .state 'wiki_list',
    url: '/wiki_list'
    templateUrl: 'views/wiki_list.html'
    controller: 'WikiListCtrl'
  .state 'wiki',
    url: 'wiki/:wiki_id'
    templateUrl: 'views/wiki.html'
    controller: 'WikiCtrl'
  .state 'create_wiki',
    url: '/create_wiki'
    templateUrl: 'views/create_wiki.html'
    controller: 'CreateWikiCtrl'
  .state 'edit_wiki',
    url: '/edit_wiki/:wiki_id'
    templateUrl: 'views/edit_wiki.html'
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
        # storage.clearAll()
      $q.reject(rejection)
]


#module化したライブラリ
angular.module('marked', []).factory 'marked', ()=> @.marked
angular.module('underscore', []).factory '_', ()=> @._
