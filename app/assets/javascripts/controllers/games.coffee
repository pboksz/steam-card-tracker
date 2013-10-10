angular.module('cardtracker').controller 'GamesController', [
  '$scope', 'Game', ($scope, Game) ->
    chart_width = $(document).width() - 300

    $scope.games = Game.index (games) ->
      _.each games, (game) ->
        Game.show id: game.id, (loadedGame) ->
          $scope.games[$scope.games.indexOf(game)] = loadedGame
          $scope.$apply() #TODO digest called twice
          $('#game' + loadedGame.id).find('.icon-spin').hide()
          $('#game' + loadedGame.id).find('.icon-collapse').show()
          renderNewChart('regular' + loadedGame.id, loadedGame.regular_dates, loadedGame.regular_data, chart_width)
          renderNewChart('foil' + loadedGame.id, loadedGame.foil_dates, loadedGame.foil_data, chart_width)

    $scope.showGame = (event) ->
      $(event.currentTarget).next().toggle()

    $scope.toggleCardType = (event) ->
      $('.regular').toggle()
      $('.foil').toggle()
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
