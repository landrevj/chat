App.rooms = App.cable.subscriptions.create "RoomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_room = $("[data-behavior='messages'][data-room-id='#{data.room_id}']")
    if active_room.length > 0
      active_room.append(data.message)
      $("body").scrollTop($("body")[0].scrollHeight);
    else
      $("[data-behavior='room-link'][data-room-id='#{data.room_id}']").css('font-weight', 'bold')

  send_message: (room_id, message) ->
    @perform "send_message", {room_id: room_id, body: message}
    $("body").animate({scrollTop:$("body").scrollHeight}, 1000);
