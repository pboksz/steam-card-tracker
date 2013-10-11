angular.module('cardtracker').factory 'Chart', ->
  render: (containerId, seriesDates, seriesData) ->
    new Highcharts.Chart
      chart:
        renderTo: containerId
        type: 'arearange'
        width: $(document).width() - 300
        backgroundColor: 'rgba(255, 255, 255, 0.0)'
      colors: [ '#6DFF7F', '#A07DFF', '#FFE86D', '#FF756D', '#7AB2FF', '#FF6DD7', '#DAFF6D', '#FFC86D',
                '#25A835', '#4C2BA8', '#A89325', '#A82C25', '#295FA8', '#A82584', '#87A825', '#A87725', ]
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
