angular.module('RSLWikiApp').directive 'alertBar', ()->
  restrict: 'EA'
  templateUrl: "views/alert_bar.html"
  scope:
    messages: '='
    onChange: '&'
  link: (scope)->
    scope.$watch 'messages', ()->
      console.log 'change'