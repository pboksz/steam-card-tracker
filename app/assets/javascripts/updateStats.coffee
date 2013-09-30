$(document).ready ->
  $('.game_items').each (index, game) ->
    $.ajax
      url: '/update_stats'
      dataType: 'json'
      type: 'POST'
      data:
        items: getItemDetails(game)
      success: (result) ->
        console.log(result)

getItemDetails = (game) ->
  items = []

  $(game).find('.steam-card-tracker-listing').each (index, item) ->
    info = $(item).find('.info')
    items.push { id: info.data('id'), quantity: info.data('quantity'), price: info.data('price') }

  items
