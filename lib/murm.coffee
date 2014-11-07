(exports ? this).MurmioSDK = class MurmioSDK
  constructor: (@_authToken, @widgetId, @_endpoint = 'https://preview.murm.io') ->

    $.ajax
      type: 'POST'
      url: @_endpoint + '/api/v1/tracking'
      dataType: 'json'
      data: {
        event_type: "render-widget",
        widget_id: @widgetId,
        url: document.URL
      }
      error: (jqXHR, textStatus, errorThrown) ->
        throw new Error "Couldnt complete request to #{@_endpoint}/api/v1/tracking. Reason given: #{textStatus}"
      beforeSend: (xhr) ->
        xhr.setRequestHeader("Authorization", 'Token "' + _authToken + '"')

  submit: (score, text, user, transaction) =>
    xhrArguments = {
      ref_id: @_ref_id,
      score:  score,
      text: text,
      user:  user,
      transaction: transaction,
      analytics: collectAnalytics(),
      sdk: {
        id: 'javascript'
      }
    }
    $.ajax
      type: 'POST'
      url: @_endpoint + '/api/v1/submit'
      dataType: 'json'
      data: xhrArguments
      success: (data, textStatus, jqXHR) =>
        @_ref_id = data
      error: (jqXHR, textStatus, errorThrown) ->
        throw new Error "Couldnt complete request to #{@_endpoint}/api/v1/submit. Reason given: #{textStatus}"
      beforeSend: (xhr) =>
        xhr.setRequestHeader("Authorization", 'Token "' + @_authToken + '"')


collectAnalytics = () ->
  # TODO: add window.location to Analytics context
  browser = window.navigator.userAgent
  os = window.navigator.platform
  screen_width = window.screen.width
  screen_height = window.screen.height
  return { browser: browser, os: os, screen_width: screen_width, screen_height: screen_height }
