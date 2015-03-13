angular.module('cardtracker').directive 'toggleGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        if scope.game.items && scope.game.items.length > 0
          toggleGameCards(gameElement)
        else
          loadGame(scope, gameElement, attributes.id, Game, Chart, $compile, $templateCache)
]

angular.module('cardtracker').directive 'reloadGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        loadGame(scope, gameElement, attributes.id, Game, Chart, $compile, $templateCache, false)
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500

loadGame = (scope, gameElement, gameId, Game, Chart, $compile, $templateCache, toggle = true) ->
  spinReloadingIcon(gameElement)
  scope.$apply ->
    Game.show id: gameId,
      (success) ->
        scope.game.items = success.items
        gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
        Chart.render(gameElement.find('.game-chart')[0], success.data)
        toggleGameCards(gameElement) if toggle
        addClassToTitle(gameElement, 'success')
        stopReloadingIcon(gameElement)
      (error) ->
        addClassToTitle(gameElement, 'warning')
        stopReloadingIcon(gameElement)

toggleGameCards = (gameElement) ->
  gameElement.find('.game-cards').toggle()
  gameElement.find('.collapse i').toggle()

spinReloadingIcon = (gameElement) ->
  gameElement.find('.reload-game i').addClass('fa-spin')

stopReloadingIcon = (gameElement) ->
  gameElement.find('.reload-game i').removeClass('fa-spin')

addClassToTitle = (gameElement, className) ->
  gameElement.find('.game-title').addClass(className)
