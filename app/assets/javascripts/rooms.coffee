$(document).on "turbolinks:load", ->

  compress_messages()

  if $('[data-behavior="messages"]').length 
    $("html, body").scrollTop($("html, body")[0].scrollHeight);  
    options = { prevent_repeat: true, prevent_default: true }
    listener = new window.keypress.Listener($('#new_message'), options)

    listener.simple_combo "enter", (e) ->
      $('#new_message').submit()

  $('#new_message').on 'submit', (e) ->
    e.preventDefault()

    # validate form input size
    if this.checkValidity() == false
      this.classList.add('was-validated');
    else
      body = $('#message_body')
      room_id = $("[data-behavior='messages']").data('room-id')
      App.rooms.send_message(room_id, body.val())

      $(this).removeClass('was-validated')
      body.val('')

compress_messages = ->
  prev = ''
  $('.message').each (i, el) ->
    if i == 0 
      prev = el
      return
    
    if $(prev).attr('data-sender') == $(el).attr('data-sender')
      $(prev).append $(el).find('.body')
      $(el).prev('hr').remove()
      $(el).remove()
    else
      prev = el
