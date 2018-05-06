# $(document).ready ->
#   console.log('beans')
App.rooms = App.cable.subscriptions.create channel: "RoomsChannel", current_stream: $("[data-behavior='messages']").data('room-id'),
  connected: ->
    $('.room-connection').attr('id', 'connected')
    $('.room-connection .status').text('connected')

  disconnected: ->
    $('.room-connection').attr('id', 'disconnected')
    $('.room-connection .status').text('disconnected')

  received: (data) ->
    $('.room-connection').attr('id', 'streaming')
    $('.room-connection .status').text('streaming')
    active_room = $("[data-behavior='messages'][data-room-id='#{data.room_id}']")
    if active_room.length > 0
      active_room.append(data.message)
      $("html, body").scrollTop($("html, body")[0].scrollHeight);
    else
      $("[data-behavior='room-link'][data-room-id='#{data.room_id}']").addClass('unread')

  send_message: (room_id, message) ->
    @perform "send_message", {room_id: room_id, body: message}
