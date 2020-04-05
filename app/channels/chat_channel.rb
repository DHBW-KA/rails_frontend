class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    @message = Message.new user: current_user, msg: data["msg"]
    if @message.save
      broadcast_to "chat", msg: MessagesController.render(@message, format: :html, local_variables: {current_user: current_user})
    end
  end
end
