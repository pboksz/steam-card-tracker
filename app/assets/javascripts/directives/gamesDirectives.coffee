angular.module('cardtracker').directive 'toggleGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        if scope.game.data
          toggleGameCards(gameElement)
        else
          spinReloadingIcon(gameElement)
          scope.$apply ->
            Game.show id: attributes.id,
              (success) ->
                scope.game = success
                gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
                Chart.render(gameElement.find('.game-chart')[0], success.data)
                toggleGameCards(gameElement)
                addClassToTitle(gameElement, 'success')
                stopReloadingIcon(gameElement)
              (error) ->
                addClassToTitle(gameElement, 'warning')
                stopReloadingIcon(gameElement)
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500

toggleGameCards = (gameElement) ->
  gameElement.find('.game-cards').toggle()
  gameElement.find('.collapse i').toggle()

spinReloadingIcon = (gameElement) ->
  gameElement.find('.reload-game i').addClass('fa-spin')

stopReloadingIcon = (gameElement) ->
  gameElement.find('.reload-game i').removeClass('fa-spin')

addClassToTitle = (gameElement, className) ->
  gameElement.find('.game-title').addClass(className)
