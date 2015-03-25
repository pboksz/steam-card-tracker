angular.module('cardtracker').directive 'toggleGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        if scope.game.items && scope.game.items.length > 0
          toggleGameCards(gameElement)
        else
          loadGame(gameElement, Game, Chart, $compile, $templateCache)
]

angular.module('cardtracker').directive 'reloadGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        loadGame(gameElement, Game, Chart, $compile, $templateCache, false)
]

angular.module('cardtracker').directive 'loadAllGames', [
  'Chart', 'Game', '$compile', '$templateCache', '$timeout', (Chart, Game, $compile, $templateCache, $timeout) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        $('.game').each (index, game) ->
          $timeout ->
            loadGame($(game), Game, Chart, $compile, $templateCache, false)
          , 5000 * index
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500

loadGame = (gameElement, Game, Chart, $compile, $templateCache, toggle = true) ->
  gameElement.focus()
  scope = gameElement.scope()
  startTime = getCurrentMilliseconds()
  spinReloadingIcon(gameElement)
  scope.$apply ->
    Game.show id: gameElement.attr('id'),
      (success) ->
        scope.game.items = success.items
        scope.game.updated = success.updated
        gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
        Chart.render(gameElement.find('.game-chart')[0], success.data)
        toggleGameCards(gameElement) if toggle
        addClassToTitle(gameElement, 'success')
        calculateTimeToLoad(gameElement, startTime)
        stopReloadingIcon(gameElement)
      (error) ->
        addClassToTitle(gameElement, 'warning')
        calculateTimeToLoad(gameElement, startTime)
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

getCurrentMilliseconds = ->
  new Date().getTime()

calculateTimeToLoad = (gameElement, startTime) ->
  timeToLoad = (getCurrentMilliseconds() - startTime) / 1000
  gameElement.find('.time-to-load').text("#{timeToLoad} seconds")
