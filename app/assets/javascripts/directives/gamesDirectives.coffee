angular.module('cardtracker').directive 'toggleGame', [
  'Chart', 'Game', '$compile', '$templateCache', (Chart, Game, $compile, $templateCache) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        if scope.game.items && scope.game.items.length > 0
          toggleGameCards(gameElement)
        else
          showGame(gameElement, Game, Chart, $compile, $templateCache)
]

angular.module('cardtracker').directive 'reloadGame', [
  'Chart', 'Game', '$compile', '$templateCache', '$timeout', (Chart, Game, $compile, $templateCache, $timeout) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        parseGame(gameElement, Game, $timeout, true)
]

angular.module('cardtracker').directive 'loadAllGames', [
  'Chart', 'Game', '$compile', '$templateCache', '$timeout', (Chart, Game, $compile, $templateCache, $timeout) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        $('.game').each (index, game) ->
          parseGameWithTimeout($(game), Game, $timeout, 8000 * index, true)
]

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)
    $(element).on 'click', ->
      $('html,body').animate { scrollTop: 0 }, 500

showGame = (gameElement, Game, Chart, $compile, $templateCache) ->
  spinReloadingIcon(gameElement)
  scrollToGame(gameElement)
  scope = gameElement.scope()
  startTime = getCurrentMilliseconds()
  scope.$apply ->
    Game.show id: gameElement.attr('id'),
      (success) ->
        scope.game.items = success.items
        scope.game.price_per_badge = success.price_per_badge
        gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
        Chart.render(gameElement.find('.game-chart')[0], success.data)
        toggleGameCards(gameElement)
        loadSuccess(gameElement, startTime)
      (error) ->
        loadError(gameElement, startTime, error)

parseGameWithTimeout = (gameElement, Game, $timeout, wait, retry = false) ->
  $timeout ->
    parseGame(gameElement, Game, $timeout, retry)
  , wait

parseGame = (gameElement, Game, $timeout, retry = false) ->
  spinReloadingIcon(gameElement)
  scrollToGame(gameElement)
  scope = gameElement.scope()
  startTime = getCurrentMilliseconds()
  scope.$apply ->
    Game.show id: gameElement.attr('id'), action: 'parse',
      (success) ->
        scope.game.price_per_badge = success.price_per_badge
        scope.game.updated_today = success.updated_today
        loadSuccess(gameElement, startTime)
      (error) ->
        loadError(gameElement, startTime, error)
        parseGameWithTimeout(gameElement, Game, $timeout, 2000, false) if retry

scrollToGame = (gameElement) ->
  $('html,body').animate { scrollTop: gameElement.offset().top - 88 }, 200

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

calculateTimeToLoad = (gameElement, startTime, error = null) ->
  timeToLoad = ((getCurrentMilliseconds() - startTime) / 1000).toFixed(2)
  timeText = "#{timeToLoad} seconds"
  timeText += " | #{error.data}" if error?
  gameElement.find('.time-to-load').text(timeText)

loadSuccess = (gameElement, startTime) ->
  addClassToTitle(gameElement, 'success')
  calculateTimeToLoad(gameElement, startTime)
  stopReloadingIcon(gameElement)

loadError = (gameElement, startTime, error) ->
  addClassToTitle(gameElement, 'warning')
  calculateTimeToLoad(gameElement, startTime, error)
  stopReloadingIcon(gameElement)
