class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_room_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def speak(data)
  #   post = current_user.posts.create!(content: data['message'])
  #   code_number = current_user.current_code_number(post.room)
  #   ActionCable.server.broadcast 'chat_room_channel', message: post.content, created_at: post.created_at, code_number: code_number
  # end
end
