angular.module('cardtracker').factory 'Game', [
  '$resource', ($resource) ->
    $resource '/api/games/:id', { id: '@id' },
      index:
        method:'GET'
        isArray:true
      show:
        method: 'GET'
]
