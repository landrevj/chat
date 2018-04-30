class RoomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.rooms.each do |room|
      stream_from "rooms:#{room.id}"
    end
    if params[:current_stream]
      stream_from "rooms:#{params[:current_stream]}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @room = Room.find(data["room_id"])
    message = @room.messages.create(body: data["body"], user: current_user)
    MessageRelayJob.perform_later(message)
  end
end
