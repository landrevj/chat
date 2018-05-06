$(document).on "turbolinks:load", ->

  $("html, body").scrollTop($("html, body")[0].scrollHeight);  
    
  options = { prevent_repeat: true, prevent_default: true }
  listener = new window.keypress.Listener($('#new_message'), options)

  listener.simple_combo "enter", (e) ->
    $('#new_message').submit()

  $('#new_message').on 'submit', (e) ->
    e.preventDefault()

    room_id = $("[data-behavior='messages']").data('room-id')
    body = $('#message_body')

    App.rooms.send_message(room_id, body.val())

    body.val('')
