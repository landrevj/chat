class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      message: MessagesController.render(message),
      body: message.body,
      user_id: message.user.id,
      room_id: message.room.id,
    }
  end
end
