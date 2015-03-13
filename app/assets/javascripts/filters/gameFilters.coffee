angular.module('cardtracker').filter 'truncate', ->
  (text, length = 23, end = "...") ->
    if text.length > length
      text.substring(0, length) + end
    else
      text
