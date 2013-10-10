angular.module('cardtracker').factory 'Chart', ->
  render: (containerId, seriesDates, seriesData) ->
    new Highcharts.Chart
      chart:
        renderTo: containerId
        type: 'arearange'
        width: $(document).width() - 300
        backgroundColor: 'rgba(255, 255, 255, 0.0)'
      title:
        text: ""
      xAxis:
        categories: seriesDates
      yAxis:
        title:
          text: ""
      tooltip:
        crosshairs: true
        formatter: ->
          '<b>' + this.point.series.name + '</b> on ' + this.x + '<br/>' +
          '<b>$' + this.point.low + '</b> to $' + this.point.high
      series: seriesData
