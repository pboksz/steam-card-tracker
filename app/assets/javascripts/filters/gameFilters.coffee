angular.module('cardtracker').filter 'truncate', ->
  (text, length = 17, end = "...") ->
    if text.length > length
      text.substring(0, length) + end
    else
      text
