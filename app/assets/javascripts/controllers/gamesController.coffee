angular.module('cardtracker').controller 'GamesController', [
  '$scope', 'Game', ($scope, Game) ->
    $scope.games = Game.index()
]
