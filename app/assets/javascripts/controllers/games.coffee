angular.module('cardtracker').controller 'GamesController', [
  '$scope', 'Game', ($scope, Game) ->
    chart_width = $(document).width() - 300

    $scope.games = Game.index (games) ->
      _.each games, (game) ->
        Game.show id: game.id, (loadedGame) ->
          $scope.games[$scope.games.indexOf(game)] = loadedGame
          $scope.$apply()
          $('#game' + loadedGame.id).find('.icon-spin').hide()
          renderNewChart('chart' + loadedGame.id, loadedGame.series_dates, loadedGame.series_data, chart_width)

    $scope.showGame = (event) ->
      $(event.currentTarget).next().toggle()
]

renderNewChart = (container_id, series_dates, series_data, chart_width) ->
  new Highcharts.Chart
    chart:
      renderTo: container_id
      type: 'arearange'
      width: chart_width
    title:
      text: ""
    xAxis:
      categories: series_dates
    yAxis:
      title:
        text: ""
    tooltip:
      crosshairs: true
      formatter: ->
        '<b>' + this.point.series.name + '</b> on ' + this.x + '<br/>' +
        '<b>$' + this.point.low + '</b> to $' + this.point.high
    series: series_data
