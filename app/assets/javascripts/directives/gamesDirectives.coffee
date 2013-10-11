angular.module('cardtracker').directive 'showGame', [
  '$compile', '$templateCache', 'Chart', 'Game', ($compile, $templateCache, Chart, Game) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        $(element).find('.icon').toggle()
        gameElement.find('.loading').toggle()

        unless scope.game.$resolved
          scope.$apply ->
            Game.show id: attributes.gameId, (game) ->
              scope.game = game
              $(element).find('.name').addClass('info')
              gameElement.find('.toggle-type').show()
              gameElement.find('.loading-icon').hide()
              gameElement.find('.loading').append($compile($templateCache.get('game.html'))(scope))
              Chart.render(gameElement.find('.regular .game-chart')[0], game.regular_dates, game.regular_data)
              Chart.render(gameElement.find('.foil .game-chart')[0], game.foil_dates, game.foil_data)
]

angular.module('cardtracker').directive 'toggleType', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      gameElement = $(element).closest('.game')
      gameElement.find('.regular').toggle()
      gameElement.find('.foil').toggle()
      gameElement.find('.toggle-type .icon').toggle()
