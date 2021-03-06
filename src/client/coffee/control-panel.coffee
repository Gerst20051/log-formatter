$ = require 'jquery'

$ ->
  $('#controlPanel').on 'click', 'li', ->
    $(this).toggleClass 'active'
    switch $(this).attr('id')
      when 'searchControl' then toggleSearchControl()
      when 'eyeControl' then toggleEyeControl()
      when 'wrapControl' then toggleWrapControl()
      when 'clearControl'
        $('#hiddenLogs, #errorLogs, #normalLogs').empty()
        $('body').removeClass 'hidetextarea'
      when 'scrollTopControl'
        $('#mainContent').animate { scrollTop: 0 }, 'slow'
      when 'scrollBottomControl'
        $('#mainContent').animate { scrollTop: $('#logs').height() }, 'slow'
      else console.log 'unknown control'
    return
  return

toggleSearchControl = ->
  $('body').toggleClass 'searchopened'
  return

toggleEyeControl = ->
  $('body').toggleClass 'eyeopen'
  if $('body').hasClass 'eyeopen'
    $('#logs .log-row .log-row-content').addClass('eyeopened')
  else
    $('#logs .log-row .log-row-content').removeClass('eyeopened')
  return

toggleWrapControl = ->
  $('body').toggleClass 'wrapenabled'
  return
