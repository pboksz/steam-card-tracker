$('#highcharts').highcharts
  chart:
    type: 'line'
    events:
      load: itemData # which is ajax array of json objects
  tooltip:
    formatter: ->
      this.x + ' on ' + this.y
  series:
    data: []
