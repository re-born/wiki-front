'use strict'

angular.module('RSLWikiApp', ['ui.router','ngCookies','ngResource','ngSanitize'])
.config ($stateProvider, $urlRouterProvider) ->
  console.log 'aaa'
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