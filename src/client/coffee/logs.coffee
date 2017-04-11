$ = require 'jquery'
worker = require './webworkers.coffee'

logRows = []
parsedRows = []
processingRows = false

errorArray = [
  'Error'
  'error'
  'Exception'
  'exception'
  'Fatal'
  'fatal'
  'PDOException'
  'STDERR'
  'Undefined'
  'undefined'
  'Warning'
  'warning'
]

blacklistErrorArray = [
  'Paypal not configured for this operator'
]

parseLogInput = (data) ->
  if typeof data is 'object'
    logRows = logRows.concat data
    if processingRows is false
      processRows()
  return

addRows = (original_rows, rows) ->
  for row, index in rows
    addRow original_rows[index], row
  processingRows = false
  processRows()

addRow = (original_value, value) ->
  if 0 == original_value.indexOf 'tail'
    return
  $newLog = $ '<div class="log-row">' + value + '</div>'
  rowHasError = false
  errorArray.forEach (errorText) ->
    if -1 < original_value.indexOf errorText
      rowHasError = true
  rowHasBlacklistedError = false
  blacklistErrorArray.forEach (blacklistErrorText) ->
    if -1 < original_value.indexOf blacklistErrorText
      rowHasBlacklistedError = true
  if rowHasError is true and rowHasBlacklistedError is false
    $newLog.addClass 'alert-log-row'
    $('#errorLogs').prepend $newLog.clone()
  parsedRows.unshift $newLog

worker.setResponseCallback addRows

processRows = ->
  logRowsLength = logRows.length
  if logRowsLength and processingRows is false
    processingRows = true
    worker.postMessage (
      type: 'request'
      body_status:
        eyeopen: $('body').hasClass 'eyeopen'
      msg: logRows.splice(0, logRowsLength)
    )

highlightSyntax = ->
  SyntaxHighlighter.defaults['gutter'] = false
  SyntaxHighlighter.defaults['quick-code'] = false
  SyntaxHighlighter.defaults['toolbar'] = false
  SyntaxHighlighter.highlight()

$ ->
  $('textarea').bind 'paste', (e) ->
    elem = $(this)
    setTimeout ( ->
      $('body').addClass 'hidetextarea'
      parseLogInput elem.val().split('\n')
      return
    ), 0.75 * 1e3
    return
  $('#logs').on 'click', '.log-row-data', (e) ->
    e.preventDefault()
    $(this).next().toggleClass('eyeopened')

prependLogs = ->
  parsedRowsLength = parsedRows.length
  $('#normalLogs').prepend parsedRows.splice(0, parsedRowsLength)

setInterval prependLogs, 0.25 * 1e3

setInterval highlightSyntax, 5e3
