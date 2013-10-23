angular.module('cardtracker').directive 'showGame', [
  '$compile', '$templateCache', 'Chart', 'Game', ($compile, $templateCache, Chart, Game) ->
    restrict: 'C'
    link: (scope, element, attributes) ->
      $(element).on 'click', ->
        gameElement = $(element).closest('.game')
        gameElement.find('.loading').toggle()
        gameElement.find('.toggle-type').toggle()
        $(element).find('.icon').toggle()

        unless scope.game.$resolved
          scope.$apply ->
            Game.show id: attributes.gameId, (game) ->
              if game.error
                gameElement.find('.loading').toggle()
                $(element).find('.icon').toggle()
                $(element).find('.name').addClass('warning')
              else
                scope.game = game
                $(element).find('.name').addClass('info')
                gameElement.find('.loading-icon').hide()
                gameElement.find('.loading').append($compile($templateCache.get('game.html'))(scope))
                Chart.render(gameElement.find('.regular .game-chart')[0], game.regular_dates, game.regular_data)
                Chart.render(gameElement.find('.foil .game-chart')[0], game.foil_dates, game.foil_data)

                if $('.game .name[class="name ng-binding info"]').length == $('.game').length
                  $('.app-title').addClass('info')
                  $('.app-actions .icons').toggle()
]

angular.module('cardtracker').directive 'toggleType', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      gameElement = $(element).closest('.game')
      gameElement.find('.regular').toggle()
      gameElement.find('.foil').toggle()
      gameElement.find('.toggle-type .icon').toggle()

angular.module('cardtracker').directive 'loadAll', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      $('.app-actions').find('.icons').toggle()
      $('.game .loading:hidden').prevAll().find('.show-game').click()

angular.module('cardtracker').directive 'collapseAll', ->
  restrict: 'C'
  link: (scope, element) ->
    $(element).on 'click', ->
      $('.game .loading:visible').prevAll().find('.show-game').click()

angular.module('cardtracker').directive 'scrollTop', ->
  restrict: 'C'
  link: (scope, element) ->
    $(window).scroll ->
      if $(window).scrollTop() > 100 then $(element).fadeIn(300) else $(element).fadeOut(300)

    $(element).on 'click', ->
      $('body').animate { scrollTop: 0 }, 500
