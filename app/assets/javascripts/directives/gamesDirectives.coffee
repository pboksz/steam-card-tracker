angular.module('cardtracker').directive 'gameChart', [
  'Chart', (Chart) ->
    restrict: 'C'
    scope:
      game: '=game'
    link: (scope, element, attributes) ->
      if attributes.type == 'regular'
        Chart.render($(element).get(0), scope.game.regular_dates, scope.game.regular_data)
      else if attributes.type == 'foil'
        Chart.render($(element).get(0), scope.game.foil_dates, scope.game.foil_data)
]

angular.module('cardtracker').directive 'toggleGame', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      gameElement = $(element).closest('.game')
      gameElement.find('.game-cards').toggle()
      gameElement.find('.collapse i').toggle()

angular.module('cardtracker').directive 'toggleType', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      gameElement = $(element).closest('.game')
      gameElement.find('.toggle-type i').toggle()
      gameElement.find('.regular').toggle()
      gameElement.find('.foil').toggle()

angular.module('cardtracker').directive 'reloadGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        gameElement.find('.reload-game i').addClass('fa-spin')
        Game.show { id: attributes.id }, (game) ->
          scope.game = game
          gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
          Chart.render(gameElement.find('.regular .game-chart')[0], game.regular_dates, game.regular_data)
          Chart.render(gameElement.find('.foil .game-chart')[0], game.foil_dates, game.foil_data)
          gameElement.find('.reload-game i').removeClass('fa-spin')
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500
