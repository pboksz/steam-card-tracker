angular.module('cardtracker').factory 'Chart', ->
  render: (containerId, seriesData) ->
    new Highcharts.Chart
      chart:
        backgroundColor: 'rgba(255, 255, 255, 0.0)'
        renderTo: containerId
        type: 'arearange'
        width: $('#steam-card-tracker').width() - 300
        zoomType: 'x'
      colors: ['#6DFF7F', '#A07DFF', '#FFE86D', '#FF756D', '#7AB2FF', '#FF6DD7', '#DAFF6D', '#FFC86D',
               '#25A835', '#4C2BA8', '#A89325', '#A82C25', '#295FA8', '#A82584', '#87A825', '#A87725']
      credits:
        enabled: false
      exporting:
        enabled: false
      plotOptions:
        arearange:
          animation:
            duration: 1000
          states:
            hover:
              lineWidth: 4
      series: seriesData
      title:
        text: ""
      tooltip:
        crosshairs: true
        formatter: ->
          '<b>' + this.point.series.name + '</b> on ' + Highcharts.dateFormat('%d.%m.%y', this.x) + '<br/>' +
          this.point.total + ' at <b>$' + this.point.low.toFixed(2) + '</b> to $' + this.point.high.toFixed(2)
      xAxis:
        type: 'datetime'
      yAxis:
        title:
          text: ""
