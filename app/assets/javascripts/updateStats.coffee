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
        renderNewChart("container" + result.id, result.dates, result.series)

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

renderNewChart = (containerId, dates, series) ->
  new Highcharts.Chart
    chart:
      renderTo: containerId
      type: 'arearange'
    title:
      text: ""
    xAxis:
      categories: dates
    yAxis:
      title:
        text: ""
    plotOptions:
      arearange:
        connectNulls: true
    tooltip:
      crosshairs: true
      formatter: ->
        '<b>' + this.point.series.name + '</b> on ' + this.x + '<br/>' +
        '<b>$' + this.point.low + '</b> to $' + this.point.high
    series: getAllSeries(series)
