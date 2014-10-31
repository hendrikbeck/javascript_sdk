(exports ? this).MurmioSDK = class MurmioSDK
  constructor: (@_authToken, @widgetId) ->
    $.ajax
      type: 'POST'
      url: 'http://murmio-staging.herokuapp.com/api/v1/tracking'
      dataType: 'json'
      data: {
        event_type: "render-widget",
        widget_id: @widgetId,
        url: document.URL
      }
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
      url: 'http://murmio-staging.herokuapp.com/api/v1/submit'
      dataType: 'json'
      data: xhrArguments
      success: (data, textStatus, jqXHR) =>
        @_ref_id = data
      beforeSend: (xhr) =>
        xhr.setRequestHeader("Authorization", 'Token "' + @_authToken + '"')


collectAnalytics = () ->
  // TODO: add window.location to Analytics context
  browser = window.navigator.userAgent
  os = window.navigator.platform
  screen_width = window.screen.width
  screen_height = window.screen.height
  return { browser: browser, os: os, screen_width: screen_width, screen_height: screen_height }
