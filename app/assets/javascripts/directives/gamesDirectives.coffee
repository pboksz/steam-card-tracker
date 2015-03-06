angular.module('cardtracker').directive 'gameChart', [
  'Chart', (Chart) ->
    restrict: 'C'
    scope:
      game: '=game'
    link: (scope, element) ->
      Chart.render($(element).get(0), scope.game.data)
]

angular.module('cardtracker').directive 'toggleGame', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      gameElement = $(element).closest('.game')
      gameElement.find('.game-cards').toggle()
      gameElement.find('.collapse i').toggle()

angular.module('cardtracker').directive 'reloadGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        gameElement.find('.reload-game i').addClass('fa-spin')

        scope.$apply ->
          Game.show id: attributes.id,
            (success) ->
              scope.game = success
              gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
              Chart.render(gameElement.find('.game-chart')[0], success.data)
              gameElement.find('.reload-game i').removeClass('fa-spin')
              gameElement.find('.game-title').addClass('success')
            (error) ->
              gameElement.find('.reload-game i').removeClass('fa-spin')
              gameElement.find('.game-title').addClass('warning')
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500
