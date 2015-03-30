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
  .state 'create_wiki',
    url: '/create_wiki'
    templateUrl: 'views/create_wiki.html'
    controller: 'CreateWikiCtrl'
  .state 'edit_wiki',
    url: '/edit_wiki'
    templateUrl: 'views/edit_wiki.html'
    controller: 'EditWikiCtrl'

angular.module('RSLWikiApp').config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
  $httpProvider.interceptors.push (storage) ->
    request: (config)->
      config.headers['Rsl-Http-Access-Token'] = storage.get('rsl.access_token')
      config
]


#module化したライブラリ
angular.module('marked', []).factory 'marked', ()=> @.marked
angular.module('underscore', []).factory '_', ()=> @._
