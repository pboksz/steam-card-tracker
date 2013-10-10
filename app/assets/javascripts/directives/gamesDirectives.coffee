angular.module('cardtracker').directive 'showGame', [
  '$compile', '$templateCache', 'Chart', 'Game', ($compile, $templateCache, Chart, Game) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        $(element).find('.collapse .icon').toggle()
        loading = $(element).parent().find('.loading')
        loading.toggle()

        unless scope.game.$resolved
          scope.$apply ->
            Game.show id: attributes.gameId, (game) ->
              scope.game = game
              $(element).find('.name').addClass('info')
              loading.find('.loading-icon').hide()
              loading.append($compile($templateCache.get('game.html'))(scope))
              Chart.render(loading.find('.regular .game-chart')[0], game.regular_dates, game.regular_data)
              Chart.render(loading.find('.foil .game-chart')[0], game.foil_dates, game.foil_data)
]

angular.module('cardtracker').directive 'toggleType', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      $(element).parent().find('.regular').toggle()
      $(element).parent().find('.foil').toggle()
      $(element).parent().find('.toggle-type .icon').toggle()
