$(document).ready ->
  $('.game-items').each (index, game) ->
    $.ajax
      url: '/update_stats'
      dataType: 'json'
      type: 'POST'
      data:
        id: $(game).find('.game-info').data('id')
        items: getAllItemInfo(game)
      success: (result) ->
        console.log(result)
        renderNewChart("container" + result.id, result.series)

getAllItemInfo = (game) ->
  items = []

  $(game).find('.steam-card-tracker-listing').each (index, item) ->
    info = $(item).find('.info')
    items.push({id: info.data('id'), quantity: info.data('quantity'), price: info.data('price')})

  items

getAllSeries = (allSeries) ->
  all = []

  $(allSeries).each (index, series) ->
    all.push({ name: series.name, data: series.data })

  all

renderNewChart = (containerId, series) ->
  new Highcharts.Chart
    chart:
      renderTo: containerId
      type: 'columnrange'
    title:
      text: ""
#    xAxis:
#      categories: ""
    tooltip:
      formatter: ->
        "$" + this.y
    legend:
      enabled: false
    series: getAllSeries(series)
