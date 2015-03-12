'use strict'

angular.module('RSLWikiApp', ['ui.router','ngCookies','ngResource','ngSanitize','marked'])
.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/main'
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
  .state 'animation_test',
    url: '/anime'
    templateUrl: 'views/animation_test.html'
    controller: 'AnimationTestCtrl'


#module化したライブラリ
angular.module('marked', []).factory 'marked', ()=> @.marked
