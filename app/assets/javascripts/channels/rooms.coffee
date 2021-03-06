$(document).on "turbolinks:load", ->
  App.cable.subscriptions.remove(App.rooms) if (App.rooms);
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
        last_message = active_room.find('.message:last-child')
        
        if parseInt(last_message.attr('data-sender'), 10) == data.user_id
          last_message.append "<div class='col-12 body'>" + data.body + "</div>"
        else
          active_room.append(data.message)
        
        $("html, body").scrollTop($("html, body")[0].scrollHeight);
      else
        $("[data-behavior='room-link'][data-room-id='#{data.room_id}']").addClass('unread')

    send_message: (room_id, message) ->
      @perform "send_message", {room_id: room_id, body: message}
