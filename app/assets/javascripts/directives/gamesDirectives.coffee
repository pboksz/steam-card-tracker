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

#TODO update this
angular.module('cardtracker').directive 'showGame', [
  '$compile', '$templateCache', 'Chart', 'Game', ($compile, $templateCache, Chart, Game) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        if scope.game.$resolved
          toggleGameCards($(element).closest('.game'))
        else
          if nothingLoading()
            scope.$apply ->
              toggleGame(element, $compile, $templateCache, Chart, Game)
]

angular.module('cardtracker').directive 'expandAll', [
  '$compile', '$templateCache', 'Chart', 'Game', ($compile, $templateCache, Chart, Game) ->
    restrict: 'C'
    link: (scope, element) ->
      $(element).on 'click', ->
        if nothingLoading()
          scope.$apply ->
            $('.game .game-cards:hidden').prevAll().find('.show-game').each (index, element) ->
              toggleGame(element, $compile, $templateCache, Chart, Game)
]

angular.module('cardtracker').directive 'collapseAll', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      $('.game .game-cards:visible').prevAll().find('.show-game').click()

angular.module('cardtracker').directive 'toggleType', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      if $(element).scope().game.$resolved
        gameElement = $(element).closest('.game')
        gameElement.find('.toggle-type .icon').toggle()
        gameElement.find('.regular').toggle()
        gameElement.find('.foil').toggle()

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)

    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500

nothingLoading = ->
  $('.game .loading:visible').length == 0

loadComplete = (gameElement, completeClass) ->
  gameElement.find('.name').addClass(completeClass)
  gameElement.find('.loading').hide()

toggleGameCards = (gameElement) ->
  gameElement.find('.game-cards').toggle()
  gameElement.find('.collapse .icon').toggle()

toggleGame = (element, $compile, $templateCache, Chart, Game) ->
  scope = $(element).scope()
  gameId = $(element).attr('id')
  gameElement = $(element).closest('.game')

  if !scope.game.$resolved
    gameElement.find('.loading').show()
    $.ajaxQueue(loadGame(scope, gameId, gameElement, $compile, $templateCache, Chart, Game))
  else
    gameElement.find('.game-cards').hide()

loadGame = (scope, gameId, gameElement, $compile, $templateCache, Chart, Game) ->
  Game.show id: gameId,
    (success) ->
      scope.game = success
      gameElement.find('.game-cards').append($compile($templateCache.get('game.html'))(scope))
      Chart.render(gameElement.find('.regular .game-chart')[0], success.regular_dates, success.regular_data)
      Chart.render(gameElement.find('.foil .game-chart')[0], success.foil_dates, success.foil_data)

      loadComplete(gameElement, 'info')
      toggleGameCards(gameElement)
    (error) ->
      loadComplete(gameElement, 'warning')
