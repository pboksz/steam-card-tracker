angular.module('cardtracker').controller 'GamesController', [
  '$scope', 'Game', ($scope, Game) ->
    $scope.games = Game.index (games) ->
      _.each games, (game) ->
        Game.show id: game.id, (loadedGame) ->
          $scope.games[$scope.games.indexOf(game)] = loadedGame
          $scope.$apply()
          $('#game' + loadedGame.id).find('.icon-spin').hide()
          renderNewChart('chart' + loadedGame.id, loadedGame.series_dates, loadedGame.series_data)

    $scope.showGame = (event) ->
      $(event.currentTarget).next().toggle()
]

renderNewChart = (container_id, series_dates, series_data) ->
  new Highcharts.Chart
    chart:
      renderTo: container_id
      type: 'arearange'
    title:
      text: ""
    xAxis:
      categories: series_dates
    yAxis:
      title:
        text: ""
    plotOptions:
      arearange:
        connectNulls: true
    tooltip:
      crosshairs: true
      formatter: ->
        '<b>' + this.point.series.name + '</b> on ' + this.x + '<br/>' +
        '<b>$' + this.point.low + '</b> to $' + this.point.high
    series: series_data
