angular.module('cardtracker').factory 'Game', [
  '$resource', ($resource) ->
    $resource '/api/games/:id/:action', { id: '@id', action: '@action' },
      index:
        method:'GET'
        isArray:true
      show:
        method: 'GET'
]
